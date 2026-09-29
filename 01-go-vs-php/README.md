# ⚔️ Tech Battle: Go HTTP vs PHP 8.4
**Benchmark Folder:** `01-go-vs-php`  
**Host Target:** Any laptop running Docker  

---

## 🎯 Tech Stack Details
- **Service A:** Go HTTP (Port: `8081`)
- **Service B:** PHP 8.4 (Port: `8082`)
- **Hardware Limits:** 0.5 CPU Core & 128 MB RAM per container

---

## 🚀 60-Second Quickstart

### Step 1: Start Services & Monitoring
```bash
cd 01-go-vs-php
make up
# or: docker compose up -d --build
```

### Step 2: Open Grafana Live Dashboard
- **Local:** `http://localhost:3000`
- **Home Wi-Fi (Secondary Laptop / Phone):** `http://$(hostname -I | awk '{print $1}'):3000`
*(No login required - opens directly to the comparison dashboard)*

### Step 3: Run the Benchmark Load Test
```bash
make bench
# or: ./run-benchmark.sh
```
Select **Option 1 (Ramp-up Stress Test)** to watch both services compete live on camera!

---

## 📹 Video Recording Talking Points (YouTube & Reels)
1. **Initial Ramp-up (10 to 100 users):** Notice baseline latency and how both services manage initial requests.
2. **Heavy Load (250+ users):** Watch the CPU needle climb towards the 50% (0.5 core) cap.
3. **The Breaking Point (400-500 users):** Observe which technology hits 100% CPU or memory exhaustion first and starts throwing 502/504 errors!
4. **Efficiency Score:** Compare RAM consumption and requests served per CPU cycle.

---

## 🛑 Teardown
```bash
make down
# or: docker compose down -v
```
