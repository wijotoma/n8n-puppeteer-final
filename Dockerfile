FROM n8nio/n8n:latest

USER root

# Update npm first
RUN npm install -g npm@latest

# Install Chromium and ALL required dependencies
RUN apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto-emoji \
    wqy-zenhei \
    udev \
    ttf-opensans \
    dbus \
    libx11 \
    libxcomposite \
    libxdamage \
    libxext \
    libxfixes \
    libxrandr \
    libgbm \
    libpangocairo-1.0-0 \
    libpangoft2-1.0-0 \
    libasound2

# Environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    CHROME_BIN=/usr/bin/chromium-browser

# Install Puppeteer
RUN npm install -g puppeteer@21.11.0

# Create cache directory with proper permissions
RUN mkdir -p /home/node/.cache && \
    chown -R node:node /home/node/.cache

# Fix permissions for Chromium
RUN chmod 4755 /usr/bin/chromium-browser

USER node

EXPOSE 5678

CMD ["n8n"]
