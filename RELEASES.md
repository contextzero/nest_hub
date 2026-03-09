# Releases and what we've built

This document summarizes the **current releases and deliverables** for NEST and the Facta distribution (ctx0_nest_terminal). It is updated as we ship new versions and components.

---

## Current releases

### NEST CLI (`@factadev/cli`)

| Item | Description |
|------|-------------|
| **Package** | `@factadev/cli` on npm |
| **Install** | `npm install -g @factadev/cli` |
| **What it does** | Runs AI coding agent sessions (Claude Code, Codex, Cursor, Gemini, OpenCode) and connects them to the NEST Server via Socket.IO and REST. |
| **Features** | Session lifecycle, auth, worker daemon, RPC handlers (git, files, terminal, uploads, slash commands, skills), multi-agent modes. |

**Releases:** [npm](https://www.npmjs.com/package/@factadev/cli) · [NEST repo](https://github.com/ctx0/nest)

---

### NEST Server (TypeScript/Bun)

| Item | Description |
|------|-------------|
| **Repository** | [ctx0/nest](https://github.com/ctx0/nest) — `hub/` (Server binary) |
| **What it does** | Central server: HTTP API, Socket.IO for CLI connections, SSE for the web app, optional Telegram bot and Web Push. |
| **Stack** | Hono, Bun, Socket.IO, SQLite (better-sqlite3), JWT auth. |
| **Features** | Sessions, messages, permissions, machines, git/files, events, voice (ElevenLabs), push, visibility. |

**Deployment:** Run with `nest server` or deploy via Docker using this repo (ctx0_nest_terminal).

---

### NEST Web (React PWA)

| Item | Description |
|------|-------------|
| **Repository** | [ctx0/nest](https://github.com/ctx0/nest) — `web/` |
| **What it does** | Progressive Web App and Telegram Mini App for session list, chat, permissions, terminal, file browser, new session creation. |
| **Stack** | React 19, Vite, TanStack Router/Query, Tailwind, @assistant-ui/react, xterm.js, SSE. |
| **Features** | Sessions, messages, slash commands, skills, machines, git status/diff, terminal, voice, PWA install. |

**Served by:** NEST Server at the same origin (or static host + CORS).

---

### NEST Terminal (this repo) — Docker distribution

| Item | Description |
|------|-------------|
| **Repository** | [Facta-Dev/ctx0_nest_terminal](https://github.com/Facta-Dev/ctx0_nest_terminal) |
| **What it does** | Lets users run the NEST Server in Docker with one command; includes branding (logo, powered by facta.dev) from `public/`. |
| **Deliverables** | `Dockerfile`, `docker-compose.yml`, `.env.example`, `QUICKSTART.md`, `docs/INSTALL-FRAMEWORKS.md`, `RELEASES.md`, `ROADMAP.md`. |
| **Image** | Builds Server + web from NEST source and overlays `public/` assets. |

**Usage:** `docker compose up -d` → Server at http://localhost:3006.

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

- **CLI:** Versioned and published to npm (e.g. `@factadev/cli@0.2.x`).
- **Server / Web / Rust server:** Follow the NEST repo’s release tags and changelog.
- **ctx0_nest_terminal:** Documentation and Docker image updates are tracked in this repo; image tags can follow NEST or calendar versioning.

For the latest versions and download links, see:

- **CLI:** [npm @factadev/cli](https://www.npmjs.com/package/@factadev/cli)
- **NEST (Server, Web, CLI source):** [GitHub ctx0/nest releases](https://github.com/ctx0/nest/releases)
- **This distribution:** [GitHub Facta-Dev/ctx0_nest_terminal](https://github.com/Facta-Dev/ctx0_nest_terminal)

---

## What’s next

Planned and in-progress work (Souls, multi-agents, spec-driven development) is described in [ROADMAP.md](ROADMAP.md).

---

*Powered by [facta.dev](https://facta.dev).*
