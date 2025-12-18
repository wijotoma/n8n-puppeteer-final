FROM n8nio/n8n:latest

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

USER node

# Install Puppeteer (specific stable version)
RUN npm install -g puppeteer@21.11.0

EXPOSE 5678

CMD ["n8n"]
