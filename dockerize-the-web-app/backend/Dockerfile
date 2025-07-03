# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy application code
COPY . .

# Set environment variable
ENV NODE_ENV=production

# Expose the app port (adjust if different)
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
