# 🛠️ Master Comparison Blueprint (`_template/`)

This directory is the foundational template used to scaffold all tech comparison benchmarks. It contains pre-wired Docker Compose configurations, cAdvisor, Prometheus, Grafana, and an automated k6 load tester.

---

## 📂 Structure Overview

```
_template/
├── docker-compose.yml              # Pre-wired Services A/B, cAdvisor, Prom, Grafana, k6
├── Makefile                        # Quick shortcuts (make up, make bench, make down)
├── run-benchmark.sh                # Interactive benchmark runner with Wi-Fi IP display
├── service-a/                      # Tech 1 container (e.g., Go, Node.js, etc.)
│   ├── Dockerfile
│   └── src/
├── service-b/                      # Tech 2 container (e.g., PHP, Python, etc.)
│   ├── Dockerfile
│   └── src/
├── load-generator/                 # k6 load test script targeting both services
│   └── benchmark.js
└── monitoring/
    ├── prometheus/
    │   └── prometheus.yml          # Scrapes cAdvisor every 1s and k6 metrics
    └── grafana/
        ├── provisioning/           # Auto-provisions Prometheus datasource & dashboards
        └── dashboards/
            └── comparison-dashboard.json # High-contrast side-by-side dashboard
```

---

## ⚙️ How to Customize for a New Tech Battle

### 1. Replace Service A & Service B Code
- Drop your backend implementation into `service-a/src/` and edit `service-a/Dockerfile`.
- Drop your competing backend into `service-b/src/` and edit `service-b/Dockerfile`.
- Ensure both listen on port `8080` (or update `ports:` in `docker-compose.yml`).
- Both services should expose an identical benchmark endpoint (e.g. `GET /bench`).

### 2. Adjusting Resource Constraints (Fair Limits)
In `docker-compose.yml`, both services default to:
```yaml
deploy:
  resources:
    limits:
      cpus: '0.50'     # 0.5 CPU core
      memory: 128M     # 128 MB RAM
```
* **Why limit resources?** Capping services ensures you can saturate CPU and memory to find the breaking point quickly with realistic request volumes on any laptop.

### 3. Customizing the Load Test
In `load-generator/benchmark.js`, you can modify:
- Target endpoint paths (`SERVICE_A_URL` and `SERVICE_B_URL`).
- Concurrency levels (e.g. increase virtual users from 500 to 1,000).
- Request payloads (e.g. sending POST JSON instead of GET).

### 4. Running the Stack
```bash
# Start services & monitoring
make up
# or: docker compose up -d --build

# Run the benchmark
make bench
# or: ./run-benchmark.sh

# Stop and clean up
make down
```
