# Prepared only. Pushing this into the deploy repository triggers deployment.
FROM golang:1.26.6-bookworm AS build
ARG MNET_COMMIT=7edb07034c0bc5075f635486c21acee384047fc6
WORKDIR /src
RUN git clone --no-checkout https://github.com/MaisySen/Mnet.git . \
    && git checkout --detach "${MNET_COMMIT}" \
    && CGO_ENABLED=0 go build -trimpath \
       -ldflags "-s -w -X fintex.au/mnet/internal/version.Revision=${MNET_COMMIT}" \
       -o /out/mnet-control ./cmd/mnet-control
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /out/mnet-control /usr/local/bin/mnet-control
ENV PORT=10000
EXPOSE 10000
CMD ["sh", "-c", "exec /usr/local/bin/mnet-control -listen :${PORT} -data /tmp/mnet-control.json -default-network fintex -base-url https://mnet-control.onrender.com"]
