<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Enterprise Guide — Annie CLI, MCP & Multi-Client Integration

**English** | [Español](./annie-cli-mcp-enterprise-ES.md) | [Deutsch](./annie-cli-mcp-enterprise-DE.md) | [Português](./annie-cli-mcp-enterprise-PT.md) | [Français](./annie-cli-mcp-enterprise-FR.md) | [中文](./annie-cli-mcp-enterprise-ZH.md)

This document is the **enterprise-grade** reference for deploying the **`@contextzero/nest`** CLI (command **`annie`**), using **all supported command surfaces** (development agents, **`annie computer`**, worker, MCP, terminals), and integrating **NEST MCP** with ChatGPT, Claude, Cursor, and VS Code.

**Programming-language note:** NEST is **agnostic to the languages in your repositories** (Python, TypeScript, Rust, Go, Java, .NET, etc.). Sessions bind to a **workspace path** and **server session id**, not to a single language runtime.

**Document languages:** This guide is published in **six natural languages** (EN, ES, DE, FR, PT, ZH) with the **same phase structure** in each file.

---

## Table of contents

1. [Executive summary](#1-executive-summary)
2. [Phase model at a glance](#2-phase-model-at-a-glance)
3. [CTO engineering workflow phases](#3-cto-engineering-workflow-phases)
4. [NEST implementation phases 0–6](#4-nest-implementation-phases-06)
5. [MCP technical maturity phases (M1–M4)](#5-mcp-technical-maturity-phases-m1m4)
6. [Operational rollout phases (P0–P4)](#6-operational-rollout-phases-p0p4)
7. [Architecture snapshot](#7-architecture-snapshot)
8. [CLI (`@contextzero/nest`) — full command surface](#section-8-cli-reference)
9. [Configuration & URL rules](#9-configuration--url-rules)
10. [MCP — protocol, security, and endpoints](#10-mcp--protocol-security-and-endpoints)
11. [Client-specific integration patterns](#11-client-specific-integration-patterns)
12. [Risk, validation, and governance](#12-risk-validation-and-governance)
13. [Related documents](#13-related-documents)

---

## 1. Executive summary

| Layer | What it answers |
|-------|-----------------|
| **CTO workflow** | *How* we think before we ship (analysis → design → risk → implementation) |
| **NEST phases 0–6** | *When* infrastructure, agents, and governance land in the organization |
| **MCP phases M1–M4** | *How* MCP evolves from safe local files to authenticated server proxy + external IDEs |
| **Ops phases P0–P4** | *How* teams scale from pilot to production operations |

**Non-negotiables for enterprise MCP**

1. **URL + Bearer** on `POST /mcp/sessions/<session_id>` — never ship “URL only”.
2. **Git hygiene** for `.cursor/mcp.json` and backups — treat as local secrets surface.
3. **Explicit CLI subcommands** in automation (`annie claude`, not ambiguous defaults).

---

## 2. Phase model at a glance

```
┌─────────────────────────────────────────────────────────────────────────┐
│  CTO workflow     Analysis → Design → Risk → Implementation              │
│       │                   (runs continuously, gates each NEST phase)       │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6         Discovery → … → Operate   (platform lifecycle)        │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4        Git safety → Stale detect → Server proxy → Ext. IDE    │
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4        Pilot → Standardize → Worker → MCP scale → Operate   │
└─────────────────────────────────────────────────────────────────────────┘
```

**How to read this document:** Execute **NEST phases** in order. Within **Phase 2–4**, layer in **MCP M1–M3** minimum before org-wide IDE rollout. Use **Ops P0–P4** to sequence people and support load. Apply the **CTO workflow** at every gate.

---

## 3. CTO engineering workflow phases

Structured decision-making (first principles, trade-offs, risk, validation). Use it as a **gate** before closing each NEST phase.

### Phase A — Analysis

| Item | Practice |
|------|----------|
| **Purpose** | Separate symptoms from requirements; surface hidden assumptions |
| **Key questions** | Who runs the CLI? Who owns the server? Is MCP on the attack surface? Which data leaves the workstation? |
| **Outputs** | Stakeholder map, threat assumptions, list of IDE transports (stdio vs HTTP) per team |
| **Exit gate** | Written “MCP threat model one-pager” approved by security or tech lead |

### Phase B — Design

| Item | Practice |
|------|----------|
| **Purpose** | Compare real options with explicit trade-offs |
| **Options** | (1) Local MCP only, (2) Server-proxied MCP with Bearer, (3) Stdio bridge (`annie mcp`) for legacy clients |
| **Trade-off matrix** | Security vs convenience; central audit vs local latency; stdio compatibility vs native HTTP |
| **Exit gate** | Selected pattern per persona (developer laptop vs runner host vs external IDE) |

### Phase C — Risk

| Item | Practice |
|------|----------|
| **Purpose** | Identify failure modes and rollback |
| **Examples** | Token leak via committed `mcp.json`; orphaned localhost URLs; MCP tool surface too broad |
| **Outputs** | Rollback playbook (disable MCP server entry, rotate token, purge cache) |
| **Exit gate** | Dry-run rollback documented and owned |

### Phase D — Implementation

| Item | Practice |
|------|----------|
| **Purpose** | Ship with defensive defaults and observability |
| **Practices** | Mandatory Bearer on server MCP; no secrets in repo; logs on stderr for stdio bridge |
| **Exit gate** | Automated or manual checks in §12 pass for the target environment |

---

## 4. NEST implementation phases 0–6

Aligned with **[NEST methodology](../methodology/README.md)**. Each row expands Annie + MCP work.

### Phase 0 — Discovery

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Map teams, agents, IDEs; confirm success metrics |
| **Annie activities** | Inventory who needs `annie claude` vs `annie cursor` vs `annie codex`; document OS and install path |
| **MCP activities** | List which teams use Cursor HTTP MCP vs VS Code vs Claude Desktop stdio |
| **Deliverables** | Pilot cohort list; IDE inventory; “no MCP without auth” policy draft |
| **Exit gate** | Sponsor sign-off on pilot scope |

### Phase 1 — Strategy

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Token model, proxy routes, compliance narrative |
| **Annie activities** | Decide `CLI_API_TOKEN` issuance (per team namespace if used); vault vs `annie auth login` |
| **MCP activities** | Nginx (or edge) must forward **`/mcp/`** to Rust; document TLS termination |
| **Deliverables** | Architecture diagram; RACI for token rotation |
| **Exit gate** | Security review of MCP URL exposure (internal vs VPN vs public) |

### Phase 2 — Foundation

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Production-grade server; secrets distributed |
| **Annie activities** | Standardize `NEST_API_URL` per env; verify `annie auth status` on golden images |
| **MCP activities** | Complete **M1** (gitignore patterns) before wide Cursor adoption |
| **Deliverables** | Runbook: “new laptop onboarding” |
| **Exit gate** | Health checks green; sample session from PWA |

### Phase 3 — Build

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Workers, IDE configs, bridges |
| **Annie activities** | `annie worker start` on designated hosts; train on `annie worker list` / `stop-session` |
| **MCP activities** | Complete **M2–M3** (stale detection behavior + server-proxied MCP for runner sessions) |
| **Deliverables** | Template `mcp.json` with `url` + `headers` (redacted); stdio wrapper examples |
| **Exit gate** | End-to-end: PWA action → RPC → tool result |

### Phase 4 — Hardening

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Auth enforcement, secret scanning, training |
| **Annie activities** | CI image with pinned CLI version; `annie diagnose` in troubleshooting docs |
| **MCP activities** | Verify **401** without Bearer; pre-commit hooks for `mcp.json` |
| **Deliverables** | Security test evidence; support macros |
| **Exit gate** | §12 checklist 100% in staging |

### Phase 5 — Launch

| Dimension | Detail |
|-----------|--------|
| **Objectives** | Pilot → department → company with feedback loops |
| **Annie activities** | Measure session creation failures, worker disconnects |
| **MCP activities** | Capture IDE client versions; track MCP-specific tickets |
| **Deliverables** | Launch retrospective; KPI dashboard |
| **Exit gate** | Sponsor review against metrics |

### Phase 6 — Operate

| Dimension | Detail |
|-----------|--------|
| **Objectives** | SRE-style operation, cost and risk control |
| **Annie activities** | Quarterly CLI upgrade communication; log sampling |
| **MCP activities** | Token rotation calendar; review tool surface quarterly |
| **Deliverables** | Op metrics: MCP 4xx/5xx rates, RPC latency |
| **Exit gate** | Continuous improvement backlog funded |

**RACI hint (example, adjust to your org)**

| Activity | Engineering | Security | IT / Desktop | Support |
|----------|-------------|----------|--------------|---------|
| Token issuance | C | A | I | I |
| Nginx `/mcp/` route | R | C | A | I |
| MCP runbooks | R | C | I | A |
| Pilot users | A | I | C | R |

*(R = responsible, A = accountable, C = consulted, I = informed)*

---

## 5. MCP technical maturity phases (M1–M4)

Maps to NEST platform evolution for MCP safety and deployability.

### M1 — Git and repository safety

| Item | Action |
|------|--------|
| **Goal** | Prevent accidental commit of injected MCP config |
| **Actions** | `.gitignore` for `**/.cursor/mcp.json`, `**/.cursor/mcp.json.nest-backup`; developer training |
| **Verification** | Grep CI fails on tracked `mcp.json` patterns |

### M2 — Stale entry detection

| Item | Action |
|------|--------|
| **Goal** | Reduce broken localhost URLs after crashes |
| **Actions** | Rely on Annie injection logic (reachability check where applicable); document manual cleanup |
| **Verification** | Simulated crash → next launch recovers or overwrites stale entry |

### M3 — Server-proxied MCP

| Item | Action |
|------|--------|
| **Goal** | Runner / remote Cursor uses server URL, not loopback-only MCP |
| **Actions** | Effective API base + `/mcp/sessions/<id>` + **Bearer**; proxy `/mcp/` in prod |
| **Verification** | MCP works when Cursor and worker run on different hosts |

### M4 — External IDE scale-out

| Item | Action |
|------|--------|
| **Goal** | VS Code, Claude Desktop, ChatGPT connectors (where supported) with same auth model |
| **Actions** | Standard templates per client; optional future `annie mcp install` style automation per release |
| **Verification** | Non-Cursor client passes same §12 checks |

---

## 6. Operational rollout phases (P0–P4)

People and process sequencing (orthogonal to NEST 0–6 but usually overlaps Phase 2–6).

### P0 — Pilot (5–20 users)

| Topic | Detail |
|-------|--------|
| **Scope** | One primary agent mode; one IDE family; MCP optional but Bearer mandatory if enabled |
| **Duration** | Typically 2–4 weeks |
| **Success metrics** | Session success rate, zero secret incidents, support hours per user |
| **Exit** | Go / no-go for P1 |

### P1 — Standardize

| Topic | Detail |
|-------|--------|
| **Scope** | Golden `NEST_API_URL`; mandatory `annie auth login` or MDM-delivered env |
| **MCP** | M1 complete org-wide |
| **Exit** | Audit sample: 95%+ machines pass `annie auth status` |

### P2 — Worker production

| Topic | Detail |
|-------|--------|
| **Scope** | Dedicated runner hosts; on-call for `annie worker status` |
| **MCP** | M3 validated for remote spawn |
| **Exit** | Remote session demo from PWA with audit log entry |

### P3 — MCP scale

| Topic | Detail |
|-------|--------|
| **Scope** | HTTP MCP for Cursor; stdio bridge for others; published runbooks |
| **MCP** | M4 pilot for second client (e.g. VS Code) |
| **Exit** | MCP auth incidents have known MTTR |

### P4 — Steady-state operations

| Topic | Detail |
|-------|--------|
| **Scope** | Quarterly token rotation; version pinning policy for CLI |
| **Metrics** | RPC errors, MCP HTTP codes, worker restarts |
| **Exit** | Continuous compliance evidence |

---

## 7. Architecture snapshot

```
Employee machine                         Your NEST server                    Clients
─────────────────                        ─────────────────                   ───────
annie <agent>  ── Socket.IO ───────────►  Rust server  ◄── SSE/REST ───────  Web PWA / Telegram
     │                                    Postgres audit
     │                                    POST /mcp/sessions/:sessionId
     ▼                                              ▲
Cursor / VS Code MCP  ── Streamable HTTP ──────────┘
     (URL + Authorization: Bearer …)
```

**Invariants**

- **Shared secret or derived tokens:** `CLI_API_TOKEN` (and namespaced variants where configured).
- **Effective API base URL:** localhost/IP → **include server port**; public hostname → **origin without port** (TLS at 443).
- **MCP route:** **`/mcp/sessions/<session_id>`** (not under `/api`); **Bearer required**.

---

<a id="section-8-cli-reference"></a>

## 8. CLI (`@contextzero/nest`) — full command surface

Install the CLI from npm only: **`npm install -g @contextzero/nest`**. The executable is **`annie`**. Capability and flags ship with the published package version—verify with **`annie --version`** and [RELEASES.md](../../RELEASES.md). *(Source trees are private; this section describes the public CLI behavior.)*

### 8.1 Default resolution (automation hygiene)

If the first argv token is **not** a registered subcommand, the CLI historically treats the invocation as **`annie cursor`** with those tokens passed through. **In scripts and CI, always spell the subcommand explicitly** (`annie claude …`, `annie computer …`, `annie cursor …`, etc.)—never rely on the default.

### 8.2 Development — IDE-tied coding agents

These commands launch or resume **editor-scoped** sessions that stream to your NEST hub (Socket.IO session model). Typical use: software development on an employee laptop with Cursor, Claude Code, Codex, OpenCode, or KiloCode installed where applicable.

| Area | Command | Purpose |
|------|---------|---------|
| **Claude Code** | `annie claude [args…]` | Anthropic Claude Code + hub sync; supports `--help` passthrough to local `claude` |
| **Cursor** | `annie cursor [args…]` | Cursor Agent + hooks/MCP wiring; `annie cursor resume <chatId>` when resuming |
| **Codex** | `annie codex [args…]` | OpenAI Codex; `annie codex resume <sessionId>` where supported |
| **Gemini** | `annie gemini [args…]` | Google Gemini (ACP-style) session |
| **OpenCode** | `annie opencode [args…]` | OpenCode local launcher + hub session |
| **KiloCode** | `annie kilocode [args…]` | KiloCode launcher + hub session |

### 8.3 Management — `annie computer` (multi-tool “computer use”)

**`annie computer`** starts the **hub-synced computer agent**: an interactive loop backed by a broad **tool registry** (shell, files, git, browser via CDP, process manager, in-process scheduler, HTTP fetch, screenshots, workspace switches, memory/skills hooks, subagent delegation, optional local browser gateway/RPC, etc.). Use it for **operations and management** work that goes beyond a single IDE plugin—runbooks, cross-repo tasks, light SRE, research with browser evidence, and guarded automation—**with the same audit and permission posture** as other hub sessions.

Optional overrides (non-interactive bootstrap): **`annie computer --host <url> --token <CLI_API_TOKEN>`** (also honor `NEST_API_URL` / `CLI_API_TOKEN` from env or `annie auth login`).

**Computer wrappers (June 1, 2026):** **OpenClaw**, **ZeroClaw**, and **Hermes** ship **as wrappers inside `annie computer`**—the same integration pattern as other Computer-backed agents (for example Claude Code, Cursor, Codex)—**not** as top-level `annie openclaw` / `annie zeroclaw` / `annie hermes` commands. **Projects:** **project management** targets **May 1, 2026**; **CRM** targets **May 15, 2026** — [ROADMAP.md](../../ROADMAP.md) · product detail: [zeroclaw.md](./zeroclaw.md) · [RELEASES.md](../../RELEASES.md).

### 8.4 Terminal management (remote PTY)

NEST exposes **terminal sessions** tied to hub projects: the CLI hosts **PTY-backed shells** (via `node-pty`, with a Node worker path when the CLI runtime is Bun) so the **web PWA / dashboard** can attach, resize, and stream stdin/stdout for remote troubleshooting or long commands. Treat terminal surfaces as **high-privilege**: scope who can spawn them, rotate tokens, and prefer permission modes that require approval for destructive commands.

### 8.5 Platform operations & integration

| Area | Command | Purpose |
|------|---------|---------|
| **Auth** | `annie auth login` / `annie auth status` / `annie auth logout` | Persist or inspect `NEST_API_URL` + `CLI_API_TOKEN` (+ machine binding) |
| **Worker** | `annie worker start` (detached) · `start-sync` · `stop` · `status` · `list` · `stop-session <id>` · `logs` | Background worker for remote/long-lived hub work |
| **MCP bridge** | `annie mcp [--url <url>] [--token \| --bearer <secret>]` | stdio MCP → Streamable HTTP to `POST /mcp/sessions/<id>`; env: `NEST_HTTP_MCP_URL`, `CLI_API_TOKEN`, `NEST_MCP_BEARER_TOKEN` |
| **Bundled server** | `annie server [--host …] [--port …]` | Starts the packaged web/hub dev server when that optional bundle is present in your install |
| **Diagnostics** | `annie diagnose` · `annie diagnose clean` | Full health report; `clean` kills runaway CLI-related processes |
| **Hooks** | `annie hook-forwarder [args…]` | Internal: forwards IDE/session hooks for Claude integrations—avoid manual use unless documented by support |

### 8.6 Not available in self-hosted direct-connect mode

| Command | Behavior |
|---------|----------|
| **`annie connect`** | Exits with guidance: vendor token storage was for a hosted flow—use `annie auth login` + `CLI_API_TOKEN` instead |
| **`annie notify`** | Exits with guidance: use Telegram / server-side notifications from your hub |

### 8.7 One-line cheat sheet

```text
annie auth login | status | logout
annie claude | cursor | codex | gemini | opencode | kilocode   # development agents
annie computer                                           # management / multi-tool agent
annie worker start | stop | status | list | stop-session <id> | logs
annie mcp
annie server [--host …] [--port …]
annie diagnose | diagnose clean
annie hook-forwarder   # internal / advanced
```

---

## 9. Configuration & URL rules

| Variable | Required | Description |
|----------|----------|-------------|
| `CLI_API_TOKEN` | **Yes** | Must match server |
| `NEST_API_URL` | No | Normalized effective base URL |
| `NEST_HOME` | No | Default `~/.nest` |
| `NEST_HTTP_MCP_URL` | No | Default target for `annie mcp` |
| `NEST_MCP_BEARER_TOKEN` | No | Optional bearer for bridge if not using `CLI_API_TOKEN` |

See [INSTALL.md](../INSTALL.md) for worker tuning variables.

---

## 10. MCP — protocol, security, and endpoints

### 10.1 Endpoint

- **POST** `/mcp/sessions/<session_id>`
- **Header:** `Authorization: Bearer <token>`
- **Body:** JSON-RPC 2.0 (MCP Streamable HTTP)

### 10.2 Cursor example (`mcp.json`)

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/YOUR_SESSION_ID",
      "headers": {
        "Authorization": "Bearer YOUR_CLI_API_TOKEN"
      }
    }
  }
}
```

### 10.3 Stdio bridge

```bash
# Preferred in production: env vars (token not in argv / shell history)
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/YOUR_SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

Or pass **URL and token on the command line** (handy for local tests; token may appear in `ps` and shell history):

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/YOUR_SESSION_ID" --token "YOUR_CLI_API_TOKEN"
```

`--bearer` is an alias for `--token`. CLI arguments override env for the token when both are set.

### 10.4 Git hygiene

Machine-local `.cursor/mcp.json`; never commit tokens; prefer secret manager injection for wrappers.

---

## 11. Client-specific integration patterns

| Client | Recommended pattern |
|--------|---------------------|
| **Cursor** | HTTP `url` + `headers.Authorization` in `.cursor/mcp.json` |
| **VS Code** | Extension-native HTTP **or** stdio with `annie mcp` + env |
| **Claude** | Stdio → `annie mcp` + env or keychain wrapper |
| **ChatGPT** | Custom HTTP MCP when product allows — same Bearer model |

All of the above are **independent of repository programming language**—they bind to workspace + session.

---

## 12. Risk, validation, and governance

| Risk | Mitigation |
|------|------------|
| Token exfiltration | Rotation; namespaced tokens; vault |
| Stale MCP URL in Git | `.gitignore`, CI grep, training |
| Over-broad tools | Security review before expanding MCP tool list |
| “Localhost is safe” myth | Bearer still required on server MCP |

**Validation checklist**

- [ ] `annie auth status` → expected URL
- [ ] `annie diagnose` clean on sample machines
- [ ] MCP without `Authorization` → **401**
- [ ] MCP with valid token → `initialize` / `tools/list` succeed
- [ ] PWA can drive session (RPC path end-to-end)

---

## 13. Related documents

| Document | Contents |
|----------|----------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | Business-oriented CLI overview |
| [INSTALL.md](../INSTALL.md) | Installation |
| [DEVOPS.md](../DEVOPS.md) | HTTPS, reverse proxy |
| [Methodology](../methodology/README.md) | NEST phases 0–6 |
| [Enterprise README](./README.md) | Enterprise features |
| [nest-server image](https://hub.docker.com/r/matiasbaglieri/nest-server) | Server routes ship in the published container; contracts documented in **nest_hub** |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
