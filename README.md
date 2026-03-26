<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="280"/>

<br/>

**Self-Hosted Workforce Automation Platform — Enterprise Grade**
<br/>
<em>Your hub. Your data. Your AI workforce. From the palm of your hand.</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/contextzero/nest_hub?style=flat-square)](https://github.com/contextzero/nest_hub/network)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)
[![License](https://img.shields.io/badge/License-Proprietary-red?style=flat-square)]()

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## What is NEST?

**NEST** is a complete, self-hosted **workforce automation platform**. Not just for coding — your employees can manage machines, resolve tasks, send emails, do research, build products, and more. All from one hub. All from their phone.

> You deploy: one Docker command on your server.
> Your team gets: a real-time AI workforce hub accessible from any device — phone, tablet, desktop.

### The Four Pillars

| Pillar | What It Means |
|--------|--------------|
| **Hub for Enterprise** | One app replaces Slack + Notion + Trello + WhatsApp. Projects → Employees → Sessions. Single source of truth. |
| **Mobile for the Employee** | PWA works on any phone. Approve deployments from the bus. No laptop required. |
| **Memory Bank (Souls)** | The hub learns each employee. No more re-explaining context every session. Intelligence accumulates. |
| **Agent Swarm** | Multiple specialized AI agents working in parallel — not one generalist doing everything sequentially. |

---

## Quick Start — Live in 5 Minutes

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

That's it. `setup.sh` auto-generates all secrets, pulls Docker images, starts the stack, and waits for health.

```
=== NEST ready ===
  Web:  http://localhost
```

Open on your phone. Install the PWA. Your hub is live.

> **Detailed guide:** [QUICKSTART.md](QUICKSTART.md)

---

## What NEST Does

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          NEST PLATFORM                                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────────┐  │
│  │  CODING AGENTS   │  │  AUTOMATION      │  │  INTELLIGENCE       │  │
│  │  Claude Code     │  │  ZeroClaw        │  │  Souls (Memory)     │  │
│  │  Cursor          │  │  OpenClaw        │  │  Darwin Agents      │  │
│  │  Codex           │  │  Browser control │  │  Colony Memory      │  │
│  │  Gemini          │  │  Scheduled tasks │  │  Learning systems   │  │
│  │  OpenCode        │  │  File management │  │  Cross-team context │  │
│  │  KiloCode        │  │                  │  │                     │  │
│  └──────────────────┘  └──────────────────┘  └──────────────────────┘  │
│                                                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────────┐  │
│  │  MOBILE (PWA)    │  │  GOVERNANCE      │  │  COMMUNICATION      │  │
│  │  Phone-first UI  │  │  Permission modes│  │  Email automation   │  │
│  │  Approve/reject  │  │  Audit trail     │  │  Telegram bot       │  │
│  │  Real-time SSE   │  │  Compliance logs │  │  Voice interface    │  │
│  │  Touch-native    │  │  Per-employee    │  │  Research & reports │  │
│  └──────────────────┘  └──────────────────┘  └──────────────────────┘  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Architecture

```
YOU (Phone/Tablet/Desktop)        SERVER                      EMPLOYEE MACHINE
──────────────────────────      ──────────────              ─────────────────────
  📱 PWA Dashboard        ←──  NEST Server (Rust)   ←──    annie CLI
  ✅ Approve / Reject           Axum + Socket.IO             Claude Code
  💬 Live Chat             ←──  SSE real-time stream         Cursor / Codex
  📊 Audit & Stats        ←──  PostgreSQL                   Gemini / OpenCode
  🎤 Voice Interface            nginx reverse proxy          KiloCode
                                                             ZeroClaw / OpenClaw

                                YOUR INFRASTRUCTURE
                                (self-hosted Docker)
```

---

## Supported Agents

| Agent | Command | Description |
|-------|---------|------------|
| **Claude Code** | `annie` | Anthropic's flagship coding agent |
| **Cursor** | `annie cursor` | Cursor IDE agent mode |
| **Codex** | `annie codex` | OpenAI's code execution agent |
| **Gemini** | `annie gemini` | Google's multimodal agent |
| **OpenCode** | `annie opencode` | Open-source coding agent |
| **KiloCode** | `annie kilocode` | Task execution + remote control |
| **ZeroClaw** | Headless automation | Self-correcting autonomous tasks |
| **OpenClaw** | Project orchestration | Multi-step workflows + browser control |

```bash
npm install -g @contextzero/nest
annie --help
```

---

## Key Concepts

### ZeroClaw & OpenClaw

**ZeroClaw** = Headless automation with self-correction
- Runs tasks autonomously on employee machines
- Observes outcomes and adapts strategy
- Full audit trail in your hub

**OpenClaw** = Project orchestration
- Task graphs with dependencies
- Multi-step workflows
- Browser and desktop control

### Colony Memory (Enterprise)

Every task teaches the system. The colony learns:
- Which agents work best for which tasks
- Employee preferences and patterns
- Project context across teams
- Optimal workflows by experience

### Darwin Agents (Enterprise)

Specialized agents that **evolve**:
1. User describes a need → System creates agent
2. Agent performs task → Performance tracked
3. Best agents survive → Replicated across the team
4. Continuous improvement → Better results over time

---

## The Two Versions

| Aspect | Community (Self-Hosted) | Enterprise |
|--------|------------------------|------------|
| **Deployment** | Your Docker server | Our cloud |
| **Price** | Free ($0 product fee) | Subscription |
| **Users** | Individual / Small team | Organizations, NGOs, Governments |
| **Agents** | All coding agents | + Darwin agents + ZeroClaw |
| **Memory** | Local session history | Colony-wide Souls |
| **Governance** | Permission modes + audit | Advanced compliance + RBAC |
| **Support** | GitHub + Community | Dedicated |

---

## Permission Modes

Control how much autonomy your AI agents have — per employee, per project, per session:

| Mode | Behavior |
|------|----------|
| **Default** | Agent asks before every action |
| **Accept Edits** | Agent writes code freely; asks for everything else |
| **Bypass** | Full autonomy for trusted workflows |
| **Plan** | Agent proposes a plan but doesn't execute |

---

## Why NEST — Not Another Tool

| Problem | How Others Solve It | How NEST Solves It |
|---------|--------------------|--------------------|
| 15+ fragmented apps | Add another integration | **One hub replaces the pile** |
| Desk-bound workforce | Slack mobile (partial) | **Phone-first PWA — approve from anywhere** |
| AI forgets everything | System prompts, RAG hacks | **Souls — the hub learns each employee** |
| One agent bottleneck | Manual coordination | **Agent swarm — specialists in parallel** |
| Shadow AI / no visibility | Honor system, IT policies | **Full audit trail through the hub** |
| Personal assistants don't scale | OpenClaw per person | **Workforce hub — shared memory, structured projects** |

---

## Documentation

| What you need | Where to go |
|---------------|-------------|
| 5-minute start | [QUICKSTART.md](QUICKSTART.md) |
| Full installation reference | [docs/INSTALL.md](docs/INSTALL.md) |
| Production deploy (HTTPS, public URL) | [docs/DEVOPS.md](docs/DEVOPS.md) |
| CLI reference & LLM config | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Framework install (Node, Docker, Rust) | [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) |
| Enterprise features | [docs/enterprise/README.md](docs/enterprise/README.md) |
| **Annie CLI + MCP (enterprise)** | [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) · [ES](docs/enterprise/annie-cli-mcp-enterprise-ES.md) · [DE](docs/enterprise/annie-cli-mcp-enterprise-DE.md) · [FR](docs/enterprise/annie-cli-mcp-enterprise-FR.md) · [PT](docs/enterprise/annie-cli-mcp-enterprise-PT.md) · [ZH](docs/enterprise/annie-cli-mcp-enterprise-ZH.md) |
| ZeroClaw & OpenClaw | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Darwin Agents | [docs/enterprise/darwin-agents.md](docs/enterprise/darwin-agents.md) |
| Business overview for founders | [docs/business/README.md](docs/business/README.md) |
| Value proposition | [docs/business/value-proposition.md](docs/business/value-proposition.md) |
| Implementation methodology | [docs/methodology/README.md](docs/methodology/README.md) |
| Branding & positioning | [docs/branding/README.md](docs/branding/README.md) |
| What's shipped | [RELEASES.md](RELEASES.md) |
| What's coming next | [ROADMAP.md](ROADMAP.md) |

---

## Quick Reference — Commands

**CLI (on employee machines):**

```bash
annie claude              # Claude Code session
annie cursor              # Cursor agent
annie codex               # Codex session (annie codex resume <id>)
annie gemini              # Gemini session
annie opencode            # OpenCode session
annie kilocode            # KiloCode session
annie mcp                 # MCP stdio bridge (HTTP target + token)
annie worker start        # Background worker (remote spawn)
annie auth login          # Save credentials
annie auth status         # Check connection
annie diagnose            # Full diagnostic report
```

> **Enterprise CLI + MCP (Cursor, VS Code, Claude, ChatGPT, phased rollout):** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md)

**Server (from `nest_hub/` folder):**

```bash
./setup.sh                    # First-time setup (auto-generates secrets)
docker compose up -d          # Start the stack
docker compose down           # Stop
docker compose logs -f        # Stream logs
docker compose ps             # Check status
docker compose pull && docker compose up -d  # Update to latest
```

---

## Stack

| Component | Technology | Distribution |
|-----------|-----------|-------------|
| **Server** | Rust · Axum · Socket.IO · SSE | [Docker Hub](https://hub.docker.com/r/matiasbaglieri/nest-server) |
| **Web App** | React 19 · Vite · TanStack · Tailwind · xterm.js | [Docker Hub](https://hub.docker.com/r/matiasbaglieri/nest-web) |
| **CLI** | TypeScript · Bun · Ink | [npm](https://www.npmjs.com/package/@contextzero/nest) |
| **Database** | PostgreSQL 16 | Docker (internal, not exposed) |
| **Proxy** | nginx Alpine | Docker |

---

## Roadmap

| Initiative | What It Solves | Status |
|------------|---------------|--------|
| **Souls** — Persistent memory | Agents start from zero every session | Design & scoping |
| **Multi-agent orchestration** | One agent doing everything serially | Strategy ready; runtime pending |
| **Forge** — Spec-driven development | Implementation disconnected from business intent | Concept defined |

> Full details: [ROADMAP.md](ROADMAP.md)

---

## Community

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub](https://img.shields.io/badge/GitHub-contextzero-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/contextzero)
[![npm](https://img.shields.io/badge/npm-@contextzero/nest-CB3837?style=for-the-badge&logo=npm&logoColor=white)](https://www.npmjs.com/package/@contextzero/nest)

</div>

- **Issues & Feature Requests:** [github.com/contextzero/nest_hub/issues](https://github.com/contextzero/nest_hub/issues)
- **Discussions:** [github.com/contextzero/nest_hub/discussions](https://github.com/contextzero/nest_hub/discussions)
- **Source code (CLI, Server, Web):** [github.com/contextzero/nest](https://github.com/contextzero/nest)

---

## License

NEST Hub distribution is proprietary. See LICENSE for details.

**© 2025–2026 Context Zero** — Self-Hosted Workforce Automation Platform

---

<div align="center">

*Part of the [contextzero/nest](https://github.com/contextzero/nest) ecosystem.*

</div>
