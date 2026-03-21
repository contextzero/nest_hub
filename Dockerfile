# NEST Hub server + web app. Branding (public/) from ctx0_nest_terminal.
# Build from ctx0_nest_terminal: docker build -t nest-hub .
# No source code reaches the runtime image; shared is pre-compiled to JS.

ARG NEST_REPO=https://github.com/ctx0/nest.git
ARG NEST_REF=main

# ---- Builder: clone NEST and build hub + web ----
FROM oven/bun:1 AS builder

ARG NEST_REPO
ARG NEST_REF

RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /nest
RUN git clone --depth 1 --branch "${NEST_REF}" "${NEST_REPO}" .

RUN bun install
RUN bun run build:hub && bun run build:web

# Pre-compile shared TS → JS so no source reaches runtime
RUN cd shared && \
    bunx tsc --outDir dist --declaration --noEmit false --rootDir src && \
    rm -rf src

# ---- Runtime ----
FROM oven/bun:1-slim

WORKDIR /app

COPY --from=builder /nest/hub/dist /app/hub/dist
COPY --from=builder /nest/hub/package.json /app/hub/package.json
COPY --from=builder /nest/hub/node_modules /app/hub/node_modules
COPY --from=builder /nest/web/dist /app/web/dist
COPY --from=builder /nest/package.json /app/package.json
COPY --from=builder /nest/node_modules /app/node_modules
COPY --from=builder /nest/shared/dist /app/shared/dist
COPY --from=builder /nest/shared/package.json /app/shared/package.json

COPY public /app/web/dist/public

WORKDIR /app/hub
ENV NEST_LISTEN_HOST=0.0.0.0
ENV NEST_LISTEN_PORT=3006
EXPOSE 3006

CMD ["bun", "run", "dist/index.js"]
