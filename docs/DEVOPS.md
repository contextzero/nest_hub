<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# DevOps Reference

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.

This page summarizes deployment, configuration, and URL rules for the stack (server, web, annie CLI).

---

## Overview

| Service | Role |
|---------|------|
| **nest-server** | Rust API, Socket.IO, SSE, token authority. Port 8088 (internal). |
| **nest-web** | Static PWA (nginx). Port 3006 (internal). |
| **nginx** | Reverse proxy. Host port 80 (default); routes `/` → web, `/api`, `/ws`, `/api/events` → server. |
| **Postgres** | Data; server uses `DATABASE_URL`. |

The **CLI** (command: **annie**) and the browser connect to **nginx**; nginx routes to the server and web. The **server** (nest-server) holds `CLI_API_TOKEN`; you configure the same token when running **annie** on your machine.

---

## Configuration (`.env`)

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | **Yes** | Shared secret for CLI and web; must match what annie uses. |
| `POSTGRES_USER` / `POSTGRES_PASSWORD` / `POSTGRES_DB` | No | Defaults: postgres, changethis, nest. |
| `WEB_PORT` | No | Host port for nginx (default 80). |
| `NEST_PUBLIC_URL` | No | Public HTTPS URL for PWA/Telegram. |
| `ENCRYPTION_KEY` | No | Server DB encryption; stable per database. Back up; changing it invalidates encrypted data. |
| `TELEGRAM_BOT_TOKEN` | No | Optional Telegram bot. |

See `.env.example` in this repo for the full list.

---

## Scenarios

| Scenario | What to do |
|----------|------------|
| **Local (localhost)** | `./setup.sh` (auto-generates secrets and starts the stack). On the machine where you run the CLI: set `NEST_API_URL=http://localhost` and the same token; then run **annie**. |
| **Production, SSL on load balancer (e.g. AWS ACM)** | Configure your load balancer for HTTPS (e.g. ACM certificate); point it to nginx on port 80. Set `NEST_PUBLIC_URL` to your HTTPS domain. |
| **Production, SSL on host (Let's Encrypt)** | Use a reverse proxy (e.g. nginx or Caddy) with certbot on the host; proxy to `nest-server` and `nest-web`; set `NEST_PUBLIC_URL`. |

This repo provides the **Docker Compose** stack with public images. For custom nginx config, edit `nginx/conf.d/` and rebuild or mount your config.

---

## URL routing (annie and web)

| Context | URL you use | How it connects |
|---------|-------------|------------------|
| **localhost or IP** (same machine / dev) | `http://localhost`, `http://192.168.1.10` | Effective URL may include port (e.g. `:8080`) when talking to server directly. |
| **Domain (production)** | `https://nest.example.com` | No port; nginx on 80/443 fronts the server. |

- Use **annie auth login** with the **logical** URL: `http://localhost` or `https://nest.example.com`.
- Same rule for the web app: use the logical URL for both the **annie** CLI and the browser.

---

## Health and logs

- **Server health:** `GET /health`, `GET /ready`.
- **Logs:** `docker compose logs -f` (or `docker compose logs -f nest-server`).
- **CLI diagnostics:** Run **`annie diagnose`** on the client.

---

## Links

- [README](../README.md) · [INSTALL](INSTALL.md) · [CLI (business)](CLI-BUSINESS.md)

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
