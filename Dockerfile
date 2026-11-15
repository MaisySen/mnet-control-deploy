FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
COPY mnet-control /usr/local/bin/mnet-control
EXPOSE 8080
CMD ["sh", "-c", "exec /usr/local/bin/mnet-control -listen :${PORT:-8080} -data /tmp/mnet-control.json"]
