#!/bin/bash

# Multi-Architecture Docker Build Script
# Builds for AMD64, ARM64, and ARMv7 platforms

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="portfolio"
REGISTRY="${REGISTRY:-ghcr.io}"
REPO="${GITHUB_REPOSITORY:-temitayocharles/devops-portfolio}"
PLATFORMS="linux/amd64,linux/arm64,linux/arm/v7"

echo -e "${GREEN}🐳 Multi-Architecture Docker Build${NC}"
echo "=================================="
echo "Image: ${REGISTRY}/${REPO}"
echo "Platforms: ${PLATFORMS}"
echo ""

# Check if buildx is available
if ! docker buildx version > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker Buildx is not available${NC}"
    echo "Please install Docker Desktop or Docker with Buildx support"
    exit 1
fi

# Create buildx builder if it doesn't exist
if ! docker buildx inspect multiarch > /dev/null 2>&1; then
    echo -e "${YELLOW}📦 Creating buildx builder...${NC}"
    docker buildx create --name multiarch --driver docker-container --use
    docker buildx inspect --bootstrap
else
    echo -e "${GREEN}✅ Using existing buildx builder${NC}"
    docker buildx use multiarch
fi

# Parse arguments
PUSH=false
TAG="latest"

while [[ $# -gt 0 ]]; do
    case $1 in
        --push)
            PUSH=true
            shift
            ;;
        --tag)
            TAG="$2"
            shift 2
            ;;
        --registry)
            REGISTRY="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Build command
BUILD_CMD="docker buildx build"
BUILD_CMD="$BUILD_CMD --platform ${PLATFORMS}"
BUILD_CMD="$BUILD_CMD -t ${REGISTRY}/${REPO}:${TAG}"
BUILD_CMD="$BUILD_CMD -t ${REGISTRY}/${REPO}:latest"

# Add labels
BUILD_CMD="$BUILD_CMD --label org.opencontainers.image.title=DevOps Portfolio"
BUILD_CMD="$BUILD_CMD --label org.opencontainers.image.description=Production-ready DevOps portfolio"
BUILD_CMD="$BUILD_CMD --label org.opencontainers.image.source=https://github.com/${REPO}"
BUILD_CMD="$BUILD_CMD --label org.opencontainers.image.version=${TAG}"

if [ "$PUSH" = true ]; then
    BUILD_CMD="$BUILD_CMD --push"
    echo -e "${YELLOW}🚀 Building and pushing to registry...${NC}"
else
    BUILD_CMD="$BUILD_CMD --load"
    echo -e "${YELLOW}🔨 Building locally (no push)...${NC}"
fi

BUILD_CMD="$BUILD_CMD ."

# Execute build
echo ""
echo -e "${GREEN}Executing: ${BUILD_CMD}${NC}"
echo ""

eval $BUILD_CMD

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Build successful!${NC}"
    echo ""
    echo "Image tags:"
    echo "  - ${REGISTRY}/${REPO}:${TAG}"
    echo "  - ${REGISTRY}/${REPO}:latest"
    echo ""
    echo "Platforms:"
    echo "  - linux/amd64 (Intel/AMD 64-bit)"
    echo "  - linux/arm64 (Apple Silicon, AWS Graviton)"
    echo "  - linux/arm/v7 (Raspberry Pi)"
    echo ""
    
    if [ "$PUSH" = true ]; then
        echo -e "${GREEN}Image pushed to registry${NC}"
        echo ""
        echo "Pull with:"
        echo "  docker pull ${REGISTRY}/${REPO}:${TAG}"
    else
        echo -e "${YELLOW}To push to registry, run with --push flag${NC}"
        echo ""
        echo "Example:"
        echo "  ./build-multiarch.sh --push --tag v1.0.0"
    fi
else
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi
