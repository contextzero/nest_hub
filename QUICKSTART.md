# NEST Hub — Quick Start

<p align="center">
  <img src="./public/icon.svg" alt="NEST Hub" width="140" height="140" />
  <img src="./public/annie.png" alt="annie" width="120" height="120" />
</p>
**By Context Zero.** From zero to a live AI workforce hub in under 5 minutes. Server running, agent connected, first session visible on your phone — that's the finish line. Let's go.

---

## Before You Start — What You'll Have When You're Done

In the next 5 minutes you will:

1. ✅ Deploy the NEST server (Rust + Postgres + nginx) locally with **one command**
2. ✅ Install the `annie` CLI on any machine
3. ✅ Start your first real AI agent session (Claude Code, Codex, Cursor, or Gemini)
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

## Step 1 — Get the Stack (30 seconds)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
cp .env.example .env
```

Now open `.env` in any text editor. You only need to set **one value**:

```env
CLI_API_TOKEN=your-secret-here
```

Generate a strong one instantly:

```bash
openssl rand -hex 32
```

Copy the output, paste it as your `CLI_API_TOKEN`. Save the file.

> **This token is the single key** that connects your CLI to your server. Keep it secret. You can rotate it any time by changing it in `.env` and restarting the stack.

---

## Step 2 — Launch the Server (60 seconds)

```bash
docker compose up -d
```

This pulls and starts four containers:
- `nest-server` — the Rust/Axum API + Socket.IO + SSE engine
- `nest-web` — the React PWA served by nginx
- `postgres` — your session and audit database
- `nginx` — routes everything through port 80

**Wait ~30 seconds** for the health check to pass, then open:

```
http://localhost
```

You should see the NEST web app. **That's your control center.** Bookmark it — and open it on your phone too.

> **Troubleshooting:** If the page doesn't load, run `docker compose logs nest-server` and wait another 15 seconds for the DB to initialize fully.

---

## Step 3 — Install the CLI on Any Machine (30 seconds)

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

## Step 4 — Connect to Your Server (30 seconds)

You have two options — pick one:

**Option A: Environment variables (great for scripts and CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

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

## Step 5 — Start Your First Agent Session

Pick your agent and run one command:

| Agent | Command | What it does |
|-------|---------|--------------|
| **Claude Code** | `annie` | Anthropic's flagship coding agent |
| **Codex** | `annie codex` | OpenAI's code execution agent |
| **Cursor** | `annie cursor` | Cursor IDE agent mode |
| **Gemini** | `annie gemini` | Google's multimodal agent |
| **OpenCode** | `annie opencode` | Open-source coding agent |
| **KiloCode** | `annie kilocode` | Task execution + remote control |

Example — start Claude Code:

```bash
annie
```

The terminal will show the session connecting and streaming. **Don't close this terminal.** The agent is live.

---

## Step 6 — Your AHA Moment 🎯

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
annie                   # Start Claude Code session
annie codex             # Start Codex session
annie cursor            # Start Cursor agent
annie gemini            # Start Gemini session
annie opencode          # Start OpenCode session
annie kilocode          # Start KiloCode session
annie worker start      # Start background worker (remote spawn)
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
| Multi-agent support | Any employee machine | Claude, Codex, Cursor, Gemini — all in one hub |
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
| `401 Unauthorized` in CLI | Token mismatch — confirm `CLI_API_TOKEN` in `.env` equals what `annie` is using |
| Port 80 already in use | Set `WEB_PORT=8080` in `.env`, then `docker compose restart` |
| Session not appearing in dashboard | Confirm `NEST_API_URL` in CLI points to the correct server address |
| Something else is wrong | Run `annie diagnose` — it prints a full diagnostic report |

---

> **You're running an enterprise-grade AI workforce hub. For free. On your own infrastructure.**
> 
> When you're ready to take it further — HTTPS, multiple teams, custom LLM routing — everything is in [docs/DEVOPS.md](docs/DEVOPS.md) and [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).