FROM n8nio/n8n:latest

USER root

# Update npm first
RUN npm install -g npm@latest

# Install Chromium and dependencies (Alpine-compatible packages)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto-emoji \
    wqy-zenhei

# Environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install Puppeteer
RUN npm install -g puppeteer@21.11.0

# Create cache directory with proper permissions
RUN mkdir -p /home/node/.cache && \
    chown -R node:node /home/node/.cache

USER node

EXPOSE 5678

CMD ["n8n"]
