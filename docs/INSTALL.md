<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Full Installation Guide

[English](./INSTALL.md) | [Español](./INSTALL-ES.md) | [中文](./INSTALL-ZH.md) | [Deutsch](./INSTALL-DE.md) | [Português](./INSTALL-PT.md) | [Français](./INSTALL-FR.md)

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.

This guide gets the complete NEST stack running — server, database, web app, and CLI — using public Docker images. No Rust knowledge, no build from source, no cloud account required.

> **In a hurry?** → [QUICKSTART.md](../QUICKSTART.md) gets you live in 5 minutes with the essential steps only.
> This guide is the complete reference — every option, every flag, every troubleshooting path.

---

## What Gets Installed

| Component | How It Arrives | What It Does |
|-----------|---------------|--------------|
| **NEST Server** | Docker pulls `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker pulls `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker pulls `postgres:16-alpine` | Persists all sessions, messages, and audit events in a named volume |
| **nginx** | Docker pulls `nginx:alpine` | Single entry point on port 80 — routes `/api/*`, `/ws/*`, SSE, and PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | Runs agent sessions on employee machines; connects to your server |

**Zero compilation.** Docker pulls the pre-built server image. `npm` pulls the pre-built CLI. The entire stack is running in under 2 minutes on any machine with Docker and Node.

---

## Prerequisites

Two machines, two requirements:

| Machine | Needs |
|---------|-------|
| **Server machine** (hosts the stack) | Docker + Docker Compose |
| **Employee machines** (run agents) | Node.js 18+ and npm |

The server machine and an employee machine can be the same machine during setup — that's the standard local development flow.

**Don't have these yet?** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) covers every OS.

---

## Part 1 — Server Setup

### Step 1.1 — Clone and run setup

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

The setup script generates a secure `CLI_API_TOKEN`, creates your `.env`, and starts the full stack. Follow the prompts — the entire process takes under 2 minutes.

Once complete, open **http://localhost** in your browser. You should see the NEST web app. If it loads — your server is fully operational.

### Step 1.2 — Verify the server is running

```bash
docker compose ps
```

All four containers should show `Up` or `healthy`:

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Watch the startup logs:

```bash
docker compose logs -f
```

You're ready when you see the nest-server health check pass. Look for a line like:
```
nest-server  | Server listening on 0.0.0.0:3000
```

### Advanced: Manual Configuration

If you prefer to configure `.env` manually instead of using `./setup.sh`:

```bash
cp .env.example .env
```

Open `.env` in any text editor. The only value you must set is `CLI_API_TOKEN`:

```env
# REQUIRED — shared secret between CLI and server
# Generate a strong one: openssl rand -hex 32
CLI_API_TOKEN=your-strong-secret-here

# Optional — change if port 80 is in use on your machine
WEB_PORT=80

# Optional — change the default Postgres password (recommended for production)
POSTGRES_PASSWORD=changethis

# Optional — expose Postgres on the host for backups or admin tools
# Set to empty to keep it internal only
PGPORT=5433

# Optional — set for production HTTPS deployments
# NEST_PUBLIC_URL=https://nest.yourdomain.com

# Optional — Telegram bot integration
# TELEGRAM_BOT_TOKEN=your-telegram-token
```

**The minimum viable `.env` for local use:**
```env
CLI_API_TOKEN=paste-your-generated-token-here
```

Everything else has sensible defaults for local deployment.

> **Security note:** `CLI_API_TOKEN` is the single key that connects your team's CLIs to your server. Generate it with `openssl rand -hex 32`. Never commit `.env` to version control.

Then start the stack:

```bash
docker compose up -d
```

Docker will pull four images on first run (this takes 1–2 minutes depending on your connection). Subsequent starts are instant.

---

## Part 2 — CLI Setup

Do this on **every machine** where an employee will run agent sessions.

### Step 2.1 — Install

```bash
npm install -g @contextzero/nest
```

Verify:

```bash
annie --help
```

