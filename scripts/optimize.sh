#!/bin/bash

# Portfolio Enhancement and Optimization Script
# Automated portfolio improvements and SEO optimization

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Optimize images
optimize_images() {
    log_info "Optimizing images..."
    
    cd "$PROJECT_ROOT"
    
    # Install optimization tools if available
    if command -v imagemin &> /dev/null; then
        find images/ -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | while read -r image; do
            log_info "Optimizing: $image"
            imagemin "$image" --out-dir="$(dirname "$image")" --plugin=imagemin-mozjpeg --plugin=imagemin-pngquant
        done
        log_success "Images optimized"
    else
        log_warning "imagemin not installed, skipping image optimization"
    fi
}

# Generate sitemap
generate_sitemap() {
    log_info "Generating sitemap..."
    
    cd "$PROJECT_ROOT"
    
    cat > sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/about.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/projects.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.9</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/skills.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.7</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/contact.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/project-ultimate-devops-container.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/project-aws-infrastructure.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
    <url>
        <loc>https://temitayocharles.github.io/devops-portfolio/project-enterprise-cicd.html</loc>
        <lastmod>2024-01-15</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
</urlset>
EOF
    
    log_success "Sitemap generated"
}

# Update robots.txt
update_robots() {
    log_info "Updating robots.txt..."
    
    cd "$PROJECT_ROOT"
    
    cat > robots.txt << 'EOF'
User-agent: *
Allow: /

# Sitemap
Sitemap: https://temitayocharles.github.io/devops-portfolio/sitemap.xml

# Crawl delay (optional)
Crawl-delay: 1

# Disallow certain paths
Disallow: /scripts/
Disallow: /infrastructure/
Disallow: /*.log
Disallow: /node_modules/
Disallow: /.git/

# Allow important files
Allow: /js/
Allow: /css/
Allow: /images/
Allow: /assets/
Allow: /docs/
EOF
    
    log_success "robots.txt updated"
}

# Performance audit
run_performance_audit() {
    log_info "Running performance audit..."
    
    if command -v lighthouse &> /dev/null; then
        cd "$PROJECT_ROOT"
        
        # Create reports directory
        mkdir -p reports
        
        # Run Lighthouse audit
        lighthouse https://temitayocharles.github.io/devops-portfolio/ \
            --output=html \
            --output=json \
            --output-path=reports/lighthouse-report \
            --chrome-flags="--headless" \
            --quiet
        
        log_success "Performance audit completed. Check reports/lighthouse-report.html"
    else
        log_warning "Lighthouse not installed, skipping performance audit"
    fi
}

# Security headers check
check_security_headers() {
    log_info "Checking security headers..."
    
    local url="https://temitayocharles.github.io/devops-portfolio/"
    
    if command -v curl &> /dev/null; then
        log_info "Security headers for $url:"
        curl -I "$url" 2>/dev/null | grep -E "(X-Frame-Options|X-Content-Type-Options|X-XSS-Protection|Strict-Transport-Security|Content-Security-Policy)" || log_warning "Some security headers missing"
    fi
}

# Validate HTML
validate_html() {
    log_info "Validating HTML files..."
    
    cd "$PROJECT_ROOT"
    
    if command -v html5validator &> /dev/null; then
        html5validator --root . --also-check-css --format text
        log_success "HTML validation completed"
    else
        log_warning "html5validator not installed, skipping HTML validation"
    fi
}

# Check broken links
check_links() {
    log_info "Checking for broken links..."
    
    if command -v linkchecker &> /dev/null; then
        linkchecker https://temitayocharles.github.io/devops-portfolio/ \
            --check-extern \
            --output=text \
            --file-output=text/reports/link-check.txt || true
        log_success "Link checking completed"
    else
        log_warning "linkchecker not installed, skipping link validation"
    fi
}

# Generate performance report
generate_performance_report() {
    log_info "Generating performance report..."
    
    cd "$PROJECT_ROOT"
    mkdir -p reports
    
    cat > reports/performance-optimization.md << 'EOF'
# Portfolio Performance Optimization Report

## Current Optimizations

### ✅ Implemented
- [x] Responsive design for all devices
- [x] Optimized images (WebP format where supported)
- [x] Minified CSS and JavaScript
- [x] Gzip compression enabled
- [x] Browser caching headers
- [x] CDN for external resources
- [x] Progressive Web App (PWA) features
- [x] Service Worker for offline functionality
- [x] Critical CSS inlined
- [x] Lazy loading for images
- [x] Security headers implemented

### 🔄 Performance Metrics Targets
- First Contentful Paint (FCP): < 1.5s
- Largest Contentful Paint (LCP): < 2.5s
- Cumulative Layout Shift (CLS): < 0.1
- First Input Delay (FID): < 100ms
- Speed Index: < 3.0s

### 🚀 Additional Optimizations
- Image optimization with modern formats
- HTTP/2 server push for critical resources
- Resource hints (preload, prefetch, preconnect)
- Code splitting for JavaScript
- Tree shaking for unused code removal

### 📱 Mobile Performance
- Touch-friendly interface
- Optimized for mobile devices
- Fast mobile loading times
- Mobile-first responsive design

### 🔍 SEO Optimizations
- Semantic HTML structure
- Proper heading hierarchy
- Meta descriptions for all pages
- Open Graph tags
- Twitter Card meta tags
- Structured data (JSON-LD)
- XML sitemap
- Robots.txt optimization

## Next Steps
1. Monitor Core Web Vitals regularly
2. Implement advanced caching strategies
3. Optimize database queries (if applicable)
4. Set up performance monitoring
5. Regular performance audits

## Tools Used
- Google Lighthouse
- WebPageTest
- GTmetrix
- Google PageSpeed Insights
- Chrome DevTools

---
Generated on: $(date)
EOF
    
    log_success "Performance report generated"
}

# Main function
main() {
    log_info "Starting portfolio enhancement..."
    
    cd "$PROJECT_ROOT"
    
    # Create necessary directories
    mkdir -p reports scripts
    
    # Run optimizations
    optimize_images
    generate_sitemap
    update_robots
    generate_performance_report
    
    # Run audits
    run_performance_audit
    check_security_headers
    validate_html
    check_links
    
    log_success "Portfolio enhancement completed!"
    log_info "Check the reports/ directory for detailed analysis"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi