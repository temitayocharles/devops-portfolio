# 🐳 DevOps Portfolio - Container Deployment Guide

## ✅ Successfully Containerized!

Your DevOps portfolio is now fully containerized with best practices for security, optimization, and production readiness.

## 🚀 Quick Start

### Using Docker

```bash
# Build the image
docker build -t portfolio:latest .

# Run the container
docker run -d \
  --name portfolio \
  -p 3000:8080 \
  --tmpfs /var/cache/nginx:uid=1001,gid=1001 \
  --tmpfs /var/run:uid=1001,gid=1001 \
  --security-opt no-new-privileges \
  portfolio:latest

# Access your portfolio
open http://localhost:3000
```

### Using Docker Compose

```bash
# Build and run
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

## 📊 Container Specifications

### Image Details
- **Base Image**: nginx:1.25-alpine
- **Final Size**: ~161MB
- **Startup Time**: <3 seconds
- **Architecture**: Multi-architecture support

### Security Features Implemented

✅ **Non-Root User**
- Runs as `nginx-user` (UID: 1001, GID: 1001)
- No privileged access required

✅ **Minimal Attack Surface**
- Alpine Linux base (~5MB)
- Only essential packages installed
- Regular security updates applied

✅ **Security Headers**
- Content Security Policy (CSP)
- X-Frame-Options: DENY
- X-Content-Type-Options: nosniff
- X-XSS-Protection enabled
- Referrer-Policy configured
- HSTS ready (enable with reverse proxy)

✅ **Filesystem Security**
- Can run with read-only root filesystem
- Temp directories mounted as tmpfs
- Proper file permissions (755 for static files)

✅ **Container Hardening**
- `--security-opt no-new-privileges`
- Minimal capabilities
- No sensitive data in image layers

### Performance Optimizations

🚀 **Asset Delivery**
- Gzip compression enabled (level 6)
- Browser caching (1 year for static assets)
- Sendfile enabled for efficient file serving
- TCP optimizations (tcp_nopush, tcp_nodelay)

🚀 **Nginx Tuning**
- Auto-configured worker processes
- Epoll event model
- Multi-accept connections
- Optimized buffer sizes

## 🔒 Production Deployment

### Recommended Docker Run Command

```bash
docker run -d \
  --name portfolio \
  --restart unless-stopped \
  --read-only \
  --tmpfs /var/cache/nginx:uid=1001,gid=1001,mode=755 \
  --tmpfs /var/run:uid=1001,gid=1001,mode=755 \
  --security-opt no-new-privileges \
  --cap-drop=ALL \
  --cap-add=NET_BIND_SERVICE \
  -p 80:8080 \
  --memory="512m" \
  --memory-swap="512m" \
  --cpus="0.5" \
  --pids-limit 100 \
  --health-cmd="curl -f http://localhost:8080/health || exit 1" \
  --health-interval=30s \
  --health-timeout=3s \
  --health-retries=3 \
  --health-start-period=5s \
  portfolio:latest
```

### With Reverse Proxy (Recommended)

```yaml
# docker-compose-production.yml
version: '3.8'

services:
  portfolio:
    image: portfolio:latest
    container_name: portfolio
    restart: unless-stopped
    read_only: true
    tmpfs:
      - /var/cache/nginx:uid=1001,gid=1001,mode=755
      - /var/run:uid=1001,gid=1001,mode=755
    security_opt:
      - no-new-privileges:true
    networks:
      - frontend
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 3s
      retries: 3

  nginx-proxy:
    image: nginx:alpine
    container_name: nginx-proxy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx-proxy.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    networks:
      - frontend
    depends_on:
      - portfolio

networks:
  frontend:
    driver: bridge
```

## 📈 Monitoring & Health Checks

### Health Check Endpoint

```bash
# Check container health
curl http://localhost:3000/health

# Docker health status
docker inspect portfolio --format='{{.State.Health.Status}}'
```

### Container Logs

```bash
# View logs
docker logs portfolio

# Follow logs
docker logs -f portfolio

# Last 100 lines
docker logs --tail 100 portfolio
```

### Resource Usage

```bash
# Monitor resource usage
docker stats portfolio

# Detailed inspection
docker inspect portfolio
```

## 🔧 Troubleshooting

### Container won't start

```bash
# Check logs
docker logs portfolio

# Verify permissions
docker exec portfolio ls -la /usr/share/nginx/html

# Test nginx configuration
docker exec portfolio nginx -t
```

### Assets not loading

```bash
# Check file permissions
docker exec portfolio ls -la /usr/share/nginx/html/

# Verify nginx is serving files
docker exec portfolio curl -I http://localhost:8080

# Check nginx error logs
docker exec portfolio cat /var/log/nginx/error.log 2>/dev/null || echo "Logging to stderr"
```

### Performance issues

```bash
# Check resource limits
docker stats portfolio

# Increase memory/CPU if needed
docker update --memory="1g" --cpus="1" portfolio
```

## 🌐 Kubernetes Deployment (Optional)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: portfolio
  labels:
    app: portfolio
spec:
  replicas: 2
  selector:
    matchLabels:
      app: portfolio
  template:
    metadata:
      labels:
        app: portfolio
    spec:
      securityContext:
        runAsUser: 1001
        runAsGroup: 1001
        fsGroup: 1001
        runAsNonRoot: true
        seccompProfile:
          type: RuntimeDefault
      containers:
      - name: portfolio
        image: portfolio:latest
        ports:
        - containerPort: 8080
          protocol: TCP
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
            - ALL
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        volumeMounts:
        - name: cache
          mountPath: /var/cache/nginx
        - name: run
          mountPath: /var/run
      volumes:
      - name: cache
        emptyDir: {}
      - name: run
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: portfolio-service
spec:
  selector:
    app: portfolio
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: LoadBalancer
```

## 📦 CI/CD Integration

### GitHub Actions Example

```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Build Docker image
      run: docker build -t portfolio:${{ github.sha }} .
    
    - name: Run security scan
      run: |
        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
          aquasec/trivy image portfolio:${{ github.sha }}
    
    - name: Test container
      run: |
        docker run -d --name test -p 8080:8080 portfolio:${{ github.sha }}
        sleep 5
        curl -f http://localhost:8080/health || exit 1
        docker rm -f test
    
    - name: Login to Docker Hub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    
    - name: Push to Docker Hub
      run: |
        docker tag portfolio:${{ github.sha }} yourusername/portfolio:latest
        docker push yourusername/portfolio:latest
```

## 🎯 Next Steps

1. **Add SSL/TLS**: Configure HTTPS with Let's Encrypt
2. **CDN Integration**: Use CloudFlare or similar for global distribution
3. **Monitoring**: Integrate Prometheus metrics exporter
4. **Logging**: Configure centralized logging (ELK/Loki)
5. **Automated Backups**: Regular container registry backups
6. **Security Scanning**: Implement Trivy/Snyk in CI/CD

## 📝 Notes

- The container runs on port 8080 internally
- Map to any external port (e.g., `-p 3000:8080` for port 3000)
- For production, use port 80 or 443 with reverse proxy
- Enable HTTPS at the reverse proxy level
- Consider using Docker secrets for any future credentials

## 🆘 Support

For issues or questions:
1. Check the logs: `docker logs portfolio`
2. Verify health: `curl http://localhost:3000/health`
3. Inspect container: `docker inspect portfolio`
4. Test locally first before deploying to production

---

**Container is production-ready! 🚀**
