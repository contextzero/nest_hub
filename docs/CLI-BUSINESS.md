<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# CLI (annie) — Business Overview

**By Context Zero.** This page is for **business owners and team leads** — the people who decide how the AI workforce runs, not the people who write the code. If you're looking for install commands or raw configuration, see [INSTALL.md](INSTALL.md) and [README.md](../README.md).

---

## The One Sentence That Matters

> **`annie` is what runs on your employees' machines. The server — running on your infrastructure — is what gives you control over all of it.**

That distinction is everything. The CLI (`annie`) is a thin runner. It starts agents, connects them to your server, and streams events back. The **server** is the authority: it holds the sessions, the audit log, the permissions, and optionally the LLM credentials. Your employees run agents; you run the hub.

---

## How the System Works — For a Business Owner

```
Your Employees' Machines          Your Server (Docker)          Your Phone / Tablet
────────────────────────    ────────────────────────────    ──────────────────────────
  annie CLI                 ←──  NEST Server (Rust)       ←──  Mobile PWA
  (Claude, Codex,           ←──  Session authority         ←──  Live sessions
   Cursor, Gemini...)       ←──  Audit log (Postgres)      ←──  Approve / reject
  Executes locally          ←──  LLM keys (server-side)    ←──  Terminal view
  Reports everything        ←──  Permission enforcement    ←──  Real-time chat
```

**Your LLM API keys never touch employee machines.** They're configured on the server, in Admin. Employees run agents that use the server's credentials — they never see the keys, never store them, never misplace them.

**Every action is audited on your PostgreSQL instance.** Not on a third-party SaaS. Not on our servers. Yours.

---

## The Eight Agent Modes

Every mode runs through the same hub. Every session is visible from the same mobile dashboard. Every approval comes to the same place: your phone.

| Command | Agent | What It Does For Your Business |
|---------|-------|-------------------------------|
| `annie` | **Claude Code** | Anthropic's flagship coding agent. Executes tasks in any repo, reports progress, surfaces approval requests to your mobile. Best for complex, long-horizon development work. |
| `annie codex` | **OpenAI Codex** | GPT-powered code execution. Resumable sessions — if a machine restarts, the session picks up where it left off. Familiar to teams already using OpenAI's stack. |
| `annie cursor` | **Cursor Agent** | Full IDE agent mode with remote control. Messages flow bidirectionally: server ↔ PWA ↔ Cursor. Every tool call surfaces permission requests you approve from your phone. |
| `annie opencode` | **OpenCode** | Open-source agent — no vendor lock-in, full tool use with approval gates. Remote and local control from the web app or PWA. Ideal for teams that want transparency in the agent layer. |
| `annie gemini` | **Google Gemini** | Multimodal agent via ACP. Remote mode: messages originate from the server UI or Telegram. Useful when tasks require image, document, or audio context. |
| `annie kilocode` | **KiloCode** | Task execution with the deepest remote control. Multiple concurrent sessions. Every action requires phone approval. Built for business owners who want the tightest oversight loop. |
| `annie zeroclaw` | **ZeroClaw** | Headless, policy-driven workflow automation. Define playbooks with conditions, fallbacks, and retry logic. Self-correcting — if an action fails, the playbook retries or escalates per your rules. Full audit trail to Postgres. |
| `annie openclaw` | **OpenClaw** | Visual workflow orchestration and task graph execution. Manages entire task graphs with dependencies, sequencing, and real-time status in your dashboard. Browser and desktop automation with approval gates. |

**You don't have to choose one.** The same server hub handles all eight. An employee can run Claude on one machine and Codex on another — both appear in your dashboard simultaneously.

---

## LLM & Voice Providers — BYOK, Server-Side

LLM credentials are configured in **Admin on the server**. The CLI never holds, stores, or transmits API keys. This is intentional: your keys are infrastructure, not employee equipment.

<p>
  <img src="https://img.shields.io/badge/OpenRouter-6366F1?style=flat-square&logo=openai&logoColor=white" alt="OpenRouter" />
  <img src="https://img.shields.io/badge/Google_Vertex_AI-4285F4?style=flat-square&logo=googlecloud&logoColor=white" alt="Vertex AI" />
  <img src="https://img.shields.io/badge/DeepInfra-0F172A?style=flat-square&logo=deepmind&logoColor=white" alt="DeepInfra" />
  <img src="https://img.shields.io/badge/ElevenLabs_Voice-000000?style=flat-square&logo=elevenlabs&logoColor=white" alt="ElevenLabs" />
  <img src="https://img.shields.io/badge/MiniMax_Voice-FF4B91?style=flat-square" alt="MiniMax" />
  <img src="https://img.shields.io/badge/Anthropic_Claude-CC785C?style=flat-square&logo=anthropic&logoColor=white" alt="Anthropic" />
  <img src="https://img.shields.io/badge/OpenAI-412991?style=flat-square&logo=openai&logoColor=white" alt="OpenAI" />
