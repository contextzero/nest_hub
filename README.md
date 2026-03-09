# NEST Terminal

<p align="center">
  <img src="./public/icon.svg" alt="NEST" width="120" height="120" />
</p>

**Enterprise-ready distribution for the NEST CLI and Hub server.** Run AI coding agents (Claude Code, Codex, Cursor, Gemini, OpenCode) locally and control them remotely via the web app. This repository provides everything needed to install the CLI with **npm** and run the Hub server with **Docker**.

---

## Table of contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [CLI installation (npm)](#cli-installation-npm)
- [Server deployment (Docker)](#server-deployment-docker)
- [Configuration reference](#configuration-reference)
- [Security](#security)
- [Troubleshooting](#troubleshooting)
- [Repository structure](#repository-structure)
- [Powered by facta.dev](#powered-by-factadev)

**More docs:** [QUICKSTART.md](QUICKSTART.md) · [Install frameworks (Rust, Node, Docker)](docs/INSTALL-FRAMEWORKS.md) · [RELEASES.md](RELEASES.md) · [ROADMAP.md](ROADMAP.md)

---

## Overview

| Component | Description |
|-----------|-------------|
| **NEST CLI** | Runs agent sessions on your machine and connects them to the Hub. Install globally via npm. |
| **NEST Hub** | HTTP API, Socket.IO, and web app. Deploy with Docker using this repository. |
| **Web app** | Served by the Hub at the same URL. Lists sessions, chat, permissions, terminal, and files. |

**Data flow:** CLI ↔ Hub (Socket.IO + REST) ↔ Web (SSE + REST). The Hub persists state in SQLite.

---

## Prerequisites

| Requirement | Purpose |
|-------------|---------|
| **Node.js 18+** | For npm and the NEST CLI. |
| **npm** | To install the NEST CLI globally (`npm install -g @factadev/cli`). |
| **Docker & Docker Compose** | To run the Hub server. |
| **CLI_API_TOKEN** | Shared secret between CLI and Hub; generate a secure value before first use. |

Optional: [Claude CLI](https://claude.ai), [Cursor Agent CLI](https://cursor.com), or other agents depending on which mode you use (`nest`, `nest cursor`, etc.).

---

## Quick start

1. **Start the Hub (Docker)**

   ```bash
   git clone https://github.com/Facta-Dev/ctx0_nest_terminal.git
   cd ctx0_nest_terminal
   cp .env.example .env
   # Edit .env: set CLI_API_TOKEN to a secure secret (e.g. openssl rand -hex 32)
   docker compose up -d
   ```

   The Hub and web app are available at **http://localhost:3006** (or the port set in `.env`).

2. **Install the CLI (npm)**

   ```bash
   npm install -g @factadev/cli
   ```

3. **Configure and run a session**

   ```bash
   export CLI_API_TOKEN="your-token-from-env"
   export NEST_API_URL="http://localhost:3006"
   nest
   ```

   Or persist the token: `nest auth login` and enter the same token when prompted.

4. **Open the web UI** at http://localhost:3006 to see the session and control it remotely.

---

## CLI installation (npm)

Install the NEST CLI globally so the `nest` command is available everywhere:

```bash
npm install -g @factadev/cli
```

Verify:

```bash
nest --help
```

### Environment variables (CLI)

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | Yes | Must match the Hub’s `CLI_API_TOKEN`. |
| `NEST_API_URL` | Yes | Hub base URL (e.g. `http://localhost:3006`). |
| `NEST_HOME` | No | Config directory (default: `~/.nest`). |

### Main commands

| Command | Description |
|---------|-------------|
| `nest` | Start a Claude Code session. |
| `nest codex` | Start Codex mode. |
| `nest cursor` | Start Cursor Agent mode. |
| `nest gemini` | Start Gemini mode. |
| `nest opencode` | Start OpenCode mode. |
| `nest auth login` | Save `CLI_API_TOKEN` interactively. |
| `nest auth status` | Show auth configuration. |
| `nest runner start` | Start the background runner (remote spawn). |
| `nest doctor` | Run diagnostics. |

---

## Server deployment (Docker)

This repository includes a **Dockerfile** and **docker-compose.yml** to build and run the NEST Hub. The image builds the Hub and web app from the [NEST](https://github.com/ctx0/nest) source and overlays this repo’s **`public/`** assets (logo and branding).

### Start the server

```bash
cp .env.example .env
# Edit .env: set CLI_API_TOKEN (required)
docker compose up -d
```

### Stop the server

```bash
docker compose down
```

### Rebuild after changes

If you change `public/` or want to pick up a different NEST version:

```bash
docker compose build --no-cache
docker compose up -d
```

### Custom NEST source

Build with another repository or branch:

```bash
docker build \
  --build-arg NEST_REPO=https://github.com/your-org/nest.git \
  --build-arg NEST_REF=main \
  -t nest-terminal-hub .
```

Then run the container with the same environment variables as in `docker-compose.yml`.

---

## Configuration reference

### Hub (Docker / `.env`)

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | Yes | Shared secret for CLI and web auth. |
| `NEST_LISTEN_PORT` | No | Port the Hub listens on (default: `3006`). |
| `NEST_PUBLIC_URL` | No | Public HTTPS URL (for Telegram Mini App / PWA). |
| `TELEGRAM_BOT_TOKEN` | No | Telegram bot token; omit to run without Telegram. |

See `.env.example` for the full list.

---

## Security

- **Token:** Use a strong, random `CLI_API_TOKEN` (e.g. `openssl rand -hex 32`). Do not commit `.env` or share the token.
- **Network:** In production, put the Hub behind HTTPS and restrict `CORS_ORIGINS` and `NEST_PUBLIC_URL` to your domains.
- **Docker:** The Hub runs as the container’s default user; mount only the data volume you need (e.g. `nest-data` for SQLite).

---

## Troubleshooting

| Issue | Action |
|-------|--------|
| CLI cannot connect | Ensure the Hub is running and `NEST_API_URL` matches (e.g. `http://localhost:3006`). Check firewall and Docker port mapping. |
| “Unauthorized” or 401 | Verify `CLI_API_TOKEN` is identical for the Hub (`.env`) and the CLI (`export` or `nest auth login`). |
| Port already in use | Change `NEST_LISTEN_PORT` in `.env` and ensure the same port is mapped in `docker-compose.yml`. |
| Web app not loading | Rebuild the image: `docker compose build --no-cache && docker compose up -d`. |

Run `nest doctor` on the client for diagnostics.

---

## Repository structure

```
ctx0_nest_terminal/
├── README.md              # This file
├── QUICKSTART.md          # Short quick start
├── RELEASES.md            # What we've built; release info
├── ROADMAP.md             # Pending: Souls, multi-agents, Forge
├── Dockerfile             # Hub + web image; overlays public/
├── docker-compose.yml     # Hub service and volumes
├── .env.example           # Environment template
├── .dockerignore          # Build context exclusions
├── docs/
│   └── INSTALL-FRAMEWORKS.md   # Install Rust, Node, Docker
└── public/                # Branding assets (logo, facta.dev)
    ├── icon.svg           # NEST app icon
    ├── mask-icon.svg
    ├── facta.svg          # Facta logo
    └── facta_isotype.svg
```

Assets in `public/` are served by the Hub at `/public/` (e.g. `/public/facta.svg`).

---

## Powered by facta.dev

<p align="center">
  <a href="https://facta.dev" target="_blank" rel="noopener noreferrer">
    <img src="./public/facta.svg" alt="Facta" width="200" height="60" />
  </a>
</p>

NEST Terminal is built for teams and enterprises. **Facta** provides the platform and tooling that power this distribution.

- **Website:** [facta.dev](https://facta.dev)
- **NEST project:** [ctx0/nest](https://github.com/ctx0/nest)
- **This repo:** [Facta-Dev/ctx0_nest_terminal](https://github.com/Facta-Dev/ctx0_nest_terminal)

---

*Powered by [facta.dev](https://facta.dev).*
