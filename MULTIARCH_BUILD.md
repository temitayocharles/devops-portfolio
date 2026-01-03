# 🐳 Multi-Architecture Docker Build Guide

## Overview

This portfolio supports **multi-architecture** Docker builds for:
- `linux/amd64` - Intel/AMD 64-bit (x86_64)
- `linux/arm64` - Apple Silicon (M1/M2/M3), AWS Graviton, Raspberry Pi 4
- `linux/arm/v7` - Raspberry Pi 3, older ARM devices

## Quick Start

### Local Multi-Arch Build (Testing)

```bash
# Create and use buildx builder
docker buildx create --name multiarch --use
docker buildx inspect --bootstrap

# Build for all platforms (no push)
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t ghcr.io/temitayocharles/devops-portfolio:latest \
  .

# Build and load for your current platform only
docker buildx build \
  --platform linux/amd64 \
  -t portfolio:latest \
  --load \
  .
```

### Using the Build Script

```bash
# Build locally (test)
./build-multiarch.sh

# Build with custom tag
./build-multiarch.sh --tag v1.0.0

# Build and push to registry
./build-multiarch.sh --push --tag v1.0.0
```

## GitHub Container Registry Setup

### 1. Enable GitHub Packages

The repository is already configured to push to `ghcr.io/temitayocharles/devops-portfolio`

### 2. Automatic Builds (GitHub Actions)

The workflow automatically builds and pushes on:
- ✅ Push to `main` branch
- ✅ New tags (e.g., `v1.0.0`)
- ✅ Manual workflow dispatch

**No secrets needed!** Uses `GITHUB_TOKEN` automatically.

### 3. Manual Push to GitHub

```bash
# Login to GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# Or create a Personal Access Token (PAT) with 'write:packages' permission
# https://github.com/settings/tokens/new

# Build and push
./build-multiarch.sh --push --tag v1.0.0
```

## CI/CD Workflow

The GitHub Actions workflow (`.github/workflows/docker-build-push.yml`) will:

1. ✅ **Build** for multiple architectures
2. ✅ **Tag** appropriately:
   - `latest` (for main branch)
   - `main` (branch name)
   - `v1.0.0` (semver from git tags)
   - `1.0` and `1` (major.minor and major)
   - `main-abc1234` (branch-sha)

3. ✅ **Scan** for vulnerabilities with Trivy
4. ✅ **Push** to GitHub Container Registry
5. ✅ **Attest** build provenance

## Triggering Builds

### Via Git Push

```bash
# Push to main branch
git add .
git commit -m "Update portfolio"
git push origin main

# This triggers a build and push to:
# ghcr.io/temitayocharles/devops-portfolio:latest
# ghcr.io/temitayocharles/devops-portfolio:main
```

### Via Git Tag (Versioned Release)

```bash
# Create and push a version tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# This triggers a build and push to:
# ghcr.io/temitayocharles/devops-portfolio:v1.0.0
# ghcr.io/temitayocharles/devops-portfolio:1.0
# ghcr.io/temitayocharles/devops-portfolio:1
# ghcr.io/temitayocharles/devops-portfolio:latest
```

### Via GitHub UI

1. Go to **Actions** tab
2. Select **"Build and Push Multi-Arch Docker Image"**
3. Click **"Run workflow"**
4. Select branch and run

## Pulling Images

### From GitHub Container Registry

```bash
# Pull latest
docker pull ghcr.io/temitayocharles/devops-portfolio:latest

# Pull specific version
docker pull ghcr.io/temitayocharles/devops-portfolio:v1.0.0

# Pull specific architecture
docker pull --platform linux/arm64 ghcr.io/temitayocharles/devops-portfolio:latest
```

### Run on Different Platforms

