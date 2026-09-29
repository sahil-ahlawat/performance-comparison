# 🚀 Tech Battle: Performance Comparison Suite
> **Standardized, modular Docker-based benchmarking framework for YouTube, Instagram Reels, and Tech Performance Tutorials.**

Compare any two technologies side-by-side (Go vs PHP, MySQL vs PostgreSQL, Node.js vs Go, Redis vs Memcached) under identical resource limits with live, high-contrast Grafana graphs accessible from any laptop or phone on your home Wi-Fi.

---

## ⚡ What Makes This Suite Special?

- 🎯 **Universal Portability**: Runs on **any laptop** (Linux, macOS, Windows WSL2) with just Docker & Docker Compose. Zero complex host dependencies.
- 📦 **cAdvisor Non-Invasive Metrics**: Captures exact container **CPU %**, **RAM (MB)**, **Disk I/O**, and **Network I/O** directly from Docker cgroups. **Zero code changes or exporter libraries needed in your apps.**
- ⚖️ **Fair & "Breakable" Playing Field**: Both services are capped with identical constraints (e.g. `0.5 CPU` and `128 MB RAM`) so you can visually push them to saturation and find the breaking point on camera with realistic request volumes.
- 🚀 **Automated k6 Load Generator**: Sends simultaneous, equal requests to both services across predefined profiles (Quick Smoke Test, Video Ramp-Up Stress Test, Instant Spike Test).
- 📊 **Single Screen Video Dashboard**: Auto-provisioned Grafana dashboard showing RPS, latency percentiles (p50/p95/p99), CPU saturation, memory usage, and 5xx error spikes with neon dark-mode styling.
- 📱 **Multi-Device Wi-Fi Access**: Open `http://<laptop-ip>:3000` from your recording laptop, secondary monitor, tablet, or phone with **zero login screens or passwords** required.
- ⚡ **2-Minute Scaffolding**: Use `./new-comparison.sh` to scaffold a brand-new comparison suite in 5 seconds.

---

## 📋 Available Comparisons Index

| Folder | Tech 1 (Service A) | Tech 2 (Service B) | Test Type | Status |
| :--- | :--- | :--- | :--- | :--- |
| [📁 01-go-vs-php](file:///var/www/html/hustle/performance-comparison/01-go-vs-php) | **Go HTTP (1.24)** | **PHP 8.4 (FPM + Nginx)** | JSON serialization & in-memory compute | ✅ Ready |
| `02-mysql-vs-postgres` | MySQL 8.4 | PostgreSQL 17 | High-concurrency CRUD / indexing | 🔜 Planned |
| `03-nodejs-vs-go` | Node.js 22 (Fastify) | Go (Fiber) | Async I/O throughput | 🔜 Planned |

---

## 🚀 60-Second Quickstart (Try it Now!)

### 1. Start Services & Monitoring
```bash
cd 01-go-vs-php
make up
# or: docker compose up -d --build
```

### 2. View the Live Dashboard
Find your local Wi-Fi IP by running:
```bash
./get-dashboard-url.sh
```
- **Local Browser:** `http://localhost:3000`
- **Network / Wi-Fi (Secondary Laptop, Tablet, Phone):** `http://<YOUR-IP>:3000`  
*(Grafana opens immediately to the live comparison dashboard without asking for a password).*

### 3. Run the Benchmark Load Test
```bash
make bench
# or: ./run-benchmark.sh
```
Select **Option 1 (Ramp-up Stress Test)** to watch both services compete live on your Grafana screen!

### 4. Teardown
```bash
make down
# or: docker compose down -v
```

---

## 🛠️ How to Create a New Tech Comparison (Under 2 Minutes)

Run the scaffolding script from the repository root:

```bash
./new-comparison.sh <folder-name> "<Service A Name>" "<Service B Name>"
```

### Example:
```bash
./new-comparison.sh 02-nodejs-vs-go "Node.js Fastify" "Go Fiber"
```

### What happens automatically:
1. Copies the master `_template/` blueprint into `02-nodejs-vs-go/`.
2. Renames Docker containers, hostnames, and network aliases.
3. Automatically sets Grafana panel labels and Prometheus scrape tags.
4. Generates a tailored `02-nodejs-vs-go/README.md` with tech specs and video talking points.
5. All you need to do is drop your code in `service-a/` and `service-b/`!

---

## 📂 Repository Structure

```
performance-comparison/
├── README.md                           # Master Guide & Comparison Index (Tier 1)
├── new-comparison.sh                   # Scaffolding CLI tool
├── get-dashboard-url.sh                # Helper to print local and Wi-Fi dashboard URLs
│
├── _template/                          # Master Blueprint Folder
│   ├── README.md                       # Customization Guide (Tier 2)
│   ├── docker-compose.yml              # Standard compose stack
│   ├── Makefile                        # Shortcuts: make up, make bench, make down
│   ├── run-benchmark.sh                # Interactive load test runner
│   ├── service-a/                      # Tech 1 container
│   ├── service-b/                      # Tech 2 container
│   ├── load-generator/                 # k6 benchmark scenario
│   └── monitoring/
│       ├── prometheus/prometheus.yml
│       └── grafana/
│
└── 01-go-vs-php/                       # First Comparison Suite (Tier 3)
    ├── README.md                       # Tech specs, runbook & video talking points
    ├── docker-compose.yml
    ├── Makefile
    ├── run-benchmark.sh
    ├── service-a/ (Go 1.24)
    ├── service-b/ (PHP 8.4 Nginx+FPM)
    └── ...
```

---

## 📹 Video Recording Tips for Content Creators

1. **Widescreen & Split-Screen Friendly**: The Grafana dashboard is structured in a 24-column grid. Service A is on the left, Service B is on the right.
2. **Neon Colors**: Service A uses high-visibility **Neon Green**, and Service B uses **Neon Orange/Red** for immediate visual contrast on video.
3. **The "Breaking Point" Climax**: The stress test ramps users up to 500 VUs. Keep an eye on:
   - When CPU hits the 50% cap (meaning 100% of the allocated 0.5 core).
   - When RAM hits 128 MB and containers risk OOMKill.
   - The exact moment the **Red Failure Bars** start appearing in the Error Rate panel!