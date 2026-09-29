FROM alpine:3.21
RUN apk add --no-cache curl
# Replace with your tech stack build instructions (e.g. Go, Node.js, Rust, Python, etc.)
WORKDIR /app
COPY src/ /app/
EXPOSE 8080
CMD ["sh", "-c", "echo 'Service A Placeholder Running on 8080' && while true; do nc -lk -p 8080 -e echo -e 'HTTP/1.1 200 OK\\r\\nContent-Type: application/json\\r\\n\\r\\n{\"service\":\"service-a\",\"status\":\"ok\"}'; done"]
