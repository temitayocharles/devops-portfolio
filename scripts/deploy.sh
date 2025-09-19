#!/bin/bash

# DevOps Portfolio Production Deployment Script
# Complete CI/CD pipeline automation for production deployment

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCKER_IMAGE="temitayocharles/devops-portfolio"
CLUSTER_NAME="devops-portfolio-cluster"
NAMESPACE="devops-portfolio"
REGION="us-east-1"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check dependencies
check_dependencies() {
    log_info "Checking dependencies..."
    
    local deps=("docker" "kubectl" "aws" "terraform" "helm")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_info "Please install the missing dependencies and try again."
        exit 1
    fi
    
    log_success "All dependencies are installed"
}

# Validate environment
validate_environment() {
    log_info "Validating environment..."
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "AWS credentials not configured. Please run 'aws configure'"
        exit 1
    fi
    
    # Check Docker daemon
    if ! docker info &> /dev/null; then
        log_error "Docker daemon is not running"
        exit 1
    fi
    
    # Check if we're in the right directory
    if [ ! -f "$PROJECT_ROOT/package.json" ]; then
        log_error "Not in the project root directory"
        exit 1
    fi
    
    log_success "Environment validation passed"
}

# Run tests
run_tests() {
    log_info "Running tests..."
    
    cd "$PROJECT_ROOT"
    
    # Install dependencies if needed
    if [ ! -d "node_modules" ]; then
        log_info "Installing dependencies..."
        npm ci
    fi
    
    # Run linting
    if npm run lint &> /dev/null; then
        log_success "Linting passed"
    else
        log_warning "Linting failed or no lint script found"
    fi
    
    # Run tests
    if npm test &> /dev/null; then
        log_success "Tests passed"
    else
        log_warning "Tests failed or no test script found"
    fi
    
    # Security audit
    if npm audit --audit-level high; then
        log_success "Security audit passed"
    else
        log_warning "Security vulnerabilities found"
    fi
}

# Build and push Docker image
build_and_push_image() {
    log_info "Building and pushing Docker image..."
    
    cd "$PROJECT_ROOT"
    
    # Get version from package.json or use git commit
    VERSION=$(node -p "require('./package.json').version" 2>/dev/null || git rev-parse --short HEAD)
    FULL_IMAGE_NAME="$DOCKER_IMAGE:$VERSION"
    LATEST_IMAGE_NAME="$DOCKER_IMAGE:latest"
    
    log_info "Building image: $FULL_IMAGE_NAME"
    
    # Build multi-platform image
    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        --target final \
        -t "$FULL_IMAGE_NAME" \
        -t "$LATEST_IMAGE_NAME" \
        --push \
        .
    
    # Security scan
    if command -v trivy &> /dev/null; then
        log_info "Running security scan..."
        trivy image "$FULL_IMAGE_NAME"
    fi
    
    log_success "Image built and pushed: $FULL_IMAGE_NAME"
    echo "VERSION=$VERSION" >> "$GITHUB_ENV" 2>/dev/null || true
}

# Deploy infrastructure with Terraform
deploy_infrastructure() {
    log_info "Deploying infrastructure with Terraform..."
    
    cd "$PROJECT_ROOT/infrastructure/terraform"
    
    # Initialize Terraform
    terraform init -upgrade
    
    # Plan deployment
    terraform plan -out=tfplan
    
    # Apply deployment
    terraform apply tfplan
    
    # Save outputs
    terraform output -json > outputs.json
    
    log_success "Infrastructure deployed successfully"
}

# Configure kubectl
configure_kubectl() {
    log_info "Configuring kubectl..."
    
    # Update kubeconfig
    aws eks update-kubeconfig \
        --region "$REGION" \
        --name "$CLUSTER_NAME"
    
    # Verify connection
    kubectl cluster-info
    
    log_success "kubectl configured successfully"
}

# Deploy to Kubernetes
deploy_to_kubernetes() {
    log_info "Deploying to Kubernetes..."
    
    cd "$PROJECT_ROOT"
    
    # Create namespace if it doesn't exist
    kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -
    
    # Apply Kubernetes manifests
    kubectl apply -f infrastructure/kubernetes/ -n "$NAMESPACE"
    
    # Wait for deployment to be ready
    kubectl rollout status deployment/portfolio-deployment -n "$NAMESPACE" --timeout=300s
    
    # Get service endpoints
    kubectl get services -n "$NAMESPACE"
    
    log_success "Kubernetes deployment completed"
}

