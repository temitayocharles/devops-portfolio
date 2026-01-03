# 🚀 Getting Started - Push to GitHub & Auto-Build

## Step 1: Commit Your Changes

```bash
cd /Users/charlie/Desktop/portfolio-containerizing

# Check status
git status

# Add all files
git add .

# Commit
git commit -m "Add multi-arch Docker build with GitHub Actions

- Multi-architecture support (amd64, arm64, armv7)
- GitHub Container Registry integration
- Automated CI/CD workflow
- Security scanning with Trivy
- Production-ready nginx configuration
- Health checks and monitoring
"

# Push to GitHub
git push origin main
```

## Step 2: Verify GitHub Actions

1. Go to: https://github.com/temitayocharles/devops-portfolio/actions
2. Watch the workflow run
3. It will automatically build and push to `ghcr.io/temitayocharles/devops-portfolio:latest`

## Step 3: Make Package Public (Optional)

1. After first build, go to: https://github.com/temitayocharles/devops-portfolio/packages
2. Click on **devops-portfolio** package
3. Click **Package settings**
4. Under **Danger Zone**, click **Change visibility**
5. Select **Public**
6. Confirm

## Step 4: Pull and Test

```bash
# Pull from GitHub Container Registry
docker pull ghcr.io/temitayocharles/devops-portfolio:latest

# Run it
docker run -d -p 3000:8080 \
  --name portfolio-prod \
  --tmpfs /var/cache/nginx:uid=1001,gid=1001 \
  --tmpfs /var/run:uid=1001,gid=1001 \
  --security-opt no-new-privileges \
  ghcr.io/temitayocharles/devops-portfolio:latest

# Test
curl http://localhost:3000/health
open http://localhost:3000
```

## Step 5: Create a Release (Optional)

```bash
# Create a version tag
git tag -a v1.0.0 -m "Release version 1.0.0 - Multi-arch support"

# Push the tag
git push origin v1.0.0

# This creates:
# - ghcr.io/temitayocharles/devops-portfolio:v1.0.0
# - ghcr.io/temitayocharles/devops-portfolio:1.0
# - ghcr.io/temitayocharles/devops-portfolio:1
# - ghcr.io/temitayocharles/devops-portfolio:latest
```

## What Happens Automatically

✅ **On every push to main:**
- Builds for amd64, arm64, armv7
- Scans for vulnerabilities
- Pushes to GitHub Container Registry
- Tags as `latest` and `main`

✅ **On every tag (v*):**
- Creates versioned releases
- Semantic versioning tags (major, major.minor, full)
- Updates latest tag

✅ **Security scanning:**
- Trivy scans for vulnerabilities
- Results in Security tab
- SARIF upload to GitHub

## Manual Local Build (Optional)

```bash
# Test multi-arch build locally
./build-multiarch.sh

# Build and push manually
./build-multiarch.sh --push --tag v1.0.0
```

## Verify Multi-Arch

```bash
# Check manifest
docker buildx imagetools inspect ghcr.io/temitayocharles/devops-portfolio:latest

# Should show:
# - linux/amd64
# - linux/arm64
# - linux/arm/v7
```

## Update README Badge (Optional)

Add this to your README.md:

```markdown
[![Docker Image](https://ghcr-badge.egpl.dev/temitayocharles/devops-portfolio/latest_tag?color=%2344cc11&ignore=latest&label=ghcr.io&trim=)](https://github.com/temitayocharles/devops-portfolio/pkgs/container/devops-portfolio)
[![Docker Pulls](https://ghcr-badge.egpl.dev/temitayocharles/devops-portfolio/size)](https://github.com/temitayocharles/devops-portfolio/pkgs/container/devops-portfolio)
```

## Troubleshooting

**Workflow fails?**
- Check Actions tab for logs
- Verify GITHUB_TOKEN permissions (should be automatic)

**Can't pull image?**
- Make package public (see Step 3)
- Or authenticate: `docker login ghcr.io -u USERNAME`

**Build takes too long?**
- Normal! Multi-arch builds take 5-10 minutes
- Subsequent builds are faster (cache)

---

**You're all set! 🎉**

Just push to GitHub and the magic happens automatically!
