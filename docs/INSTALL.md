# NEST — Installation

Install the **NEST CLI** and run the **NEST Server** using the **public Docker images**. No build from source required.

---

## What you get

| Component | How you get it |
|-----------|----------------|
| **NEST Server + Web** | Docker Compose pulls `matiasbaglieri/nest-server:latest` and `matiasbaglieri/nest-web:latest`. |
| **Postgres** | Official `postgres:16-alpine` (data in a Docker volume). |
| **Nginx** | Reverse proxy; web app and API on one port (default 80). |
| **NEST CLI** | `npm install -g @ctx0/nest` — runs agents and connects to the server. |

---

## Prerequisites

- **Docker** and **Docker Compose** — to run the server stack.
- **Node.js 18+** and **npm** — to install the NEST CLI.

See [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) for installing Node, Docker, etc. on your OS.

---

## 1. Server (Docker, public images)

### 1.1 Clone this repo and set env

```bash
git clone https://github.com/ctx0/ctx0_nest_terminal.git
cd ctx0_nest_terminal
cp .env.example .env
```

### 1.2 Edit `.env`

Set at least **`CLI_API_TOKEN`** — shared secret for CLI and web. Example: `openssl rand -hex 32`.

Optionally set a strong **`POSTGRES_PASSWORD`** and **`WEB_PORT`** (default 80).

### 1.3 Start the stack

```bash
docker compose up -d
```

Server and web app are available at **http://localhost** (or `http://localhost:${WEB_PORT}` if you changed it).

### 1.4 Check

- Open http://localhost — you should see the NEST web app.
- `docker compose logs -f` — follow logs.

---

## 2. CLI (npm)

### 2.1 Install

```bash
npm install -g @ctx0/nest
nest --help
```

### 2.2 Configure

The CLI must use the **same** `CLI_API_TOKEN` as the server and the correct server URL.

**Option A — environment**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
nest
```

**Option B — save token once**

```bash
export NEST_API_URL="http://localhost"
nest auth login
# Enter the same CLI_API_TOKEN when prompted
nest
```

### 2.3 Run a session

```bash
nest          # Claude Code
nest codex    # Codex
nest cursor  # Cursor Agent
nest gemini  # Gemini
nest opencode # OpenCode
```

---

## 3. Ports

| Port (host) | Service |
|-------------|---------|
| 80 (default) | Nginx — web app + API (single entrypoint). |
| 5433 (default) | Postgres — optional; for backups/admin. Set `PGPORT` in `.env` to change or avoid exposing. |

---

## 4. Troubleshooting

| Issue | What to do |
|-------|------------|
| CLI "Unauthorized" or 401 | `CLI_API_TOKEN` must match exactly in `.env` and CLI (`export` or `nest auth login`). |
| Web app blank or 502 | Wait for `nest-server` healthcheck to pass; check `docker compose logs nest-server`. |
| Port 80 in use | Set `WEB_PORT=8080` (or another free port) in `.env` and restart. |

Run **`nest diagnose`** on the machine where the CLI runs for connectivity and token checks.

---

## 5. Next steps

- [QUICKSTART.md](../QUICKSTART.md) — short version of this flow.
- [README.md](../README.md) — overview, commands, configuration.
- [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) — install Node, Docker, Rust.
