# Multi-stage build for ultra-optimized production container
# Stage 1: Build and prepare assets
FROM nginx:1.25-alpine AS builder

# Install security updates and remove cache
RUN apk update && \
    apk upgrade --no-cache && \
    rm -rf /var/cache/apk/* /tmp/*

# Copy all static files efficiently
COPY --chown=1001:1001 *.html /tmp/html/
COPY --chown=1001:1001 *.css /tmp/html/
COPY --chown=1001:1001 *.js /tmp/html/
COPY --chown=1001:1001 *.json /tmp/html/
COPY --chown=1001:1001 *.txt /tmp/html/
COPY --chown=1001:1001 *.ico /tmp/html/
COPY --chown=1001:1001 css/ /tmp/html/css/
COPY --chown=1001:1001 js/ /tmp/html/js/
COPY --chown=1001:1001 assets/ /tmp/html/assets/
COPY --chown=1001:1001 images/ /tmp/html/images/
COPY --chown=1001:1001 scripts/ /tmp/html/scripts/

# Remove unnecessary files to minimize image size
RUN find /tmp/html -type f -name "*.md" -delete && \
    find /tmp/html -type f -name ".DS_Store" -delete && \
    find /tmp/html -type f -name "Thumbs.db" -delete

# Stage 2: Production with distroless (ultra-minimal)
FROM nginx:1.25-alpine AS production

# Build arguments for multi-arch
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

# Labels for OCI compliance and metadata
LABEL org.opencontainers.image.title="DevOps Portfolio"
LABEL org.opencontainers.image.description="Production-ready DevOps portfolio with enterprise security"
LABEL org.opencontainers.image.authors="Temitayo Charles <temitayo_charles@yahoo.com>"
LABEL org.opencontainers.image.vendor="Temitayo Charles"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://github.com/temitayocharles/devops-portfolio"
LABEL org.opencontainers.image.source="https://github.com/temitayocharles/devops-portfolio"
LABEL org.opencontainers.image.documentation="https://github.com/temitayocharles/devops-portfolio#readme"
LABEL org.opencontainers.image.version="2.0.0"
LABEL maintainer="Temitayo Charles <tayocharlesak@gmail.com>"
LABEL platform="${TARGETPLATFORM}"
LABEL build.date="${BUILD_DATE}"

# Install security updates and required tools
RUN apk update && apk upgrade && apk add --no-cache \
    curl \
    ca-certificates \
    dumb-init \
    && rm -rf /var/cache/apk/*

# Create non-root user for nginx
RUN addgroup -g 1001 -S nginx-user && \
    adduser -S nginx-user -u 1001 -G nginx-user

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files from builder stage
COPY --from=builder --chown=nginx-user:nginx-user /tmp/html/ /usr/share/nginx/html/

# Create necessary directories with proper permissions
RUN mkdir -p /var/cache/nginx/client_temp \
             /var/cache/nginx/proxy_temp \
             /var/cache/nginx/fastcgi_temp \
             /var/cache/nginx/uwsgi_temp \
             /var/cache/nginx/scgi_temp \
             /var/run && \
    chown -R nginx-user:nginx-user /var/cache/nginx /var/run /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    # Make nginx.pid writable
    touch /var/run/nginx.pid && \
    chown nginx-user:nginx-user /var/run/nginx.pid

# Switch to non-root user
USER nginx-user

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Use dumb-init for proper signal handling
ENTRYPOINT ["dumb-init", "--"]

# Start nginx
CMD ["nginx", "-g", "daemon off;"]