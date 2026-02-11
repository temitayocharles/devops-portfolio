# Start Here

This guide is the shortest path to running, deploying, and maintaining this repo. It is written for future‑you with zero context. Follow in order.

## 1. What This Repo Is
See README for the purpose and context.

## 2. Repo Map (What Lives Where)
- [README.md](README.md): High‑level overview.
- Documentation: [GETTING_STARTED.md](GETTING_STARTED.md), [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md), [PORTFOLIO_NARRATIVE_TRANSFORMATION.md](PORTFOLIO_NARRATIVE_TRANSFORMATION.md), [README.md](README.md), [START_HERE.md](START_HERE.md), [blog-strategy.md](blog-strategy.md)
- Scripts: [build-multiarch.sh](build-multiarch.sh), [scripts/deploy.sh](scripts/deploy.sh), [scripts/optimize.sh](scripts/optimize.sh)

## 3. Quick Local Run (Docker Compose)
Use Docker Compose for a fast local spin‑up.
- Compose files: [docker-compose.yml](docker-compose.yml)
- Typical commands: `docker compose up -d`, `docker compose logs -f`, `docker compose down`.

## 4. Container Build
Dockerfiles available:
- [Dockerfile](Dockerfile)
Typical build: `docker build -t <image>:<tag> -f <Dockerfile> .`

## 5. Config and Secrets
Non‑secret config examples:
- [.env.example](.env.example)
Secrets should be stored in Vault; keep only examples here.

## 7. CI/CD
Workflows in this repo:
- [.github/workflows/deploy-to-render.yml](.github/workflows/deploy-to-render.yml)
- [.github/workflows/docker-build-push.yml](.github/workflows/docker-build-push.yml)
- [.github/workflows/ui-smoke.yml](.github/workflows/ui-smoke.yml)
If this repo consumes shared workflows, see the shared workflows repo.

## 8. Troubleshooting
- If a build fails, check README and CI logs first.
- Confirm your local env vars match `.env.example`.
- For Kubernetes: check `kubectl get pods` and `kubectl describe` first.

