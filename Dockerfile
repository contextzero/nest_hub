# NEST Hub server + web app. Branding (public/) from ctx0_nest_terminal.
# Build from ctx0_nest_terminal: docker build -t nest-hub .

ARG NEST_REPO=https://github.com/ctx0/nest.git
ARG NEST_REF=main

# ---- Builder: clone NEST and build hub + web ----
FROM oven/bun:1 AS builder
RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /nest
RUN git clone --depth 1 --branch "${NEST_REF}" "${NEST_REPO}" .

RUN bun install
RUN bun run build:hub && bun run build:web

# ---- Runtime ----
FROM oven/bun:1-slim

WORKDIR /app
# Copy full NEST tree so hub resolves workspace deps and finds web/dist
COPY --from=builder /nest /app
# Overlay branding from ctx0_nest_terminal (logo, powered by facta.dev)
COPY public /app/web/dist/public

WORKDIR /app/hub
# Hub serves web from ../web/dist (see findWebappDistDir)
ENV NEST_LISTEN_HOST=0.0.0.0
ENV NEST_LISTEN_PORT=3006
EXPOSE 3006

CMD ["bun", "run", "dist/index.js"]