# Setup monitoring
setup_monitoring() {
    log_info "Setting up monitoring..."
    
    # Add Prometheus Helm repository
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    
    # Install Prometheus and Grafana
    helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
        --namespace monitoring \
        --create-namespace \
        --set grafana.adminPassword=admin \
        --wait
    
    log_success "Monitoring setup completed"
}

# Run health checks
run_health_checks() {
    log_info "Running health checks..."
    
    # Check pod status
    kubectl get pods -n "$NAMESPACE"
    
    # Check service endpoints
    kubectl get endpoints -n "$NAMESPACE"
    
    # Test application endpoint
    local app_url=$(kubectl get service portfolio-service -n "$NAMESPACE" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    
    if [ -n "$app_url" ]; then
        log_info "Testing application at: http://$app_url"
        
        for i in {1..5}; do
            if curl -f "http://$app_url/health" &> /dev/null; then
                log_success "Health check passed"
                break
            else
                log_warning "Health check failed, retrying in 30s..."
                sleep 30
            fi
        done
    else
        log_warning "Load balancer endpoint not ready yet"
    fi
}

# Generate deployment report
generate_report() {
    log_info "Generating deployment report..."
    
    local report_file="deployment-report-$(date +%Y%m%d-%H%M%S).md"
    
    cat > "$report_file" << EOF
# DevOps Portfolio Deployment Report

**Date:** $(date)
**Environment:** Production
**Deployed By:** $USER
**Git Commit:** $(git rev-parse HEAD)

## Infrastructure
- **Cluster:** $CLUSTER_NAME
- **Region:** $REGION
- **Namespace:** $NAMESPACE

## Services Status
\`\`\`
$(kubectl get services -n "$NAMESPACE" 2>/dev/null || echo "Services not available")
\`\`\`

## Pods Status
\`\`\`
$(kubectl get pods -n "$NAMESPACE" 2>/dev/null || echo "Pods not available")
\`\`\`

## Ingress Status
\`\`\`
$(kubectl get ingress -n "$NAMESPACE" 2>/dev/null || echo "Ingress not available")
\`\`\`

## Docker Images
- **Image:** $DOCKER_IMAGE:$VERSION
- **Registry:** Docker Hub

## URLs
- **Application:** $(kubectl get service portfolio-service -n "$NAMESPACE" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>/dev/null || echo "Pending")
- **Monitoring:** $(kubectl get service prometheus-grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>/dev/null || echo "Not deployed")

## Next Steps
1. Configure DNS records for custom domain
2. Setup SSL certificates
3. Configure monitoring alerts
4. Setup backup procedures

EOF

    log_success "Deployment report generated: $report_file"
}

# Cleanup on failure
cleanup_on_failure() {
    log_error "Deployment failed. Cleaning up..."
    
    # Rollback Kubernetes deployment if it exists
    if kubectl get deployment portfolio-deployment -n "$NAMESPACE" &> /dev/null; then
        kubectl rollout undo deployment/portfolio-deployment -n "$NAMESPACE"
    fi
    
    # Remove failed resources
    kubectl delete -f infrastructure/kubernetes/ -n "$NAMESPACE" --ignore-not-found=true
}

# Main deployment function
main() {
    local start_time=$(date +%s)
    
    log_info "Starting DevOps Portfolio deployment..."
    log_info "Timestamp: $(date)"
    
    # Trap errors for cleanup
    trap cleanup_on_failure ERR
    
    # Run deployment steps
    check_dependencies
    validate_environment
    run_tests
    build_and_push_image
    
    # Only deploy infrastructure in production
    if [ "${DEPLOY_INFRASTRUCTURE:-false}" = "true" ]; then
        deploy_infrastructure
        configure_kubectl
    else
        configure_kubectl
    fi
    
    deploy_to_kubernetes
    
    # Setup monitoring if requested
    if [ "${SETUP_MONITORING:-false}" = "true" ]; then
        setup_monitoring
    fi
    
    run_health_checks
    generate_report
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    log_success "Deployment completed successfully in ${duration}s!"
    log_info "Check the deployment report for details"
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi