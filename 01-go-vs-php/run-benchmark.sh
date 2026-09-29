#!/usr/bin/env bash
set -e

# Detect host LAN IP
HOST_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$HOST_IP" ]; then
  HOST_IP="localhost"
fi

echo "========================================================================"
echo "⚡ TECH BATTLE: AUTOMATED LOAD GENERATOR (k6)"
echo "========================================================================"
echo "📊 Grafana Live Dashboard:"
echo "   👉 Local:   http://localhost:3000"
echo "   👉 Network: http://${HOST_IP}:3000 (Open on your phone or recording laptop)"
echo "========================================================================"
echo ""
echo "Select Benchmark Profile:"
echo "  1) [Recommended for Videos] Ramp-Up Stress Test (60s, ramps to 500 VUs to find breaking point)"
echo "  2) Quick Smoke Test (10s, 20 VUs - verify both services work)"
echo "  3) Sudden Spike Test (15s, instant 400 VUs burst)"
echo ""
read -p "Enter choice [1-3] (Default: 1): " choice

case "$choice" in
  2)
    SCENARIO="smoke"
    echo "🚀 Running Quick Smoke Test..."
    ;;
  3)
    SCENARIO="spike"
    echo "🚀 Running Sudden Spike Test..."
    ;;
  *)
    SCENARIO="stress"
    echo "🚀 Running Video Stress & Breaking Point Test..."
    ;;
esac

echo ""
echo "Sending simultaneous traffic to Service A and Service B..."
echo "Watch live curves animate on http://${HOST_IP}:3000 !"
echo ""

docker compose run --rm -e TEST_SCENARIO="$SCENARIO" load-tester

echo ""
echo "========================================================================"
echo "✅ Benchmark Finished!"
echo "Check Grafana at http://${HOST_IP}:3000 to analyze the full comparison curve."
echo "========================================================================"
