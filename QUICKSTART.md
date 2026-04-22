<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Quick Start

[English](./QUICKSTART.md) | [Español](./QUICKSTART-ES.md) | [中文](./QUICKSTART-ZH.md) | [Deutsch](./QUICKSTART-DE.md) | [Português](./QUICKSTART-PT.md) | [Français](./QUICKSTART-FR.md)

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.
From zero to a live AI workforce hub in under 5 minutes.

---

## Before You Start — What You'll Have When You're Done

In the next 5 minutes you will:

1. ✅ Deploy the NEST server (Rust + Postgres + nginx) locally with **one command**
2. ✅ Install the `annie` CLI on any machine
3. ✅ Start your first real AI agent session (Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode—and from **Jun 1, 2026**, ZeroClaw / OpenClaw **via `annie computer`**)
4. ✅ Watch it **live from your browser** — and from your phone

No prior Rust knowledge required. No cloud account needed. No credit card. If Docker runs on your machine, NEST runs on your machine.

---

## Step 0 — Prerequisites (2 minutes if you need them)

You need three things. Check each:

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**All four pass?** Jump to Step 1.

**Missing something?** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — installs Node, npm, and Docker in minutes on Mac, Linux, or Windows.

> **Why these?** Node + npm power the `annie` CLI you'll install on employee machines. Docker runs the server without you needing to install Rust, Postgres, or nginx yourself.

---

## Step 1 — Deploy the Hub (60 seconds)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

That's it. `setup.sh` auto-generates all secrets, pulls Docker images, starts the stack, and waits for health. When you see:

```
=== NEST ready ===
  Web:  http://localhost
```

Your hub is live. Open it in your browser — and on your phone.

> **What just happened?** `setup.sh` created a `.env` with auto-generated `POSTGRES_PASSWORD`, `CLI_API_TOKEN`, and `ENCRYPTION_KEY`. It then pulled and started four containers: `nest-server` (Rust), `nest-web` (React PWA), `postgres`, and `nginx`.

---

## Step 2 — Install the CLI on Any Machine (30 seconds)

The `annie` CLI is what your employees (or you) install on the machines where AI agents run. Install it globally:

```bash
npm install -g @contextzero/nest
```

Confirm it works:

```bash
annie --help
```

You should see the full command list. The CLI is now ready on this machine.

> **One install per machine.** Each person who will run agent sessions needs to install `annie` on their own machine and point it at your server.

---

## Step 3 — Connect to Your Server (30 seconds)

You have two options — pick one:

**Option A: Environment variables (great for scripts and CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **Where's your token?** `setup.sh` saved it in `.env`. Run: `grep CLI_API_TOKEN .env` to see it.

**Option B: Interactive login (saves credentials permanently)**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

Verify the connection:

```bash
annie auth status
```

You should see your server URL and a confirmed token. **You're authenticated.**

---

## Step 4 — Start Your First Agent Session

Pick your agent and run one command (package: **`@contextzero/nest`** → **`annie`**). **Enterprise command reference:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md).

| Agent | Command | What it does |
|-------|---------|--------------|
| **Claude Code** | `annie claude` | Anthropic's flagship coding agent |
| **Codex** | `annie codex` | OpenAI's code execution agent |
| **Cursor** | `annie cursor` | Cursor IDE agent mode |
| **Gemini** | `annie gemini` | Google's multimodal agent |
| **OpenCode** | `annie opencode` | Open-source coding agent |
| **KiloCode** | `annie kilocode` | Task execution + remote control |
| **Computer (management)** | `annie computer` | Multi-tool hub agent (shell, browser, files—governed like other sessions) |
| **ZeroClaw / OpenClaw** | *via `annie computer` (from Jun 1, 2026)* | Wrappers inside Computer (same pattern as Claude, Cursor, …)—see [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) and [RELEASES.md](RELEASES.md); not standalone `annie` subcommands. |

**Automation note:** if the first argument is not a known subcommand, the CLI treats the invocation as **`annie cursor`**. Always type **`annie claude`**, **`annie computer`**, etc. explicitly—especially in CI.

