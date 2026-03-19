# NEST Terminal

<p align="center">
  <img src="./public/icon.svg" alt="NEST" width="120" height="120" />
</p>

**Enterprise-grade distribution for the NEST workforce hub:** run the **server** and **web app** from public Docker images and install the **CLI** via npm. Self-hosted, no NEST product fees — business owners control infrastructure and BYOK (LLMs, voice). Employees operate from **phone or tablet** with parallel sessions, approvals, and live answers.

<p align="center">
  <img src="https://img.shields.io/badge/Rust-000000?style=flat&logo=rust&logoColor=white" alt="Rust" />
  <img src="https://img.shields.io/badge/PWA-5A0FC8?style=flat&logo=pwa&logoColor=white" alt="PWA" />
  <img src="https://img.shields.io/badge/Node.js-339933?style=flat&logo=nodedotjs&logoColor=white" alt="Node.js" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white" alt="PostgreSQL" />
</p>

---

## Tech stack

| Component | Technology |
|-----------|------------|
| **Server** | [Rust](https://www.rust-lang.org/) — Axum, Socket.IO, SSE, Postgres |
| **Web** | **PWA** — React, Vite, TanStack Router/Query, assistant-ui |
| **CLI** | **Node.js** — Bun/TypeScript, multi-agent runners (Cursor, Claude, Codex, Gemini, OpenCode) |
| **Data** | **PostgreSQL** — sessions, messages, machines, audit |

> **Methodology & business:** This distribution aligns with [NEST holding](https://github.com/ctx0/nest/tree/main/docs/holding) and [business docs](https://github.com/ctx0/nest/tree/main/docs/holding/business) (administration, user mobile/tablet, console). We are building an **enterprise-grade solution** where organizations can **participate** — see [ROADMAP](ROADMAP.md) and [RELEASES](RELEASES.md).

---

## Table of contents

- [Introduction](#introduction)
- [Key features](#key-features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration & environment variables](#configuration--environment-variables)
- [API & entrypoints](#api--entrypoints)
- [Security](#security)
- [Troubleshooting](#troubleshooting)
- [Repository structure](#repository-structure)
- [Contribution](#contribution)
- [Support & contact](#support--contact)
- [Links](#links)

**More docs:** [QUICKSTART.md](QUICKSTART.md) · [INSTALL.md](docs/INSTALL.md) · [Install frameworks (Node, Docker)](docs/INSTALL-FRAMEWORKS.md) · [RELEASES.md](RELEASES.md) · [ROADMAP.md](ROADMAP.md)

---

## Introduction

NEST is a **self-hosted workforce hub**. The **business owner** deploys this stack (Docker Compose: server + web + Postgres + nginx), configures **CLI_API_TOKEN**, and optionally LLM/voice credentials on the server. **Employees** install the NEST CLI and connect to the server; they run **multiple agent sessions** (Claude Code, Codex, Cursor, Gemini, OpenCode), control them from the **PWA** on phone or tablet, and receive **answers in real time**.

| Component | Description |
|-----------|-------------|
| **NEST CLI** | Runs agent sessions on your machine; connects to the server via Socket.IO + REST. Install: `npm install -g @ctx0/nest`. |
| **NEST Server** | Rust API, Socket.IO, SSE. Image: `matiasbaglieri/nest-server:latest`. |
| **NEST Web** | Static PWA. Image: `matiasbaglieri/nest-web:latest` (served by nginx). |
| **This repo** | `docker-compose.yml` wires server + web + Postgres + nginx; single entrypoint (default port 80). |

**Data flow:** CLI ↔ Server (Socket.IO + REST) ↔ Web (SSE + REST). Server persists state in Postgres.

---

## Key features

- **Self-hosted** — your infrastructure, your data; no NEST subscription.
- **One-command stack** — `docker compose up -d` for server + web + DB.
- **CLI via npm** — `npm install -g @ctx0/nest`; no build from source.
- **Multi-agent** — Claude Code, Codex, Cursor, Gemini, OpenCode from one hub.
- **Mobile-first** — PWA for session list, chat, approvals, terminal; use from phone or tablet.
- **Enterprise alignment** — methodology and roadmap informed by [NEST holding](https://github.com/ctx0/nest/tree/main/docs/holding) and [entrepreneurship/strategy](https://github.com/ctx0/nest/tree/main/docs/knowladge) knowledge base.

---

## Installation

### Prerequisites

| Requirement | Purpose |
|------------|---------|
| **Node.js 18+** | NEST CLI runtime. |
| **npm** | Install CLI: `npm install -g @ctx0/nest`. |
| **Docker & Docker Compose** | Run server stack from public images. |
| **CLI_API_TOKEN** | Shared secret between CLI and server; set in `.env` and CLI. |

Optional: Claude CLI, Cursor, etc., depending on which mode you use (`nest`, `nest cursor`, …).

### Quick start

1. **Start the server (Docker)**

   ```bash
   git clone https://github.com/ctx0/ctx0_nest_terminal.git
   cd ctx0_nest_terminal
   cp .env.example .env
   ```

   Edit `.env`: set **CLI_API_TOKEN** (e.g. `openssl rand -hex 32`).

   ```bash
   docker compose up -d
   ```

   Web app and API: **http://localhost** (port 80).

2. **Install the CLI**

   ```bash
   npm install -g @ctx0/nest
   nest --help
   ```

3. **Configure and run a session**

   ```bash
   export CLI_API_TOKEN="your-token-from-env"
   export NEST_API_URL="http://localhost"
   nest
   ```

   Or: `nest auth login` and enter the same token.

4. **Open the web UI** at http://localhost to see the session and control it remotely.

---

## Usage

### Main CLI commands

| Command | Description |
|---------|-------------|
| `nest` | Start a Claude Code session. |
| `nest codex` | Codex mode. |
| `nest cursor` | Cursor Agent mode. |
| `nest gemini` | Gemini mode. |
| `nest opencode` | OpenCode mode. |
| `nest auth login` | Save `CLI_API_TOKEN` interactively. |
| `nest auth status` | Show auth config. |
| `nest worker start` | Background worker (remote spawn). |
| `nest diagnose` | Diagnostics. |

### Server (Docker)

- **Start:** `docker compose up -d`
- **Stop:** `docker compose down`
- **Logs:** `docker compose logs -f`

Images used: `matiasbaglieri/nest-server:latest`, `matiasbaglieri/nest-web:latest`, `postgres:16-alpine`, `nginx:alpine`.

---

## Configuration & environment variables

### Server (`.env`)

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | **Yes** | Shared secret for CLI and web. |
| `POSTGRES_USER` / `POSTGRES_PASSWORD` / `POSTGRES_DB` | No | Defaults: postgres, changethis, nest. |
| `WEB_PORT` | No | Host port for nginx (default 80). |
| `PGPORT` | No | Host port for Postgres (default 5433); set empty to not expose. |
| `NEST_PUBLIC_URL` | No | Public HTTPS URL for PWA/Telegram. |
| `TELEGRAM_BOT_TOKEN` | No | Optional Telegram bot. |

See `.env.example` for the full list.

### CLI environment

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | Yes | Must match the server's `CLI_API_TOKEN`. |
| `NEST_API_URL` | Yes | Server base URL (e.g. `http://localhost`). |
| `NEST_HOME` | No | Config directory (default `~/.nest`). |

---

## API & entrypoints

| Path / purpose | Handled by |
|----------------|------------|
| `/` | Nginx → nest-web (PWA). |
| `/api/*` | Nginx → nest-server (REST). |
| `/ws/*` | Nginx → nest-server (Socket.IO). |
| `/api/events` | Nginx → nest-server (SSE). |
| `/health`, `/ready` | nest-server health checks. |

Single host port (default 80); nginx routes to server and web containers.

---

## Security

- **CLI_API_TOKEN:** Use a strong random value (e.g. `openssl rand -hex 32`). Do not commit `.env`.
- **Production:** Use HTTPS, set `NEST_PUBLIC_URL`, and restrict access to the server.

---

## Troubleshooting

| Issue | Action |
|-------|--------|
| CLI cannot connect | Server running? `NEST_API_URL` correct (e.g. `http://localhost`)? |
| 401 Unauthorized | Same `CLI_API_TOKEN` in `.env` and CLI. |
| Port in use | Set `WEB_PORT` in `.env` (e.g. 8080). |
| Web app not loading | Check `docker compose logs nest-server`; wait for healthcheck. |

Run **`nest diagnose`** on the client for diagnostics.

---

## Repository structure

```
ctx0_nest_terminal/
├── README.md              # This file
├── QUICKSTART.md          # Short quick start
├── docs/
│   ├── INSTALL.md         # Full install (server + CLI)
│   └── INSTALL-FRAMEWORKS.md  # Node, Docker, Rust
├── docker-compose.yml     # Server + web + Postgres + nginx (public images)
├── nginx/conf.d/          # Nginx config for routing
├── .env.example           # Env template
├── RELEASES.md
├── ROADMAP.md
└── public/                # Branding (icon, etc.)
```

---

## Contribution

We are building an **enterprise-grade solution** and welcome participation:

- **Upstream:** [ctx0/nest](https://github.com/ctx0/nest) — core NEST (server, web, CLI, shared).
- **This repo:** distribution and docs for the terminal/Docker flow.
- **Methodology:** [docs/holding](https://github.com/ctx0/nest/tree/main/docs/holding), [docs/knowladge](https://github.com/ctx0/nest/tree/main/docs/knowladge) — business, strategy, entrepreneurship.

Open issues and PRs in the appropriate repo; follow the codebase style and AGENTS.md in the main NEST repo.

---

## Support & contact

- **NEST project:** [ctx0/nest](https://github.com/ctx0/nest)
- **This repo:** [ctx0/ctx0_nest_terminal](https://github.com/ctx0/ctx0_nest_terminal)
- **CLI (npm):** [@ctx0/nest](https://www.npmjs.com/package/@ctx0/nest)

---

## Links

- [NEST holding (workforce hub)](https://github.com/ctx0/nest/tree/main/docs/holding)
- [Business docs (admin, user, console)](https://github.com/ctx0/nest/tree/main/docs/holding/business)
- [QUICKSTART](QUICKSTART.md) · [INSTALL](docs/INSTALL.md) · [RELEASES](RELEASES.md) · [ROADMAP](ROADMAP.md)
