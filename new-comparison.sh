#!/usr/bin/env bash
set -e

# ==============================================================================
# Scaffold a New Tech Comparison Benchmark Folder from _template/
# Usage: ./new-comparison.sh <folder-name> "<Service A Name>" "<Service B Name>"
# Example: ./new-comparison.sh 02-nodejs-vs-go "Node.js Express" "Go Fiber"
# ==============================================================================

DIR_NAME="$1"
NAME_A="${2:-Service A}"
NAME_B="${3:-Service B}"

if [ -z "$DIR_NAME" ]; then
  echo "Usage: ./new-comparison.sh <folder-name> \"<Service A Name>\" \"<Service B Name>\""
  echo "Example: ./new-comparison.sh 02-nodejs-vs-go \"Node.js Express\" \"Go Fiber\""
  exit 1
fi

if [ -d "$DIR_NAME" ]; then
  echo "❌ Error: Directory '$DIR_NAME' already exists!"
  exit 1
fi

echo "📁 Creating new benchmark suite '$DIR_NAME'..."
cp -r _template "$DIR_NAME"

# Replace titles in docker-compose.yml
sed -i "s/comparison-service-a/${DIR_NAME}-service-a/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/comparison-service-b/${DIR_NAME}-service-b/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/comparison-cadvisor/${DIR_NAME}-cadvisor/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/comparison-prometheus/${DIR_NAME}-prometheus/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/comparison-grafana/${DIR_NAME}-grafana/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/comparison-k6/${DIR_NAME}-k6/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/\"Service A\"/\"${NAME_A}\"/g" "$DIR_NAME/docker-compose.yml"
sed -i "s/\"Service B\"/\"${NAME_B}\"/g" "$DIR_NAME/docker-compose.yml"

# Replace dashboard titles in JSON
DASH_FILE="$DIR_NAME/monitoring/grafana/dashboards/comparison-dashboard.json"
sed -i "s/Service A (Go)/${NAME_A}/g" "$DASH_FILE"
sed -i "s/Service B (PHP)/${NAME_B}/g" "$DASH_FILE"
sed -i "s/Service A vs Service B/${NAME_A} vs ${NAME_B}/g" "$DASH_FILE"
sed -i "s/tech-battle-comparison/${DIR_NAME}-comparison/g" "$DASH_FILE"

# Create custom README.md for this comparison
cat <<EOF > "$DIR_NAME/README.md"
# ⚔️ Tech Battle: ${NAME_A} vs ${NAME_B}
**Benchmark Folder:** \`${DIR_NAME}\`  
**Host Target:** Any laptop running Docker  

---

## 🎯 Tech Stack Details
- **Service A:** ${NAME_A} (Port: \`8081\`)
- **Service B:** ${NAME_B} (Port: \`8082\`)
- **Hardware Limits:** 0.5 CPU Core & 128 MB RAM per container

---

## 🚀 60-Second Quickstart

### Step 1: Start Services & Monitoring
\`\`\`bash
cd ${DIR_NAME}
make up
# or: docker compose up -d --build
\`\`\`

### Step 2: Open Grafana Live Dashboard
- **Local:** \`http://localhost:3000\`
- **Home Wi-Fi (Secondary Laptop / Phone):** \`http://\$(hostname -I | awk '{print \$1}'):3000\`
*(No login required - opens directly to the comparison dashboard)*

### Step 3: Run the Benchmark Load Test
\`\`\`bash
make bench
# or: ./run-benchmark.sh
\`\`\`
Select **Option 1 (Ramp-up Stress Test)** to watch both services compete live on camera!

---

## 📹 Video Recording Talking Points (YouTube & Reels)
1. **Initial Ramp-up (10 to 100 users):** Notice baseline latency and how both services manage initial requests.
2. **Heavy Load (250+ users):** Watch the CPU needle climb towards the 50% (0.5 core) cap.
3. **The Breaking Point (400-500 users):** Observe which technology hits 100% CPU or memory exhaustion first and starts throwing 502/504 errors!
4. **Efficiency Score:** Compare RAM consumption and requests served per CPU cycle.

---

## 🛑 Teardown
\`\`\`bash
make down
# or: docker compose down -v
\`\`\`
EOF

chmod +x "$DIR_NAME/run-benchmark.sh"

echo ""
echo "========================================================================"
echo "🎉 Successfully scaffolded '${DIR_NAME}'!"
echo "   Tech 1: ${NAME_A}"
echo "   Tech 2: ${NAME_B}"
echo ""
echo "Next steps:"
echo "   1) cd ${DIR_NAME}"
echo "   2) Add code in service-a/ and service-b/"
echo "   3) Run 'make up' and 'make bench'"
echo "========================================================================"
