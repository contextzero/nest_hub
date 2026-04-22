# NEST — Self-Hosted Workforce Automation

<p align="center">
  <img src="./public/nest_logo.png" alt="NEST" width="280" />
</p>

<p align="center">
  <strong>Self-Hosted Workforce Automation Platform — Enterprise Grade</strong><br />
  <em>The operating system for how your company works with AI.</em><br />
  <em>Your hub. Your data. Your AI workforce. From the palm of your hand.</em>
</p>

<p align="center">
  <a href="https://github.com/contextzero/nest_hub/releases"><img src="https://img.shields.io/github/v/release/contextzero/nest_hub?include_prereleases&style=for-the-badge" alt="GitHub release"></a>
  <a href="https://github.com/contextzero/nest_hub/stargazers"><img src="https://img.shields.io/github/stars/contextzero/nest_hub?style=for-the-badge&logo=github" alt="GitHub stars"></a>
  <a href="https://discord.gg/ygjuuDAw"><img src="https://img.shields.io/badge/Discord-Join-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord"></a>
  <a href="https://www.npmjs.com/package/@contextzero/nest"><img src="https://img.shields.io/npm/v/@contextzero/nest?style=for-the-badge&logo=npm&label=CLI" alt="npm CLI"></a>
  <a href="./LICENSE"><img src="https://img.shields.io/badge/License-Proprietary-red.svg?style=for-the-badge" alt="License"></a>
</p>

<p align="center">
  <a href="https://t.me/ctx0_io"><img src="https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white" alt="Telegram"></a>
  <a href="https://discord.gg/ygjuuDAw"><img src="https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white" alt="Discord"></a>
  <a href="https://github.com/contextzero/nest_hub/stargazers"><img src="https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520" alt="GitHub Stars"></a>
  <a href="https://github.com/contextzero/nest_hub/network"><img src="https://img.shields.io/github/forks/contextzero/nest_hub?style=flat-square" alt="GitHub Forks"></a>
  <a href="https://hub.docker.com/u/matiasbaglieri"><img src="https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Docker"></a>
  <a href="https://www.npmjs.com/package/@contextzero/nest"><img src="https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI" alt="npm CLI"></a>
</p>

<p align="center">
  <a href="./QUICKSTART.md">Quick start</a>
  · <a href="./docs/INSTALL.md">Install</a>
  · <a href="./docs/DEVOPS.md">Production &amp; HTTPS</a>
  · <a href="./docs/enterprise/annie-cli-mcp-enterprise.md">CLI (<code>@contextzero/nest</code>) &amp; MCP</a>
  · <a href="./docs/enterprise/README.md">Enterprise</a>
  · <a href="./RELEASES.md">Releases</a>
  · <a href="./ROADMAP.md">Roadmap</a>
  · <a href="https://www.npmjs.com/package/@contextzero/nest">CLI on npm (<code>@contextzero/nest</code>)</a>
</p>

<p align="center">
  <a href="./README.md">English</a>
  · <a href="./README-ES.md">Español</a>
  · <a href="./README-ZH.md">中文</a>
  · <a href="./README-DE.md">Deutsch</a>
  · <a href="./README-PT.md">Português</a>
  · <a href="./README-FR.md">Français</a>
</p>

**New install?** Start here: [QUICKSTART.md](QUICKSTART.md).

**Preferred setup — hub (Docker):** clone this repo, `cd nest_hub`, run `./setup.sh`. It generates secrets, pulls images, starts the stack, and waits for health.

**CLI (employee machines):** the published interface is **`npm install -g @contextzero/nest`** — that package is the CLI and installs the **`annie`** command. Use Node.js **LTS** (20+), then `annie auth login`. **pnpm** and **bun** work too if your policy allows global installs via those clients.

---

## What is NEST?

