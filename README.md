# 🚀 VLESS-сервер на Render.com by filin_cprt 

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

Разверните свой собственный VLESS/VPN-сервер на бесплатном облаке Render.com с поддержкой **WebSocket** и автоматическим **TLS**.  
**Работает в 2025 году** · **Обход блокировок** · **100GB бесплатного трафика**

---

## 📦 Требования
1. Аккаунт на [GitHub](https://github.com)
2. Аккаунт на [Render.com](https://render.com)
3. Терминал (Bash, PowerShell или CMD)

---

## 🛠️ Установка за 5 минут

### 1. Клонируйте репозиторий
```bash
git clone https://github.com/<ваш-username>/vless-render.git
cd vless-render
```

### 2. Настройте конфигурацию
Отредактируйте файл `config.json`:

```json
{
  "inbounds": [{
    "port": 10000,
    "protocol": "vless",
    "settings": {
      "clients": [{
        "id": "ВАШ_UUID",  // ↓ Замените на свой ↓
        "flow": ""
      }],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
        "path": "/secret-path"  // Измените на свой
      }
    }
  }],
  "outbounds": [{"protocol": "freedom"}]
}
```

#### 🔑 Сгенерировать UUID:
```bash
# Linux/macOS
uuidgen

# Windows
powershell -Command "[guid]::NewGuid().ToString()"
```

---

### 3. Запушите в GitHub
```bash
git add .
git commit -m "Добавлена конфигурация VLESS"
git push origin main
```

---

### 4. Разверните на Render.com
1. Перейдите в **Render Dashboard**
2. Нажмите **"New" → "Web Service"**
3. Подключите ваш GitHub-репозиторий
4. Укажите параметры:
   - **Name**: любое имя (например `my-vpn`)
   - **Region**: Frankfurt (рекомендуется)
   - **Branch**: main
   - **Runtime**: Docker  
5. Нажмите **"Create Web Service"**

---

## 🔌 Настройка клиента

### Параметры подключения
| Параметр     | Значение |
|--------------|----------|
| **Адрес**    | `<имя-сервиса>.onrender.com` |
| **Порт**     | `443` |
| **ID**       | Ваш UUID из `config.json` |
| **Шифрование** | none |
| **Протокол** | VLESS |
| **Транспорт** | WebSocket (WS) |
| **Путь WS**  | Ваш путь из `config.json` |
| **TLS**      | Включен |
| **SNI**      | `<имя-сервиса>.onrender.com` |

#### 📥 Ссылка для импорта:
```
vless://ВАШ_UUID@<имя-сервиса>.onrender.com:443?encryption=none&security=tls&type=ws&host=<имя-сервиса>.onrender.com&path=%2Fsecret-path&sni=<имя-сервиса>.onrender.com#Render-VPN
```

---

## ⚠️ Важные ограничения

| Ограничение             | Решение |
|--------------------------|---------|
| 💤 Сон после 15 мин      | Настройте [UptimeRobot](https://uptimerobot.com) с URL: `https://<сервис>.onrender.com/secret-path` |
| 📶 100 ГБ трафика        | Смотрите в **Render Dashboard → Metrics** |
| ⚡ 0.1 vCPU / 512 RAM    | Не используйте для торрентов/4K видео |
| 🔒 Только TCP            | UDP не поддерживается |

---

## 🛠️ Техническая информация

### Структура проекта
```
├── Dockerfile          # Конфигурация Docker
├── config.json         # Настройки Xray-core
└── start.sh            # Скрипт запуска сервера
```

### Мониторинг работы
Render Dashboard → Ваш сервис → **Logs**

Успешный запуск:
```
[Info] Xray core started
[Info] [VLESS] listening on [::]:10000
```

### Обновление Xray-core
В `Dockerfile` замените версию:
```dockerfile
RUN curl -L https://github.com/XTLS/Xray-core/releases/download/v1.8.6/Xray-linux-64.zip -o xray.zip
```

---

## ❓ Частые проблемы

- **Сервер не просыпается**  
  Проверьте URL в UptimeRobot (обязательно должен включать путь WS).  
  Пример:  
  `https://vpn-well.onrender.com/your-ws-path`

- **Ошибка `400 Bad Request`**  
  Это нормально! Сервер работает корректно.  
  Используйте для мониторинга.

- **Нет подключения**  
  - Проверьте совпадение UUID и пути  
  - Убедитесь, что TLS включен в клиенте  

---

⚠️ **Внимание**: проект предназначен **исключительно для образовательных целей**.  
Не нарушайте законы вашей страны.  

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