```bash
# On x86_64 / Intel / AMD
docker run -d -p 3000:8080 \
  --name portfolio \
  ghcr.io/temitayocharles/devops-portfolio:latest

# On Apple Silicon (M1/M2/M3)
docker run -d -p 3000:8080 \
  --platform linux/arm64 \
  --name portfolio \
  ghcr.io/temitayocharles/devops-portfolio:latest

# On Raspberry Pi 4 (ARM64)
docker run -d -p 80:8080 \
  --name portfolio \
  ghcr.io/temitayocharles/devops-portfolio:latest

# On Raspberry Pi 3 (ARMv7)
docker run -d -p 80:8080 \
  --platform linux/arm/v7 \
  --name portfolio \
  ghcr.io/temitayocharles/devops-portfolio:latest
```

## Making Images Public

By default, GitHub packages are private. To make them public:

1. Go to: https://github.com/temitayocharles/devops-portfolio/pkgs/container/devops-portfolio
2. Click **"Package settings"**
3. Scroll to **"Danger Zone"**
4. Click **"Change visibility"**
5. Select **"Public"**
6. Confirm

## Image Details

### Manifest Inspection

```bash
# View multi-arch manifest
docker buildx imagetools inspect ghcr.io/temitayocharles/devops-portfolio:latest

# Example output:
# Name:      ghcr.io/temitayocharles/devops-portfolio:latest
# MediaType: application/vnd.docker.distribution.manifest.list.v2+json
# Digest:    sha256:abc123...
#
# Manifests:
#   Name:      ghcr.io/.../devops-portfolio:latest@sha256:def456...
#   MediaType: application/vnd.docker.distribution.manifest.v2+json
#   Platform:  linux/amd64
#
#   Name:      ghcr.io/.../devops-portfolio:latest@sha256:ghi789...
#   MediaType: application/vnd.docker.distribution.manifest.v2+json
#   Platform:  linux/arm64
#
#   Name:      ghcr.io/.../devops-portfolio:latest@sha256:jkl012...
#   MediaType: application/vnd.docker.distribution.manifest.v2+json
#   Platform:  linux/arm/v7
```

### Size Comparison

```bash
# Check image sizes
docker buildx imagetools inspect ghcr.io/temitayocharles/devops-portfolio:latest --raw | \
  jq '.manifests[] | {platform: .platform.architecture, size: .size}'
```

## Security Scanning

Images are automatically scanned for vulnerabilities:

```bash
# Manual scan with Trivy
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image \
  ghcr.io/temitayocharles/devops-portfolio:latest
```

Results appear in:
- **GitHub Security** tab
- **Actions** workflow logs

## Advanced Usage

### Build for Specific Platform Only

```bash
# AMD64 only
docker buildx build \
  --platform linux/amd64 \
  -t portfolio:amd64 \
  --load \
  .

# ARM64 only (Apple Silicon)
docker buildx build \
  --platform linux/arm64 \
  -t portfolio:arm64 \
  --load \
  .
```

### Custom Registry

```bash
# Use custom registry
REGISTRY=docker.io GITHUB_REPOSITORY=yourusername/portfolio \
  ./build-multiarch.sh --push --tag v1.0.0
```

### Build with Cache

```bash
# Use GitHub Actions cache
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --cache-from type=gha \
  --cache-to type=gha,mode=max \
  -t ghcr.io/temitayocharles/devops-portfolio:latest \
  --push \
  .
```

## Troubleshooting

### QEMU Not Available

```bash
# Install QEMU for cross-platform builds
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

### Builder Not Found

```bash
# Recreate builder
docker buildx rm multiarch
docker buildx create --name multiarch --use
docker buildx inspect --bootstrap
```

### Push Permission Denied

```bash
# Verify authentication
docker login ghcr.io

# Verify token has write:packages permission
# https://github.com/settings/tokens
```

## Performance Tips

1. **Use cache** - GitHub Actions cache speeds up builds significantly
2. **Build locally first** - Test without `--push` before pushing
3. **Parallel builds** - Buildx builds all platforms in parallel
4. **Layer caching** - Optimize Dockerfile for better caching

## Next Steps

1. ✅ Push this code to GitHub
2. ✅ Workflow will automatically build and push
3. ✅ Check Actions tab for build status
4. ✅ Make package public (if desired)
5. ✅ Pull and run on any platform!

---

**Multi-arch build ready! 🚀**
