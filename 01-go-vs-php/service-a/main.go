package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

type BenchResponse struct {
	Service   string    `json:"service"`
	Timestamp time.Time `json:"timestamp"`
	Message   string    `json:"message"`
	Items     []int     `json:"items"`
}

func benchHandler(w http.ResponseWriter, r *http.Request) {
	// Simulate realistic in-memory computation and JSON serialization
	items := make([]int, 50)
	for i := 0; i < 50; i++ {
		items[i] = i * i
	}

	resp := BenchResponse{
		Service:   "Go HTTP",
		Timestamp: time.Now(),
		Message:   "Benchmarked successfully",
		Items:     items,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(resp)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte("OK"))
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/bench", benchHandler)
	mux.HandleFunc("/health", healthHandler)
	mux.HandleFunc("/", benchHandler)

	server := &http.Server{
		Addr:         ":8080",
		Handler:      mux,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 5 * time.Second,
	}

	log.Println("Go HTTP Server running on :8080")
	if err := server.ListenAndServe(); err != nil {
		log.Fatalf("Server error: %v", err)
	}
}
