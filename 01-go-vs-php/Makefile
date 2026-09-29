.PHONY: up down bench logs status

up:
	docker compose up -d --build
	@echo ""
	@echo "========================================================================"
	@echo "✅ Services & Monitoring are running!"
	@echo "📊 Grafana: http://localhost:3000 (or on Wi-Fi: http://$$(hostname -I | awk '{print $$1}'):3000)"
	@echo "⚡ Service A: http://localhost:8081"
	@echo "⚡ Service B: http://localhost:8082"
	@echo "========================================================================"

bench:
	./run-benchmark.sh

down:
	docker compose down -v

logs:
	docker compose logs -f

status:
	docker compose ps
