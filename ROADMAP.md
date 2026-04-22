<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Roadmap

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.
What's being built next, why it matters, and how to participate.

> **Already live and free today:** See [RELEASES.md](RELEASES.md).
> This document is about what comes *after* — the capabilities that transform NEST from a workforce monitor into a fully autonomous AI business operating system.

**Dated milestones (2026):** **May 1** — **project management** in projects · **May 15** — **CRM** (lifecycle + contacts across projects) · **June 1** — **`annie computer` wrappers**: **OpenClaw**, **ZeroClaw**, and **Hermes** (same pattern as Claude, Cursor, Codex, …)—not `annie openclaw` / `annie zeroclaw` / `annie hermes`. Details: [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) · [RELEASES.md](RELEASES.md).

---

## The Direction: From Visibility to Intelligence

NEST today gives you **visibility and control** over your AI workforce. Every session is visible. Every approval is in your hands. Every action is logged.

That's the foundation. What's being built next goes further:

- **Agents that remember** — across sessions, across time, across your entire company context
- **Agents that coordinate** — specialized roles working in defined pipelines with quality gates you control
- **Development driven by your specs** — implementation that traces directly back to your business requirements

> **The Four Pillars of NEST:** Hub for Enterprise · Mobile for the Employee · Memory Bank (Souls) · Agent Swarm. The initiatives below extend these pillars.

The three initiatives below are the next phase of NEST. Each one compounds the value of what's already running.

---

## Initiative 1 — Souls: Persistent Agent Memory

### The Problem This Solves

Right now, every agent session starts from zero. The agent doesn't know what was decided last week, what your coding conventions are, what the customer said in the last meeting, or what that three-hour architecture discussion concluded. Every session begins with a blank slate.

That means your team re-explains context constantly. Your agents re-discover things already known. And the institutional knowledge your business is building — the decisions, the patterns, the preferences — evaporates between sessions.

### What Souls Will Do

**Souls** is a persistent, queryable memory bank — shared across agents, sessions, and over time. Think of it as the long-term memory your AI workforce currently lacks.

```
Session A (Monday)  →  decision stored in Souls
Session B (Tuesday) →  agent reads context from Souls → builds on it
Session C (Friday)  →  new agent inherits all prior context → no re-explanation
```

**What gets stored:**
- Architecture decisions and rationale
- Code conventions and team preferences
- Customer requirements and feedback
- Past session outcomes and lessons learned
- Business rules, constraints, and policies

**How it's governed:**
- Per-namespace / per-user / per-session access control
- Retention policies — you decide what persists and for how long
- Optional summarization for large context windows
- Deletion controls for privacy and compliance

### Why This Matters for Your Business

Agents with memory are fundamentally different from agents without it. The difference is the same as between a new contractor who needs a two-day onboarding and a senior employee who already knows your systems, your preferences, and your history.

Souls turns every agent into the second type.

**Status:** Design and scoping — not yet in the current release. Tracked openly; updates will appear in [RELEASES.md](RELEASES.md) when shipped.

---

## Initiative 2 — Multi-Agent Orchestration

### The Problem This Solves

A single agent session, no matter how capable, can only do one thing at a time. Building a real product — or running a real business process — requires many things done in the right order, with the right checks, by the right roles.

Today, if you want a PM to define requirements, an architect to design a solution, a developer to implement it, and a QA agent to verify it, you coordinate that manually. You switch between sessions. You copy output from one session into another. There's no handoff protocol. There's no quality gate. There's no guarantee the next phase only starts when the previous one is done right.

### What Multi-Agent Orchestration Will Do

An **Orchestrator** that runs structured agent pipelines — spawning specialists, enforcing phase transitions, and maintaining a quality gate between each stage.

**Example pipeline (software feature):**

```
PM Agent          → requirements, acceptance criteria, constraints
      ↓ [gate: spec approved]
Architect Agent   → design, tech decisions, risk assessment
      ↓ [gate: design reviewed]
Dev Agent         → implementation, unit tests
      ↕ [loop: Dev ↔ QA until passing]
QA Agent          → verification, evidence (screenshots, test results, data)
      ↓ [gate: all criteria met]
Launch Agent      → deployment, documentation, monitoring setup
```

**Every gate requires evidence, not just claims.** The next phase doesn't start because the agent *says* it's done — it starts when the work is *verified*.

**Specialist roles being defined:**
| Role | Responsibility |
|------|---------------|
| **PM** | Requirements, acceptance criteria, scope |
| **Architect** | Technical design, decision records |
| **Engineering** | Implementation, unit tests |
| **QA** | Verification, test execution, evidence |
| **Design** | UX, visual specs, component definitions |
| **Marketing** | Copy, campaigns, launch assets |
| **Support** | Runbooks, escalation procedures |

**Phase-based playbooks:**
Discovery → Strategy → Foundation → Build → Harden → Launch → Operate

Each phase has defined inputs, outputs, quality gates, and handoff templates. Agents don't improvise the process — they execute a codified workflow that you control.

