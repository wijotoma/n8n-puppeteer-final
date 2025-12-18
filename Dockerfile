FROM n8nio/n8n:latest

# Stay as root for ALL installations
USER root

# Update npm first
RUN npm install -g npm@latest

# Install Chromium and dependencies
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer WHILE STILL ROOT
RUN npm install -g puppeteer@21.11.0

# Create node user's cache directory with proper permissions
RUN mkdir -p /home/node/.cache && \
    chown -R node:node /home/node/.cache

# NOW switch to node user (after all installations)
USER node

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
