#!/bin/sh
# Заменяем порт в конфиге на значение из $PORT
sed -i "s/\"port\": [0-9]\+/\"port\": ${PORT}/g" /etc/xray/config.json
# Запускаем Xray
exec xray run -config /etc/xray/config.json