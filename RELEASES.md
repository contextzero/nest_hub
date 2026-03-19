# Releases and what we've built

This document summarizes the **current releases and deliverables** for NEST and this **terminal distribution** (ctx0_nest_terminal). We are building an **enterprise-grade solution** where organizations can participate. Updated as we ship new versions and components.

---

## Current releases

### NEST CLI (`@ctx0/nest`)

| Item | Description |
|------|-------------|
| **Package** | `@ctx0/nest` on npm |
| **Install** | `npm install -g @ctx0/nest` |
| **What it does** | Runs AI coding agent sessions (Claude Code, Codex, Cursor, Gemini, OpenCode) and connects them to the NEST Server via Socket.IO and REST. |
| **Features** | Session lifecycle, auth, worker daemon, RPC handlers (git, files, terminal, uploads, slash commands, skills), multi-agent modes. |

**Releases:** [npm](https://www.npmjs.com/package/@ctx0/nest) · [NEST repo](https://github.com/ctx0/nest)

---

### NEST Server (Rust) — public image

| Item | Description |
|------|-------------|
| **Docker image** | `matiasbaglieri/nest-server:latest` on Docker Hub |
| **Repository** | [ctx0/nest](https://github.com/ctx0/nest) — `server/` (Rust) |
| **What it does** | Central server: HTTP API, Socket.IO for CLI, SSE for web app, optional Telegram bot. |
| **Stack** | Rust, Axum, Socket.IO, Postgres. |
| **Features** | Sessions, messages, permissions, machines, git/files, events, JWT auth. |

**Deployment:** Pull the public image via this repo’s `docker-compose.yml` (ctx0_nest_terminal); no build required.

---

### NEST Web (React PWA) — public image

| Item | Description |
|------|-------------|
| **Docker image** | `matiasbaglieri/nest-web:latest` on Docker Hub |
| **Repository** | [ctx0/nest](https://github.com/ctx0/nest) — `web/` |
| **What it does** | Progressive Web App and Telegram Mini App for session list, chat, permissions, terminal, file browser, new session creation. |
| **Stack** | React 19, Vite, TanStack Router/Query, Tailwind, @assistant-ui/react, xterm.js, SSE. |
| **Features** | Sessions, messages, slash commands, skills, machines, git status/diff, terminal, voice, PWA install. |

**Served by:** NEST Server at the same origin (or static host + CORS).

---

### NEST Terminal (this repo) — Docker distribution

| Item | Description |
|------|-------------|
| **Repository** | [ctx0/ctx0_nest_terminal](https://github.com/ctx0/ctx0_nest_terminal) |
| **What it does** | Lets users run the NEST Server in Docker with one command; includes branding from `public/`. |
| **Deliverables** | `Dockerfile`, `docker-compose.yml`, `.env.example`, `QUICKSTART.md`, `docs/INSTALL-FRAMEWORKS.md`, `RELEASES.md`, `ROADMAP.md`. |
| **Image** | Builds Server + web from NEST source and overlays `public/` assets. |

**Usage:** `docker compose up -d` → Web app and API at http://localhost (port 80).

---

### NEST Rust server (phase 1)

| Item | Description |
|------|-------------|
| **Repository** | [ctx0/nest](https://github.com/ctx0/nest) — `server/` |
| **What it does** | Alternative HTTP backend with hexagonal architecture (domain, ports, application, adapters). SQLite persistence, Axum, no Socket.IO/SSE/Telegram yet. |
| **Stack** | Rust, Tokio, Axum, tower-http, rusqlite. |
| **Status** | Phase 1 — REST API and storage; realtime and full feature parity with the TypeScript Server are pending. |

**Build:** `cargo build --release` in `server/`. See [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) for Rust install.

---

## Versioning and release flow

- **CLI:** Versioned and published to npm (e.g. `@ctx0/nest@0.2.x`).
- **Server / Web / Rust server:** Follow the NEST repo’s release tags and changelog.
- **ctx0_nest_terminal:** Documentation and Docker image updates are tracked in this repo; image tags can follow NEST or calendar versioning.

For the latest versions and download links, see:

- **CLI:** [npm @ctx0/nest](https://www.npmjs.com/package/@ctx0/nest)
- **NEST (Server, Web, CLI source):** [GitHub ctx0/nest releases](https://github.com/ctx0/nest/releases)
- **This distribution:** [GitHub ctx0/ctx0_nest_terminal](https://github.com/ctx0/ctx0_nest_terminal)

---

## What’s next

Planned and in-progress work (Souls, multi-agents, spec-driven development) is described in [ROADMAP.md](ROADMAP.md).

---

*Part of the [ctx0/nest](https://github.com/ctx0/nest) ecosystem. See [docs/holding](https://github.com/ctx0/nest/tree/main/docs/holding) for business and workforce hub docs.*