> **Yes, you still have 15+ apps**—and that fragmentation was already painful in 2018. Today it compounds with **shadow corporate AI**: people already use ChatGPT, Claude, Cursor, Copilot, image tools, and loose API keys—you often don’t know **where**, **which model**, or **what it costs**. Prompts start from zero in every tab; when someone leaves, the **judgment they refined with AI** walks out the door. You have dashboards for revenue and servers, but not for **how work actually happens with AI**.

**NEST** is the **self-hosted layer your company runs**: **projects**, **roles**, **memory**, and **governance** so agents and chat run **under your URLs, your tokens, and your audit log**—not as invisible shadow IT.

**NEST** is also a complete **workforce automation platform**: coding, chat, and computer use in one hub—phone, tablet, and desktop.

> You deploy: one Docker command on your server.
> Your team gets: a real-time AI workforce hub accessible from any device — phone, tablet, desktop.

### Three surfaces — inside projects admins own

Work is grouped in **projects** your administrators create. That gives you **per-project tracking** (who did what, in which session), a **memory bank** that accumulates context per user and team (the “soul” of how each person works with AI), and **approvals** before high-risk actions—instead of one-off browser tabs.

| Surface | What employees get today | Notes |
|--------|----------------------------|--------|
| **Development** | **Claude Code**, **Cursor**, **Codex**, **OpenCode**, and **KiloCode** through the **`annie`** CLI (`npm install -g @contextzero/nest`), with **MCP** for **Cursor** and **Visual Studio Code** | [Full CLI + MCP reference](docs/enterprise/annie-cli-mcp-enterprise.md) |
| **Chat** | One hub chat on **web, desktop, and mobile PWA** backed by **OpenRouter**, **Fal.ai**, **Google Vertex AI**, and **DeepInfra** — **700+** models across **text, image, audio, and video** | Provider keys stay on the **server**; employees authenticate to **your** hub |
| **Computer** | **`annie computer`** — hub-synced “computer use” from CLI and PWA (shell, browser where enabled, files, runbooks). From **June 1, 2026**, **OpenClaw**, **ZeroClaw**, and **Hermes** ship **as wrappers inside Computer** (same pattern as Claude, Cursor, …)—not standalone `annie` subcommands ([detail](docs/enterprise/zeroclaw.md)) | Same **approve → execute** posture as development sessions |

### Product roadmap (2026)

| Date | Milestone |
|------|-----------|
| **May 1, 2026** | **Project management** in projects — backlogs, workflow states, and visibility across tasks |
| **May 15, 2026** | **CRM** — contacts and lifecycle (e.g. pre-sales → sales → post-sales) shared **across projects** |
| **June 1, 2026** | **`annie computer` wrappers** — **OpenClaw**, **ZeroClaw**, and **Hermes** integrated **inside Computer** (same attach pattern as other hub-backed agents) |

Role-aware routing (employee **reviews → approves →** execution on **Computer**, **Claude**, **Cursor**, etc.) ties these modules together—see [ROADMAP.md](ROADMAP.md) for scope and ship notes.

### Product video


https://github.com/user-attachments/assets/abfe0d75-8808-45a6-a671-8b84dd21fd2f


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

## Highlights

