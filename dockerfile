FROM alpine:latest
RUN apk add --no-cache curl unzip bash \
    && curl -L https://github.com/XTLS/Xray-core/releases/download/v1.8.6/Xray-linux-64.zip -o xray.zip \
    && unzip xray.zip \
    && rm xray.zip \
    && chmod +x xray \
    && mv xray /usr/bin
COPY config.json /etc/xray/config.json
CMD ["sh", "-c", "xray run -config /etc/xray/config.json -port=${PORT}"]