FROM alpine:latest

# Установка зависимостей
RUN apk add --no-cache curl unzip sed

# Скачивание и установка Xray-core
RUN curl -L https://github.com/XTLS/Xray-core/releases/download/v1.8.6/Xray-linux-64.zip -o xray.zip \
    && unzip xray.zip \
    && rm xray.zip \
    && chmod +x xray \
    && mv xray /usr/bin

# Копирование конфигурации и скрипта запуска
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# Права на выполнение скрипта
RUN chmod +x /start.sh

# Точка входа
CMD ["/start.sh"]