- **[Phone-first hub](QUICKSTART.md)** — PWA on any device; approve work without a laptop.
- **[Production deploy (HTTPS)](docs/DEVOPS.md)** — public URL, reverse proxy, and operational hardening.
- **[CLI (`@contextzero/nest`) + MCP — enterprise](docs/enterprise/annie-cli-mcp-enterprise.md)** — development agents (**Claude Code**, **Cursor**, **Codex**, **OpenCode**, **KiloCode**); **MCP** for **Cursor** and **Visual Studio Code**; phased rollout and token hygiene.
- **Hub Chat** — **OpenRouter**, **Fal.ai**, **Vertex**, **DeepInfra**; **700+** models (text, image, audio, video) on web, desktop, and mobile—keys on the server, not employee laptops.
- **[Computer automation wrappers](docs/enterprise/zeroclaw.md)** — **OpenClaw**, **ZeroClaw**, and **Hermes** ship **inside `annie computer`** on **June 1, 2026** (same pattern as Claude, Cursor, …)—not `annie openclaw` / `annie zeroclaw` / `annie hermes`.
- **Roadmap:** **Project management** — **May 1, 2026** · **CRM** — **May 15, 2026** · **Computer wrappers** (OpenClaw, ZeroClaw, Hermes) — **June 1, 2026** — [ROADMAP.md](ROADMAP.md).
- **[Darwin agents](docs/enterprise/darwin-agents.md)** — evolving specialist agents (enterprise).
- **CLI on npm:** [`@contextzero/nest`](https://www.npmjs.com/package/@contextzero/nest) — install with `npm install -g @contextzero/nest`; the binary is `annie`.

## Docs by goal

| Goal | Start here |
|------|------------|
| First-time hub in Docker | [QUICKSTART.md](QUICKSTART.md) → [docs/INSTALL.md](docs/INSTALL.md) |
| Public URL + TLS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| Employee laptops (Cursor, Claude Code, Codex, …) | [Enterprise rollout — `npm install -g @contextzero/nest`](#annie-cli-enterprise-rollout) → [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) |
| LLM keys, billing, CLI config | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Node / Docker / Rust toolchain | [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) |
| Enterprise positioning & sales context | [docs/enterprise/README.md](docs/enterprise/README.md) |
| What shipped vs planned | [RELEASES.md](RELEASES.md) · [ROADMAP.md](ROADMAP.md) |

## Security posture (self-hosted)

NEST connects real agents to real infrastructure. Treat **CLI tokens**, **hub URLs**, and **inbound webhooks** as sensitive. Rotate `CLI_API_TOKEN` on compromise; prefer HTTPS everywhere; scope [permission modes](#permission-modes) per employee and project. Read [docs/DEVOPS.md](docs/DEVOPS.md) before exposing the stack to the internet. The [Important notice](#important-notice--self-hosted-deployments-responsibility-and-access) at the end of this file describes responsibility boundaries for self-hosted deployments.

---

## What NEST Does

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          NEST PLATFORM                                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────────┐  │
│  │  CODING AGENTS   │  │  AUTOMATION      │  │  INTELLIGENCE       │  │
│  │  Claude Code     │  │  ZeroClaw*       │  │  Souls (Memory)     │  │
│  │  Cursor          │  │  OpenClaw*       │  │  Darwin Agents      │  │
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

\*From **June 1, 2026**, **OpenClaw**, **ZeroClaw**, and **Hermes** ship as **wrappers inside `annie computer`** (same pattern as other Computer agents). See [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md).

---

## Architecture

```
YOU (Phone/Tablet/Desktop)        SERVER                      EMPLOYEE MACHINE
──────────────────────────      ──────────────              ─────────────────────
  📱 PWA Dashboard        ←──  NEST Server (Rust)   ←──    annie (`@contextzero/nest`)
  ✅ Approve / Reject           Axum + Socket.IO             Claude Code
  💬 Live Chat             ←──  SSE real-time stream         Cursor / Codex
  📊 Audit & Stats        ←──  PostgreSQL                   Gemini / OpenCode
  🎤 Voice Interface            nginx reverse proxy          KiloCode / Computer
  🖥 Remote terminals (PTY)  ←──  session streams  ←──    `annie` CLI (explicit subcommands)

                                YOUR INFRASTRUCTURE
                                (self-hosted Docker)
```

> **Computer vs bare `annie`:** From **June 1, 2026**, **OpenClaw**, **ZeroClaw**, and **Hermes** run as **wrappers inside `annie computer`** (same pattern as Claude, Cursor, Codex, …)—see [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). They are **not** standalone `annie openclaw` / `annie zeroclaw` / `annie hermes` commands. In scripts and CI, always invoke an explicit subcommand (`annie claude`, `annie computer`, …); if the first token is not a known subcommand, the CLI behaves like **`annie cursor`**.

---

## Supported Agents

| Agent | Command | Description |
|-------|---------|------------|
| **Claude Code** | `annie claude` | Anthropic's flagship coding agent |
| **Cursor** | `annie cursor` | Cursor IDE agent mode |
| **Codex** | `annie codex` | OpenAI's code execution agent |
| **Gemini** | `annie gemini` | Google's multimodal agent |
| **OpenCode** | `annie opencode` | Open-source coding agent |
| **KiloCode** | `annie kilocode` | Task execution + remote control |
| **Computer (management)** | `annie computer` | Hub-synced multi-tool agent: shell, browser, files, git, processes, scheduling—beyond a single IDE |
| **ZeroClaw** | *via `annie computer` (from Jun 1, 2026)* | Headless automation wrapper — self-correcting autonomous tasks ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **OpenClaw** | *via `annie computer` (from Jun 1, 2026)* | Orchestration wrapper — multi-step workflows + browser control ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **Hermes** | *via `annie computer` (from Jun 1, 2026)* | Computer-use wrapper alongside OpenClaw / ZeroClaw ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |

```bash
npm install -g @contextzero/nest
annie --help
```

<a id="annie-cli-enterprise-rollout"></a>

### Enterprise rollout — CLI (`@contextzero/nest`)

Use this sequence for **macOS, Windows, and Linux** machines where employees run Cursor, Claude Code, Codex, OpenCode, or KiloCode. One global install of **`@contextzero/nest`** (the `annie` CLI from that package) connects each workstation to **your** NEST instance; Context Zero does not host your self‑hosted hub or join your network.

**1. Install the CLI (IT or employee, with Node.js LTS + npm):**

```bash
npm install -g @contextzero/nest
```

Confirm the binary is on `PATH`:

```bash
annie --version
```

**2. Authenticate the machine against your hub**

Run once per profile (or automate via your MDM / secrets vault using the same variables `annie auth login` persists):

```bash
annie auth login
```

You will be prompted for the **base URL of your deployment** (for example `https://nest.yourcompany.com`, issued by your organization) and a **CLI API token** your administrators generate on the server. Verify connectivity:

```bash
annie auth status
```

**3. Standard agent entry points (after login)**

| Surface | Command | Purpose |
|--------|---------|--------|
| **Claude Code** | `annie claude` | Anthropic Claude Code sessions |
| **Cursor** | `annie cursor` | Cursor IDE agent mode |
| **Codex** | `annie codex` | OpenAI Codex sessions (`annie codex resume <id>` where supported) |
| **Gemini** | `annie gemini` | Google Gemini sessions |
| **OpenCode** | `annie opencode` | OpenCode sessions |
| **KiloCode** | `annie kilocode` | KiloCode task execution |
| **Computer** | `annie computer` | Management / multi-tool agent (shell, browser, files, git, processes, schedulers—hub-synced) |
| **MCP bridge** | `annie mcp` | stdio MCP bridge toward your hub (HTTP target + token) |
| **Background worker** | `annie worker start` · `list` · `stop-session <id>` | Remote / long‑running work tied to the hub |
| **Hub terminals** | *(PWA ↔ server ↔ CLI PTY)* | Operator shells for debugging and long jobs (treat as privileged) |

Distribute **only** URLs and tokens from **your** company domain and identity systems. Employees should install the **PWA or native clients** from links you control (intranet, MDM, or branded download pages), then use phone, tablet, or desktop to approve work, monitor sessions, and audit activity—without sharing credentials outside your tenant.

**Further reading:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — full surface: development agents, **`annie computer`** (management), **remote PTY terminals**, worker, MCP, diagnostics; no private source links.

**Automation note:** if the first argument is not a known subcommand, the CLI treats the invocation as **`annie cursor`**. In CI and runbooks, always pass an explicit subcommand (`annie claude`, `annie computer`, …).

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
| **15+ apps** and **shadow corporate AI** (unapproved models, tabs, and cost) | Policy PDFs, another checklist | **One operating layer** — projects, **server-side keys**, **full audit**; **PM May 1**, **CRM May 15**, **Computer** wrappers (**OpenClaw · ZeroClaw · Hermes**) **Jun 1** — [ROADMAP.md](ROADMAP.md) |
| Desk-bound workforce | Slack mobile (partial) | **Phone-first PWA — approve from anywhere** |
| AI forgets everything | System prompts, RAG hacks | **Memory bank / Souls — context accumulates per user and project** |
| One agent bottleneck | Manual coordination | **Agent swarm — specialists in parallel** |
| No executive dashboard for “how we use AI” | N/A | **Live hub views** — sessions, approvals, and spend tied to **projects** |
| Personal assistants don't scale | One chatbot per person | **Workforce hub — shared memory, structured projects, governed CLIs** |

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
| **CLI (`@contextzero/nest`) + MCP (enterprise)** | [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) · [ES](docs/enterprise/annie-cli-mcp-enterprise-ES.md) · [DE](docs/enterprise/annie-cli-mcp-enterprise-DE.md) · [FR](docs/enterprise/annie-cli-mcp-enterprise-FR.md) · [PT](docs/enterprise/annie-cli-mcp-enterprise-PT.md) · [ZH](docs/enterprise/annie-cli-mcp-enterprise-ZH.md) |
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
annie cursor              # Cursor agent (default if first token is unknown)
annie codex               # Codex session (annie codex resume <id>)
annie gemini              # Gemini session
annie opencode            # OpenCode session
annie kilocode            # KiloCode session
annie computer            # Multi-tool hub agent (shell, browser, files, ops)
annie mcp                 # MCP stdio bridge (HTTP target + token)
annie worker start        # Background worker (remote spawn)
annie worker list         # Active worker sessions
annie worker stop-session <id>
annie auth login          # Save credentials
annie auth status         # Check connection
annie diagnose            # Full diagnostic report
```

> **Enterprise — CLI package [`@contextzero/nest`](https://www.npmjs.com/package/@contextzero/nest) + MCP (Cursor, VS Code, Claude, ChatGPT, phased rollout):** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md)

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
- **Employee CLI (published):** npm package [`@contextzero/nest`](https://www.npmjs.com/package/@contextzero/nest) — `npm install -g @contextzero/nest` → command `annie`

---

## License

NEST Hub distribution is proprietary. See LICENSE for details.

**© 2025–2026 Context Zero** — Self-Hosted Workforce Automation Platform

---

## Important notice — self‑hosted deployments, responsibility, and access

The following is a **general information notice** for customers and operators. It is **not** tailored legal advice; your counsel should review it against your contracts, jurisdiction, and regulatory obligations.

**Use and compliance.** Your organization—**not** Context Zero Inc. (including its affiliates, contractors, or personnel, collectively “**Context Zero**”)—is **solely responsible** for how you deploy, configure, secure, and use NEST Hub, including all outputs of AI agents, integrations, data processing, employment practices, export controls, privacy, sectoral regulations, and internal policies. Context Zero does not supervise your runtime environment and does not assume liability for decisions your employees, agents, or systems make on your infrastructure.

**Self‑hosted connectivity.** When you operate NEST as **self‑hosted** software on infrastructure you control, **Context Zero does not operate that server**, does not receive an automatic administrative connection to it, and **cannot access** your installation merely because you downloaded or licensed materials from us. Your hub is joined by your users and tooling (for example the **`annie`** CLI from **`npm install -g @contextzero/nest`**) **outbound** to the endpoints **you** configure (your DNS, your TLS certificates, your tokens). Unless you separately contract for managed services that explicitly provide remote administration and scope of access, **no member of the Context Zero team is granted inbound access** to your servers as part of the self‑hosted product model described in this repository.

**No agency.** Nothing in this README creates a partnership, joint venture, or agency relationship. Context Zero is a software provider; **your company remains exclusively responsible** for lawful use, workforce governance, and the security of your deployment.

---

<div align="center">

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
