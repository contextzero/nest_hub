# NEST Hub — Releases & What's Shipped

<p align="center">
  <img src="./public/icon.svg" alt="NEST Hub" width="140" height="140" />
  <img src="./public/annie.png" alt="annie" width="120" height="120" />
</p>
**By Context Zero.** This document is your proof of delivery — every component that exists today, where to get it, and what it does. No vaporware. No feature promises without a package behind them. Real software, running now, free to deploy.

> **Trust is built on one question:** *"Have you done it before?"*
> Every item below has a public repo, a public Docker image, or a public npm package. Click the links and verify for yourself.

---

## What's Live Today

### 1 — NEST CLI (`@contextzero/nest`)

The command employees run on their machines to start AI agent sessions and connect them to your server.

| | |
|---|---|
| **Package** | [`@contextzero/nest`](https://www.npmjs.com/package/@contextzero/nest) on npm |
| **Install** | `npm install -g @contextzero/nest` |
| **Source** | [github.com/contextzero/nest](https://github.com/contextzero/nest) |
| **Status** | ✅ Live — install and run today |

**What it ships:**
- Agent runners for **Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode**
- Session lifecycle management (start, stop, reconnect)
- Auth: `annie auth login` / `annie auth status`
- Background worker daemon: `annie worker start`
- RPC handlers: git, files, terminal, uploads, slash commands, skills
- `annie diagnose` — full diagnostic report for troubleshooting

```bash
# Verify it's real — install and check right now
npm install -g @contextzero/nest
annie --help
```

---

### 2 — NEST Server (Rust) — Public Docker Image

The central server your whole team connects to. Handles all real-time communication, sessions, approvals, and audit persistence.

| | |
|---|---|
| **Docker image** | `matiasbaglieri/nest-server:latest` on Docker Hub |
| **Source** | [github.com/contextzero/nest](https://github.com/contextzero/nest) — `server/` |
| **Status** | ✅ Live — pulled automatically by `docker compose up -d` |

**What it ships:**
- **HTTP API** — REST endpoints for sessions, messages, machines, permissions
- **Socket.IO** — real-time bidirectional channel for the CLI
- **SSE (Server-Sent Events)** — live event stream to the web app
- **JWT auth** — token-based authentication for CLI and web
- **PostgreSQL persistence** — full audit log of every session, message, and action
- **Git & file operations** — server-side git status, diff, file browser
- **Optional Telegram bot** — receive session updates on Telegram

**Stack:** Rust · Axum · Socket.IO · PostgreSQL 16

---

### 3 — NEST Web App (React PWA) — Public Docker Image

The control center your team accesses from any browser — including mobile. No app store. Install on your phone's home screen in seconds.

| | |
|---|---|
| **Docker image** | `matiasbaglieri/nest-web:latest` on Docker Hub |
| **Source** | [github.com/contextzero/nest](https://github.com/contextzero/nest) — `web/` |
| **Status** | ✅ Live — served automatically at `http://localhost` after `docker compose up -d` |

**What it ships:**
- **Session list** — see every active and past agent session
- **Live chat** — send messages into any running session in real time
- **Permission approvals** — agents surface approval requests; you accept or reject from your phone
- **Terminal viewer** — live terminal output from any running session
- **File browser** — navigate and inspect files touched by agents
- **Git status / diff** — see exactly what the agent changed
- **Slash commands & skills** — structured agent commands
- **Voice interface** — integrated voice input/output (BYOK: ElevenLabs or MiniMax)
- **PWA install** — add to any phone's home screen; works offline for cached views
- **Telegram Mini App** — alternative interface via Telegram

**Stack:** React 19 · Vite · TanStack Router/Query · Tailwind · assistant-ui · xterm.js · SSE

---

### 4 — NEST Hub (This Repository) — Docker Distribution

The one-command deployment package that wires everything together for business owners.

| | |
|---|---|
| **Repository** | [github.com/contextzero/nest_hub](https://github.com/contextzero/nest_hub) |
| **Status** | ✅ Live — clone and run today |

**What it ships:**
- `docker-compose.yml` — server + web + PostgreSQL + nginx in a single file
- `nginx/conf.d/` — routing config (API, Socket.IO, SSE, PWA — all on port 80)
- `.env.example` — full environment variable reference; copy and fill one value
- `QUICKSTART.md` — server live in 5 minutes, no prior experience needed
- `docs/INSTALL.md` — complete installation reference
- `docs/DEVOPS.md` — production setup: HTTPS, public URL, scaling
- `docs/CLI-BUSINESS.md` — agent modes, OpenClaw, ZeroClaw, LLM provider config
- `docs/INSTALL-FRAMEWORKS.md` — Node, Docker, and Rust install guides
- `RELEASES.md` — this file
- `ROADMAP.md` — what's coming next
- `public/` — branding assets (icon, etc.)

```bash
# Everything above, running in one command:
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub && cp .env.example .env
# Set CLI_API_TOKEN in .env
docker compose up -d
```

---

### 5 — NEST Rust Server — Phase 1 (In Progress)

A parallel Rust backend with full hexagonal architecture — clean separation between domain, ports, application, and adapters. This is the foundation for future enterprise extensibility.

| | |
|---|---|
| **Source** | [github.com/contextzero/nest](https://github.com/contextzero/nest) — `server/` |
| **Status** | 🔨 Phase 1 — REST API and storage complete; real-time (Socket.IO/SSE) and Telegram in progress |

**What's done in Phase 1:**
- Complete REST API surface
- SQLite persistence (development) via `rusqlite`
- Hexagonal architecture: `domain/` · `ports/` · `application/` · `adapters/`
- Built on Axum + Tokio + tower-http

**What's next for this component:** Full feature parity with the current server — real-time events, Socket.IO, Telegram. Tracked in [ROADMAP.md](ROADMAP.md).

```bash
# Build from source if you want to inspect the architecture
cargo build --release  # from the server/ directory
# See docs/INSTALL-FRAMEWORKS.md for Rust install
```

---

## How Versions Are Tracked

| Component | Versioning | Where to Check |
|-----------|-----------|----------------|
| **CLI** | Semantic versioning — `@contextzero/nest@x.y.z` | [npm](https://www.npmjs.com/package/@contextzero/nest) |
| **Server** | NEST repo release tags | [GitHub releases](https://github.com/contextzero/nest/releases) |
| **Web App** | NEST repo release tags | [GitHub releases](https://github.com/contextzero/nest/releases) |
| **Rust Server** | NEST repo, `server/` path | [GitHub](https://github.com/contextzero/nest) |
| **nest_hub** | Documentation + Docker image updates | [GitHub](https://github.com/contextzero/nest_hub) |

**Latest versions — always current:**
- CLI: [npmjs.com/package/@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)
- Server, Web, CLI source: [github.com/contextzero/nest/releases](https://github.com/contextzero/nest/releases)
- This distribution: [github.com/contextzero/nest_hub](https://github.com/contextzero/nest_hub)

---

## The Full Stack at a Glance

```
┌─────────────────────────────────────────────────────────────────┐
│  COMPONENT           │  STATUS    │  GET IT                     │
├─────────────────────────────────────────────────────────────────┤
│  annie CLI           │  ✅ Live   │  npm install -g @contextzero/nest │
│  NEST Server (Rust)  │  ✅ Live   │  docker compose up -d       │
│  NEST Web (PWA)      │  ✅ Live   │  http://localhost            │
│  nest_hub            │  ✅ Live   │  git clone + docker compose │
│  Rust Server Phase 2 │  🔨 WIP   │  ROADMAP.md                 │
└─────────────────────────────────────────────────────────────────┘
```

**Every ✅ item is publicly available right now.** No waitlist, no signup, no sales call required.

---

## What's Coming Next

Spec-driven development, Souls (persistent agent personas), extended multi-agent orchestration, and enterprise features are described in [ROADMAP.md](ROADMAP.md).

---

*Part of the [contextzero/nest](https://github.com/contextzero/nest) ecosystem. Business and workforce hub documentation: [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).*