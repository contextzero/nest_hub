# NEST — Full Installation Guide

<p align="center">
  <img src="./public/icon.svg" alt="NEST Hub" width="140" height="140" />
  <img src="./public/annie.png" alt="annie" width="120" height="120" />
</p>
**By Context Zero.** This guide gets the complete NEST stack running — server, database, web app, and CLI — using public Docker images. No Rust knowledge, no build from source, no cloud account required.

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

### Step 1.1 — Clone and initialize

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
cp .env.example .env
```

### Step 1.2 — Configure `.env`

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

### Step 1.3 — Start the stack

```bash
docker compose up -d
```

Docker will pull four images on first run (this takes 1–2 minutes depending on your connection). Subsequent starts are instant.

Watch the startup:

```bash
docker compose logs -f
```

You're ready when you see the nest-server health check pass. Look for a line like:
```
nest-server  | Server listening on 0.0.0.0:3000
```

### Step 1.4 — Verify the server is running

```bash
# Check all four containers are up
docker compose ps
```

All four should show `Up` or `healthy`:

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Open **http://localhost** in your browser. You should see the NEST web app. If it loads — your server is fully operational.

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
annie
```

**Verify the connection:**

```bash
annie auth status
```

Should print your server URL and confirm the token is set. If it shows an error, see [Common Issues](#common-issues).

### Step 2.3 — Start your first agent session

```bash
annie          # Claude Code — Anthropic's coding agent
annie codex    # OpenAI Codex
annie cursor   # Cursor Agent
annie gemini   # Google Gemini (via ACP)
annie opencode # OpenCode — open-source agent
annie kilocode # KiloCode — task execution with tight approval control
```

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