</p>

| Provider | What to Configure | What It Unlocks |
|----------|------------------|-----------------|
| **OpenRouter** | OpenRouter API key | Access to 100+ models via a single key — route by cost, capability, or speed |
| **Google Vertex AI** | GCP project + credentials | Enterprise-grade Google models (Gemini Pro, Claude via Vertex) with GCP audit |
| **DeepInfra** | DeepInfra API key | Open-source models at low cost — Llama, Mistral, Mixtral, and more |
| **Anthropic (direct)** | Anthropic API key | Direct Claude access without routing overhead |
| **OpenAI (direct)** | OpenAI API key | Direct GPT-4/Codex access |
| **ElevenLabs** | ElevenLabs API key | Voice output in the PWA — agents that speak |
| **MiniMax** | MiniMax API key | Multilingual voice interface — useful for international teams |

**The architecture matters:** You set these once in server Admin. All employees and all agents draw from the server's credentials — with no risk of an employee accidentally committing a key to a repo, losing a device, or sharing credentials.

---

## Workflow Automation — ZeroClaw & OpenClaw

The coding agents handle development work. **OpenClaw** and **ZeroClaw** handle everything else — browser automation, desktop control, multi-step business workflows, and zero-touch machine orchestration.

### OpenClaw

> Orchestrate projects and execute task graphs from the hub.

OpenClaw turns the NEST hub into a project automation layer. Instead of an agent executing a single coding task, OpenClaw manages entire task graphs — with dependencies, sequencing, and real-time status visible in your dashboard.

**What this means for your business:**
- Automate complex multi-step workflows (not just "write this function")
- Browser and desktop automation with full audit trail
- Security policies enforced at the task graph level
- Approvals surfaced to mobile at the right stage — not every micro-action

### ZeroClaw

> Zero-touch automation across machines, with self-correction and granular audit.

ZeroClaw is the headless, policy-driven layer. You define playbooks — sequences of actions with conditions, fallbacks, and retry logic. ZeroClaw executes them, observes outcomes, self-corrects, and logs everything.

**What this means for your business:**
- Recurring business processes run automatically — no manual trigger
- Self-correcting: if an action fails, the playbook retries or escalates per your rules
- Granular permissions: each playbook defines what it can and cannot touch
- Full audit trail — every execution logged to Postgres, visible in your dashboard

Both run on the same server and hub as the coding agents — no separate infrastructure required.

---

## Background Worker & Remote Spawn

The default `annie` flow requires a terminal window to stay open. That's fine for a developer running an active session — but not for automated workflows or unattended tasks.

```bash
annie worker start
```

This starts a **background worker daemon** that keeps a persistent connection to the server. Sessions can then be **started remotely** — from the web app, from Telegram, from a scheduled job — without anyone opening a terminal.

**What this means:**
- Kick off an agent task from your phone at midnight
- Schedule recurring tasks without an employee present
- The server assigns work to machines; the worker executes and streams results back
- All results appear in your dashboard exactly as with a manually-started session

---

## Auth & Configuration — The Short Version

### For employees (on their machines)

```bash
# One-time setup — saves credentials to ~/.nest
annie auth login
# Enter NEST_API_URL: http://your-server-address
# Enter CLI_API_TOKEN: the token from your server's .env

# Verify
annie auth status
```

After this, `annie` (in any mode) connects to your server automatically. No environment variables to set each session.

### For the business owner (on the server)

LLM and voice providers are configured in **Admin** in the NEST web app — not in `.env`, not on employee machines. You set them once; all agents use them.

| Where to configure | What |
|-------------------|------|
| Server `.env` | `CLI_API_TOKEN` — the shared secret |
| Server Admin (web UI) | LLM keys (OpenRouter, Vertex, DeepInfra, Anthropic, OpenAI) |
| Server Admin (web UI) | Voice keys (ElevenLabs, MiniMax) |
| CLI on employee machine | `NEST_API_URL` + `CLI_API_TOKEN` — set once via `annie auth login` |

**The key principle:** the server is the authority. LLM spend, voice usage, and session permissions are centrally managed. Employees connect to the server; they don't manage keys.

---

