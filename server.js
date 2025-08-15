const { spawn } = require("child_process");
const fs = require("fs");

// Получаем PORT от Render (по умолчанию 10000), но можем использовать любой
const port = process.env.PORT || 10000;
// UUID из переменных окружения
const uuid = process.env.UUID || "76ce0f8b-2431-4ff3-8178-4336149adce6";

// Конфиг для Xray (VLESS+WS)
const config = {
  inbounds: [{
    port: parseInt(port),
    listen: "0.0.0.0",
    protocol: "vless",
    settings: {
      clients: [{ id: uuid, level: 0 }],
      decryption: "none"
    },
    streamSettings: {
      network: "ws",
      wsSettings: { path: "/" }
    }
  }],
  outbounds: [{ protocol: "freedom" }]
};

fs.writeFileSync("config.json", JSON.stringify(config, null, 2));

const xr = spawn("./xray", ["-config", "config.json"]);
xr.stdout.on("data", d => console.log(d.toString()));
xr.stderr.on("data", d => console.error(d.toString()));
