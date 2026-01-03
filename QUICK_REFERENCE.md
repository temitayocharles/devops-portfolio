# Quick Reference - Docker Commands

## Pull & Run (Production)

```bash
# Pull from GitHub Container Registry
docker pull ghcr.io/temitayocharles/devops-portfolio:latest

# Run with security hardening
docker run -d \
  --name portfolio \
  -p 3000:8080 \
  --restart unless-stopped \
  --tmpfs /var/cache/nginx:uid=1001,gid=1001,mode=755 \
  --tmpfs /var/run:uid=1001,gid=1001,mode=755 \
  --security-opt no-new-privileges \
  ghcr.io/temitayocharles/devops-portfolio:latest
```

## Build & Push (Multi-Arch)

```bash
# Setup buildx (first time only)
docker buildx create --name multiarch --use

# Build for all platforms
./build-multiarch.sh

# Build and push to GitHub
./build-multiarch.sh --push --tag v1.0.0
```

## GitHub Actions (Automated)

```bash
# Trigger via push
git add .
git commit -m "Update portfolio"
git push origin main

# Trigger via tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## Available Tags

```bash
ghcr.io/temitayocharles/devops-portfolio:latest    # Latest from main
ghcr.io/temitayocharles/devops-portfolio:main      # Main branch
ghcr.io/temitayocharles/devops-portfolio:v1.0.0    # Specific version
ghcr.io/temitayocharles/devops-portfolio:1.0       # Major.minor
ghcr.io/temitayocharles/devops-portfolio:1         # Major version
```

## Platform-Specific

```bash
# Intel/AMD
docker run -d -p 3000:8080 --platform linux/amd64 \
  ghcr.io/temitayocharles/devops-portfolio:latest

# Apple Silicon
docker run -d -p 3000:8080 --platform linux/arm64 \
  ghcr.io/temitayocharles/devops-portfolio:latest

# Raspberry Pi
docker run -d -p 80:8080 --platform linux/arm/v7 \
  ghcr.io/temitayocharles/devops-portfolio:latest
```

## Useful Commands

```bash
# View logs
docker logs portfolio

# Check health
curl http://localhost:3000/health

# Inspect image
docker inspect ghcr.io/temitayocharles/devops-portfolio:latest

# View manifest
docker buildx imagetools inspect ghcr.io/temitayocharles/devops-portfolio:latest

# Stop and remove
docker rm -f portfolio

# Update to latest
docker pull ghcr.io/temitayocharles/devops-portfolio:latest
docker restart portfolio
```