## What a Day Looks Like — Operationally

Here's the practical picture of NEST in a working team:

**Morning:**
- Employee opens terminal, types `annie` (or `annie cursor`, etc.)
- Session appears instantly in your mobile dashboard
- You see: who started it, which agent, which machine, current status

**During work:**
- Agent surfaces a permission request ("write to production config?")
- Your phone receives the request
- You approve or reject — session continues or pauses accordingly
- All messages, tool calls, and outputs stream live to your dashboard

**End of day:**
- Full session log persisted in Postgres — what was done, when, by which agent
- You can review any session in the web app at any time
- Nothing was lost; nothing was silently executed

**When you're traveling:**
- Your team's sessions are still visible on your phone
- You approve from wherever you are
- `annie worker start` means a new task can be spawned without anyone in the office

---

## Security Model — What This Means for Your Business

| Concern | How NEST Addresses It |
|---------|----------------------|
| **LLM keys on employee laptops** | Never. Keys live on the server only. |
| **Agents running without visibility** | Every session is visible in your dashboard in real time. |
| **Unaudited actions** | Every action is logged to Postgres. You own the log. |
| **Agent exceeding permissions** | Permission requests surface to mobile. Agents wait. |
| **Employee leaves with credentials** | Rotate `CLI_API_TOKEN` in `.env`. Restart server. All sessions invalidated. |
| **Compliance / data residency** | Everything runs on your infrastructure. Nothing leaves your servers. |

---

## Quick Reference — All Commands

Use **explicit** subcommands in scripts. Full enterprise reference (MCP, Cursor, VS Code, Claude, ChatGPT, phased rollout): **[Annie & MCP enterprise guide](enterprise/annie-cli-mcp-enterprise.md)** ([ES](enterprise/annie-cli-mcp-enterprise-ES.md), [DE](enterprise/annie-cli-mcp-enterprise-DE.md), [FR](enterprise/annie-cli-mcp-enterprise-FR.md), [PT](enterprise/annie-cli-mcp-enterprise-PT.md), [ZH](enterprise/annie-cli-mcp-enterprise-ZH.md)).

```bash
# Agent modes (prefer explicit names in automation)
annie claude            # Claude Code
annie codex             # OpenAI Codex  (annie codex resume <sessionId>)
annie cursor            # Cursor Agent
annie opencode          # OpenCode
annie gemini            # Google Gemini (via ACP)
annie kilocode          # KiloCode

# MCP
annie mcp               # STDIO bridge: env NEST_HTTP_MCP_URL + CLI_API_TOKEN, or --url / --token

# Infrastructure
annie worker start      # Background worker daemon (remote spawn)
annie worker stop       # Stop the worker
annie worker status     # Worker status
annie worker list       # Active sessions

# Auth
annie auth login        # Save server URL + token interactively
annie auth status       # Show current auth configuration
annie auth logout       # Clear saved credentials

# Bundled server (when shipped in your package)
annie server            # Start bundled hub

# Diagnostics
annie diagnose          # Full diagnostic report — run this first if anything's wrong
annie diagnose clean    # Kill runaway NEST-related processes
```

> **Note:** `annie connect` and `annie notify` exit with a message in self-hosted direct-connect mode. OpenClaw / ZeroClaw commands may ship per release — see [RELEASES.md](../RELEASES.md).

---

## Links

| Document | Contents |
|----------|---------|
| [QUICKSTART.md](../QUICKSTART.md) | Server live in 5 minutes |
| [INSTALL.md](INSTALL.md) | Full CLI and server install reference |
| [DEVOPS.md](DEVOPS.md) | Production setup: HTTPS, public URL, environment variables |
| [README.md](../README.md) | Full command and configuration reference |
| [ROADMAP.md](../ROADMAP.md) | OpenClaw, ZeroClaw, Souls, and what's next |
| [RELEASES.md](../RELEASES.md) | Everything live today, with verification links |
| [Business Overview](../business/README.md) | Strategic value for founders |
| [Value Proposition](../business/value-proposition.md) | Detailed owner/employee/business benefits |
| [Use Cases](../business/use-cases.md) | Real scenarios and use cases |
| [Methodology](../methodology/README.md) | Implementation phases guide |
| [Annie & MCP enterprise](enterprise/annie-cli-mcp-enterprise.md) | Full CLI + MCP (all clients, URL + token, phases) |
| [Enterprise Features](../enterprise/README.md) | Enterprise pricing and features |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Part of the [contextzero/nest](https://github.com/contextzero/nest) ecosystem.*

</div>