You should see the full command list. If `annie` is not found, see [Common Issues](#common-issues) below.

### Step 2.2 — Connect to your server

You have two options:

**Option A — Interactive login (saves permanently, recommended)**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

Credentials are saved to `~/.nest/config`. Every subsequent `annie` command uses them automatically — no environment variables needed per session.

**Option B — Environment variables (useful for CI/CD or scripting)**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**Verify the connection:**

```bash
annie auth status
```

Should print your server URL and confirm the token is set. If it shows an error, see [Common Issues](#common-issues).

### Step 2.3 — Start your first agent session

Package: **`npm install -g @contextzero/nest`** → **`annie`**. Full command reference: [enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md).

```bash
annie claude     # Claude Code — Anthropic's coding agent
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini (via ACP)
annie opencode   # OpenCode — open-source agent
annie kilocode   # KiloCode — task execution with tight approval control
annie computer   # Computer — multi-tool management agent on the hub (shell, browser, files)
```

**Automation:** if the first argument is not a known subcommand, the CLI behaves like **`annie cursor`**. In scripts and CI, always use an explicit subcommand (`annie claude`, `annie computer`, …).

**ZeroClaw / OpenClaw** will be exposed **inside `annie computer`** as wrappers (same pattern as Claude, Cursor, …) from **June 1, 2026**—not as separate `annie` subcommands. See [enterprise/zeroclaw.md](enterprise/zeroclaw.md) and [RELEASES.md](../RELEASES.md).

Once a session starts, open **http://localhost** in your browser (or on your phone). The session appears in the dashboard in real time.

---

## Port Reference

| Host Port | Service | Notes |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | Change with `WEB_PORT` in `.env` |
| `5433` | PostgreSQL (optional host exposure) | Set `PGPORT=` (empty) to keep internal only |

All API traffic, Socket.IO, and SSE pass through nginx on port 80. No additional ports need to be opened for basic operation.

---

## Server Management Commands

Run these from the `nest_hub/` directory:

```bash
# Start the stack (detached)
docker compose up -d

# Stop the stack (preserves data in Postgres volume)
docker compose down

# Stop and delete all data (destructive — removes the Postgres volume)
docker compose down -v

# Stream all logs
docker compose logs -f

# Stream logs for a specific container
docker compose logs -f nest-server

# Check container status
docker compose ps

# Restart after .env changes
docker compose restart

# Pull latest images and restart
docker compose pull && docker compose up -d
```

---

## Common Issues

| Symptom | Cause | Fix |
|---------|-------|-----|
| `annie: command not found` | npm global bin not in PATH | Run `npm bin -g` to find the path, add it to your `$PATH`. Or switch to nvm — see [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| `401 Unauthorized` from CLI | Token mismatch | Confirm `CLI_API_TOKEN` in `.env` exactly matches what's in `~/.nest/config` or your `export`. No quotes, no spaces |
| Web app blank / 502 Bad Gateway | Server still starting | Wait 30s, then run `docker compose logs nest-server`. Look for the health check pass line |
| Port 80 already in use | Another service on port 80 | Set `WEB_PORT=8080` in `.env`, then `docker compose restart` |
| `docker compose` not found | Docker Compose V1 installed | Update Docker Desktop, or install `docker-compose-plugin`. NEST uses V2 (`docker compose`, not `docker-compose`) |
| Postgres connection errors | DB initializing | First-run DB init takes ~10s. Wait and retry. Check logs with `docker compose logs postgres` |
| Session not appearing in dashboard | Wrong `NEST_API_URL` | The URL in `annie auth status` must match your server's actual address (not `localhost` if connecting from another machine) |

**Still stuck?** Run `annie diagnose` on the machine where the CLI is installed. It prints a full connectivity and auth diagnostic report.

---

## Production Deployment

For a public-facing NEST deployment (remote team, HTTPS, custom domain):

1. Set `NEST_PUBLIC_URL=https://nest.yourdomain.com` in `.env`
2. Configure TLS termination on nginx (or a load balancer in front of it)
3. Set a strong `POSTGRES_PASSWORD` and keep `PGPORT` empty (don't expose Postgres externally)
4. Rotate `CLI_API_TOKEN` with `openssl rand -hex 32` — then update all employee CLIs with `annie auth login`

Full production reference: [DEVOPS.md](DEVOPS.md)

---

## Next Steps

| What you want to do | Where to go |
|---------------------|-------------|
| 5-minute setup summary | [QUICKSTART.md](../QUICKSTART.md) |
| Install Node, Docker, Rust | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| Configure LLM keys (Vertex, OpenRouter, DeepInfra...) | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| Production, HTTPS, public URL | [DEVOPS.md](DEVOPS.md) |
| Business value for founders | [business/README.md](business/README.md) |
| Implementation methodology | [methodology/README.md](methodology/README.md) |
| Enterprise features | [enterprise/README.md](enterprise/README.md) |
| All commands and config reference | [README.md](../README.md) |
| What's coming next | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>