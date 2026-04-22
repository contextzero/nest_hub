<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Releases & What's Shipped

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.
Every component that exists today — real software, running now, free to deploy.

> **Trust is built on one question:** *"Have you done it before?"*
> Every item below points to a **public npm package**, **public Docker image**, or **this public docs / compose repo** (`nest_hub`). Click the links and verify for yourself.

---

## What's Live Today

### 1 — NEST CLI (`@contextzero/nest`)

The command employees run on their machines to start AI agent sessions and connect them to your server.

| | |
|---|---|
| **Package** | [`@contextzero/nest`](https://www.npmjs.com/package/@contextzero/nest) on npm |
| **Install** | `npm install -g @contextzero/nest` |
| **Docs / compose** | [github.com/contextzero/nest_hub](https://github.com/contextzero/nest_hub) (this repo) |
| **Status** | ✅ Live — install and run today |

**What it ships:**
- **Development agents:** **Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode** (`annie claude`, `annie codex`, …)
- **Computer (hub management):** **`annie computer`** — multi-tool agent on the hub (shell, browser, files)
- **Computer wrappers (Jun 1, 2026):** **OpenClaw**, **ZeroClaw**, and **Hermes** ship **inside `annie computer`** alongside other agent wrappers (Claude, Cursor, …)—not as `annie openclaw` / `annie zeroclaw` / `annie hermes`. See [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md).
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
| **Build artifact** | Published server binary inside the image above |
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
| **Build artifact** | Published web bundle inside the image above |
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
- `setup.sh` — auto-generates `.env` with all secrets on first run
- `QUICKSTART.md` — server live in 5 minutes, no prior experience needed
- `docs/INSTALL.md` — complete installation reference
- `docs/DEVOPS.md` — production setup: HTTPS, public URL, scaling
- `docs/CLI-BUSINESS.md` — agent modes, OpenClaw, ZeroClaw, LLM provider config
- `docs/INSTALL-FRAMEWORKS.md` — Node, Docker, and Rust install guides
- `RELEASES.md` — this file
- `ROADMAP.md` — what's coming next
- `public/` — branding assets (icon, etc.)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

---

### 5 — NEST Rust Server — Architecture

The NEST server is built with a hexagonal architecture — clean separation between domain, ports, application, and adapters.

| | |
|---|---|
| **Distribution** | Server behavior ships in **`matiasbaglieri/nest-server`** (Docker Hub) |
| **Architecture** | Hexagonal: `domain/` · `ports/` · `application/` · `adapters/` |
| **Stack** | Rust · Axum · Tokio · tower-http · PostgreSQL |
| **Status** | ✅ Live — powering the platform |

---

## How Versions Are Tracked

| Component | Versioning | Where to Check |
|-----------|-----------|----------------|
| **CLI** | Semantic versioning — `@contextzero/nest@x.y.z` | [npm](https://www.npmjs.com/package/@contextzero/nest) |
| **Server** | Docker image tags / digests | [Docker Hub — nest-server](https://hub.docker.com/r/matiasbaglieri/nest-server) |
| **Web App** | Docker image tags / digests | [Docker Hub — nest-web](https://hub.docker.com/r/matiasbaglieri/nest-web) |
| **Rust Server** | Shipped as the **`nest-server`** container image | [Docker Hub — nest-server](https://hub.docker.com/r/matiasbaglieri/nest-server) |
| **nest_hub** | Documentation + Docker Compose wiring | [GitHub](https://github.com/contextzero/nest_hub) |

**Latest versions — always current:**
- CLI: [npmjs.com/package/@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)
- Server + Web: pull `matiasbaglieri/nest-server` and `matiasbaglieri/nest-web` from Docker Hub (see `docker-compose.yml` in this repo)
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
│  Rust Server         │  ✅ Live   │  See Section 5 above        │
└─────────────────────────────────────────────────────────────────┘
```

**Every ✅ item is publicly available right now.** No waitlist, no signup, no sales call required.

---

## What's Coming Next

Spec-driven development, Souls (persistent agent personas), extended multi-agent orchestration, and enterprise features are described in [ROADMAP.md](ROADMAP.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>