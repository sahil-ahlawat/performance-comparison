#!/usr/bin/env bash
HOST_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$HOST_IP" ]; then
  HOST_IP="localhost"
fi

echo "========================================================================"
echo "📊 Grafana Live Dashboard URL"
echo "========================================================================"
echo "👉 Local Machine:       http://localhost:3000"
echo "👉 Local Network / WiFi: http://${HOST_IP}:3000"
echo ""
echo "Open the Wi-Fi link on your second laptop, phone, or tablet."
echo "No password or login required!"
echo "========================================================================"
