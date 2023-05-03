# Use an official Node.js runtime as a parent image
FROM node:14-alpine as build
WORKDIR /app
# Install dependencies
COPY package*.json ./
RUN npm install
# Copy application code
COPY . .
# Build the application
RUN npm run build

# Use Nginx as a reverse proxy
FROM nginx:1.21-alpine
# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf
# Copy built application from previous stage
COPY --from=build /app/dist /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