**NEST integration:** Sessions and machines as execution units. The NEST Server as the sync and persistence layer for multi-agent state, events, and audit trail. Everything visible in your mobile dashboard.

### Why This Matters for Your Business

Coordinated AI agents working a structured pipeline are not 6× faster than one agent — they're a different category of tool. The same way an assembly line isn't just a faster single worker: it's a system with roles, handoffs, and quality checks that produces consistent, verifiable output.

This is how you go from "AI helps my developers" to "AI operates a development process."

**Status:** Strategy and playbooks defined in the knowledge base. Runtime orchestration and full NEST integration are the active development focus. Updates in [RELEASES.md](RELEASES.md) when shipped.

---

## Initiative 3 — Spec-Driven Development (Forge)

### The Problem This Solves

When you tell an agent to "build a login system," you get whatever the agent decides a login system is. When requirements change, the agent doesn't know what changed or why. When you need to audit what was built and why, there's no trace. When a new agent picks up where the last one left off, context is lost.

The core problem: **agents are disconnected from your intent.** They implement something, but it may not be what you needed. And proving the gap — or closing it — requires manual effort that erases most of the productivity gain.

### What Forge Will Do

**Forge** is a spec-driven development workflow. Human-written specifications drive implementation and verification — creating a direct traceable line from business requirement to finished artifact.

**The Forge workflow:**

```
1. SPEC       → You write: scope, requirements, acceptance criteria, constraints
      ↓
2. TASKS      → Agent (or you) breaks spec into concrete, assignable tasks
      ↓
3. IMPLEMENT  → Agent sessions execute tasks against the spec
      ↓
4. VERIFY     → Tests, checks, and evidence are traced back to acceptance criteria
      ↓
5. TRACE      → Full audit: requirement → task → code → verification result
```

**Spec format:** Structured markdown with defined sections — no new tool to learn. Version-controlled alongside your code.

**Traceability:** Every task links to a requirement. Every verification links to an acceptance criterion. When a stakeholder asks "did we build what we said we'd build?" — the answer is a link, not a conversation.

**Tooling:**
- CLI and Server features to create, version, and reference specs
- Optional UI for spec and task status in the NEST web app
- Integration with multi-agent orchestration — specs feed directly into phase-based pipelines

### Why This Matters for Your Business

Requirements exist in every business. The problem isn't that requirements aren't written — it's that they're written in documents that agents never read, in meetings that agents never attended, in emails that agents will never see.

Forge connects your business intent directly to agent execution. The agent doesn't guess what you need. It reads what you specified, implements against it, and reports back against the same criteria you defined.

This is the difference between "we asked AI to build something" and "we directed AI to build exactly this, and here's the proof it did."

**Status:** Concept defined and aligned with existing playbooks. Spec format and Forge implementation are in scoping. Updates in [RELEASES.md](RELEASES.md) when shipped.

---

## The Full Picture — Where This Leads

```
TODAY                        NEXT                           HORIZON
─────────────────────────    ─────────────────────────────  ─────────────────────────
✅ Live sessions visible      🔨 Agents that remember         ◻ AI operating system
✅ Mobile approvals           🔨 Coordinated pipelines        ◻ Autonomous business ops
✅ Full audit log             🔨 Spec-driven traceability     ◻ Enterprise participation
✅ Multi-agent hub            🔨 Quality-gated handoffs       ◻ Custom playbooks & roles
✅ BYOK all providers         🔨 Evidence-based verification  ◻ Org-wide intelligence
```

Each layer builds on the one before it. Deploy today. The layers ship on top of what's already running — no migration, no reinstall.

---

## How to Participate

NEST is being built with input from the businesses, entrepreneurs, NGOs, and governments using it. If you're deploying NEST and want to:

- **Shape the Souls data model** for your use case (enterprise vs. team vs. solo)
- **Define specialist roles** for your industry or workflow
- **Pilot Forge** with your real specifications before general release
- **Contribute playbooks** for your domain (legal, fintech, e-commerce, SaaS, etc.)

→ Join the conversation: [Telegram](https://t.me/ctx0_io) · [Discord](https://discord.gg/ygjuuDAw)
→ Open an issue or start a discussion at [contextzero/nest_hub](https://github.com/contextzero/nest_hub)
→ Reference business and workforce hub methodology: [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md)

The organizations that participate in design get the system that fits them. The ones that wait get a system built for someone else.

---

## Summary

| Initiative | What It Solves | Status |
|------------|---------------|--------|
| **Souls** — Persistent memory | Agents that start from zero every session | Design & scoping |
| **Multi-agent** — Orchestrated pipelines | One agent doing everything serially | Strategy ready; runtime pending |
| **Forge** — Spec-driven development | Implementation disconnected from business intent | Concept defined; scoping in progress |

Current deliverables: [RELEASES.md](RELEASES.md) · Setup: [QUICKSTART.md](QUICKSTART.md) · Business docs: [docs/business/README.md](docs/business/README.md) · Methodology: [docs/methodology/README.md](docs/methodology/README.md)

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>