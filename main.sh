#!/bin/bash
# Устанавливаем Xray
wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip Xray-linux-64.zip
chmod +x xray
# Запускаем
./xray run -config config.json
