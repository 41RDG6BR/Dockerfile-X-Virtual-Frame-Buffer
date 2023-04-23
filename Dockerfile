FROM node:16

# Instalar dependências do Chromium
RUN apt-get update && apt-get install -yq \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    fonts-noto-color-emoji \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget \
    xvfb && \
    rm -rf /var/lib/apt/lists/*

# Copiar o código fonte do projeto para a imagem
COPY . /app

# Definir o diretório de trabalho para a aplicação
WORKDIR /app

# Configurar variáveis de ambiente
ENV DISPLAY=:99
ENV NODE_ENV=production

# Instalar as dependências do projeto
RUN npm install

# Instalar o Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm ./google-chrome-stable_current_amd64.deb

# Definir o comando padrão para iniciar a aplicação
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 -ac && npm start --no-sandbox --disable-dev-shm-usage --disable-gpu"]
