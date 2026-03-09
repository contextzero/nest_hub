# Roadmap — pending implementation

This document outlines **planned and in-progress** capabilities for NEST and the Facta platform. It aligns with our knowledge base (agents, strategy, entrepreneurship) and is intended to promote a clear product direction.

---

## 1. Souls — memory bank

**Concept:** A persistent, queryable **memory bank** (“Souls”) so agents and users can store and reuse context across sessions and over time — preferences, decisions, facts, and interaction history.

**Why it matters:**  
Enables adaptive, long-horizon behavior: agents that “remember” you and prior work instead of starting from scratch each session. Aligns with enterprise and product thinking from our strategy and entrepreneurship knowledge (e.g. *Entrepreneurship: Strategies and Resources*, *Business Model Generation*): persistent context supports repeatable processes and better decisions.

**Planned direction:**

- **Storage:** Durable store (e.g. SQLite or dedicated store) keyed by namespace/user/session.
- **API:** Read/write/query memories; optional summarization and retrieval for agent context.
- **Integration:** CLI and Hub expose memory APIs; agents receive relevant memories in context.
- **Governance:** Access control, retention, and optional deletion to meet enterprise and privacy needs.

**Status:** Design and scoping; not yet implemented in the current CLI/Hub release.

---

## 2. Multi-agent orchestration

**Concept:** **Multiple specialized agents** working in a coordinated pipeline (e.g. PM → architecture → dev ↔ QA → launch) with clear handoffs, quality gates, and evidence-based progression.

**Why it matters:**  
Single-session agents are limited; complex products need orchestrated workflows. Our knowledge base (e.g. *Agentic Architectural Patterns for Building Multi-Agent Systems*, NEXUS strategy, Agents Orchestrator, specialist playbooks) emphasizes:

- Quality gates and Dev↔QA loops
- Handoff templates and activation prompts
- Phase-based playbooks (discovery → strategy → foundation → build → harden → launch → operate)
- Evidence over claims (screenshots, tests, data)

**Planned direction:**

- **Orchestrator:** A coordinator agent or service that runs pipelines, spawns specialists, and enforces phase transitions and quality gates.
- **Specialists:** Reusable agent roles (engineering, design, product, marketing, support) aligned with our [agents/specialists](https://github.com/ctx0/nest/tree/main/docs/knowladge/agents/specialists) definitions.
- **Integration with NEST:** Sessions and machines as execution units; Hub as the sync and persistence layer for multi-agent state and events.
- **Runbooks:** Codified scenarios (MVP, enterprise feature, campaign, incident) as in our strategy runbooks.

**Status:** Strategy and playbooks exist in the knowledge base; runtime orchestration and full NEST integration are pending.

---

## 3. Spec-driven development (Forge)

**Concept:** **Spec-driven development** — human-written specifications (requirements, acceptance criteria, constraints) drive implementation and verification. A “Forge” workflow: spec → tasks → implementation → verification, with traceability and optional automation.

**Why it matters:**  
Reduces ambiguity and rework; aligns implementation with intent. Complements multi-agent orchestration (e.g. “read spec → produce task list → implement → QA”) and fits enterprise and product practices from our entrepreneurship and strategy docs (business plans, validation, phased execution).

**Planned direction:**

- **Spec format:** Structured specs (e.g. markdown + schema or YAML) with sections for scope, requirements, acceptance criteria, and constraints.
- **Forge workflow:** Spec ingestion → task breakdown (manual or agent-assisted) → assignment to agents/sessions → verification (tests, checks, evidence).
- **Traceability:** Links from requirements to tasks to code/artifacts to verification results.
- **Tooling:** CLI and/or Hub features to create, version, and reference specs; optional UI for spec and task status.

**Status:** Concept and alignment with playbooks; spec format and Forge implementation are pending.

---

## Knowledge base references

Our roadmap is informed by the **NEST project’s knowledge base** ([ctx0/nest](https://github.com/ctx0/nest) — `docs/knowladge/`), including:

| Area | Location / focus |
|------|-------------------|
| **Multi-agent strategy** | `docs/knowladge/agents/specialists/strategy/` — NEXUS, QUICKSTART, playbooks (phase 0–6), runbooks |
| **Orchestration & specialists** | `docs/knowladge/agents/specialists/specialized/agents-orchestrator.md`, engineering/design/product/marketing/support specialists |
| **Agentic patterns** | `docs/knowladge/agents/strategies/agentic_architectural_patterns.md` — multi-agent systems, reliability, governance |
| **Entrepreneurship & product** | `docs/knowladge/entrepreneurship/` — strategy, resources, business model; product and launch discipline |
| **Coordination** | Handoff templates, agent activation prompts, quality gates and evidence |

These materials guide how we design Souls, multi-agent orchestration, and Forge so they fit enterprise and product use cases.

---

## Summary

| Initiative | Goal | Status |
|------------|------|--------|
| **Souls** | Persistent memory bank for agents and users | Planned |
| **Multi-agent** | Orchestrated specialist pipelines with quality gates | Strategy/playbooks ready; runtime pending |
| **Spec-driven (Forge)** | Specs drive implementation and verification with traceability | Planned |

Releases and current deliverables are documented in [RELEASES.md](RELEASES.md). For install and setup, see [QUICKSTART.md](QUICKSTART.md) and [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md).

---

*Powered by [facta.dev](https://facta.dev).*
