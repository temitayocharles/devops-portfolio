# Multi-stage build for optimized production container
# Multi-stage build for optimized production container
FROM nginx:1.25-alpine AS base

# Install security updates
RUN apk update && apk upgrade --no-cache

# Stage 2: Production
FROM nginx:1.25-alpine

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
LABEL org.opencontainers.image.version="1.0.0"
LABEL maintainer="Temitayo Charles <temitayo_charles@yahoo.com>"

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

# Copy all static files to nginx html directory
COPY --chown=nginx-user:nginx-user *.html /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.css /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.js /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.json /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.txt /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.ico /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.pdf /usr/share/nginx/html/
COPY --chown=nginx-user:nginx-user *.sh /usr/share/nginx/html/

# Copy directories
COPY --chown=nginx-user:nginx-user css/ /usr/share/nginx/html/css/
COPY --chown=nginx-user:nginx-user js/ /usr/share/nginx/html/js/
COPY --chown=nginx-user:nginx-user assets/ /usr/share/nginx/html/assets/
COPY --chown=nginx-user:nginx-user images/ /usr/share/nginx/html/images/
COPY --chown=nginx-user:nginx-user scripts/ /usr/share/nginx/html/scripts/

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