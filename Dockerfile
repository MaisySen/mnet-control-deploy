FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
COPY mnet-control /usr/local/bin/mnet-control
ENV PORT=10000
EXPOSE 10000
CMD ["sh", "-c", "exec /usr/local/bin/mnet-control -listen :${PORT} -data /tmp/mnet-control.json"]