Example — start Claude Code:

```bash
annie claude
```

The terminal will show the session connecting and streaming. **Don't close this terminal.** The agent is live.

---

## Step 5 — Your AHA Moment 🎯

Switch to your browser (or phone) and open:

```
http://localhost
```

**You should now see the live session in the dashboard.**

From here you can:
- 💬 **Chat** with the running agent in real time
- ✅ **Approve or reject** permission requests from the agent
- 🖥️ **Watch the terminal** output as it runs
- 📱 **Do all of this from your phone** — the PWA works on any mobile browser

This is the moment. You just turned a CLI session running on someone's laptop into a **remotely visible, approvable, auditable AI session** you can monitor from anywhere.

---

## Quick Reference — Most Useful Commands

```bash
annie claude            # Claude Code session
annie codex             # Codex session
annie cursor            # Cursor agent
annie gemini            # Gemini session
annie opencode          # OpenCode session
annie kilocode          # KiloCode session
annie computer          # Multi-tool management / automation session
annie worker start      # Background worker (remote spawn)
annie worker list       # Active worker sessions
annie auth login        # Save credentials interactively
annie auth status       # Check current auth config
annie diagnose          # Run diagnostics if something feels off
```

**Server management (from the `nest_hub/` folder):**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## What Just Happened — And Why It Matters

You now have:

| What | Where | Why It Matters |
|------|-------|----------------|
| Live session dashboard | Browser / phone | See every agent session your team runs, in real time |
| Approval workflow | Mobile PWA | Agents wait for your OK before high-stakes actions |
| Full audit log | Your PostgreSQL | Every message, every action, persisted on your server |
| Multi-agent support | Any employee machine | Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode, plus **Computer** (ZeroClaw / OpenClaw wrappers from **Jun 1, 2026**) — all in one hub |
| Zero monthly cost | Your infrastructure | You own the server, the data, and the keys |

> **Ready for more?** Explore these docs:
> - [Business Overview](docs/business/README.md) — Strategic value for founders
> - [Value Proposition](docs/business/value-proposition.md) — Detailed benefits
> - [Methodology](docs/methodology/README.md) — Implementation guide
> - [Enterprise Features](docs/enterprise/README.md) — For scaling organizations

---

## Next Steps

| What you want to do | Where to go |
|---------------------|-------------|
| Deploy on a real server with HTTPS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| Configure LLM keys (Vertex, OpenRouter, DeepInfra, ElevenLabs...) | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Add more employee machines | Share this doc + your `NEST_API_URL` + the token |
| Understand OpenClaw / ZeroClaw agent modes | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Business value for founders | [docs/business/README.md](docs/business/README.md) |
| Implementation methodology | [docs/methodology/README.md](docs/methodology/README.md) |
| Full environment variable reference | [README.md](README.md) |
| See what's coming | [ROADMAP.md](ROADMAP.md) |
| Check the changelog | [RELEASES.md](RELEASES.md) |

---

## Troubleshooting — Fast Fixes

| Problem | Fix |
|---------|-----|
| `annie` not found after install | Run `npm install -g @contextzero/nest` again; check your `$PATH` |
| Web app shows blank / won't load | Wait 30s for DB init; run `docker compose logs nest-server` |
| `401 Unauthorized` in CLI | Token mismatch — `setup.sh` generates it automatically. Run `grep CLI_API_TOKEN .env` to see your token. |
| Port 80 already in use | Set `WEB_PORT=8080` in `.env`, then `docker compose restart` |
| Session not appearing in dashboard | Confirm `NEST_API_URL` in CLI points to the correct server address |
| Something else is wrong | Run `annie diagnose` — it prints a full diagnostic report |

---

> **You're running an enterprise-grade AI workforce hub. For free. On your own infrastructure.**
> 
> When you're ready to take it further — HTTPS, multiple teams, custom LLM routing — everything is in [docs/DEVOPS.md](docs/DEVOPS.md) and [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>