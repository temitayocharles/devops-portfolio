# Use official Nginx image
FROM nginx:alpine

# Remove default static content
RUN rm -rf /usr/share/nginx/html/*

# Copy your site’s static files
COPY . /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf


# Expose HTTP port
EXPOSE 80

# Use default nginx startup
CMD ["nginx", "-g", "daemon off;"]
