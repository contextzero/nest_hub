<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# ZeroClaw, OpenClaw & Hermes — Automation Engines

## Computer integration (June 1, 2026)

**OpenClaw**, **ZeroClaw**, and **Hermes** are moving into **`annie computer`** as **wrappers**—the same integration pattern as other agents you run through Computer (for example **Claude Code**, **Cursor**, **Codex**): one multi-tool session on the hub, governed permissions, and a single audit trail. They will **not** ship as separate top-level CLI commands such as `annie openclaw`, `annie zeroclaw`, or `annie hermes`.

**Target release:** **June 1, 2026** (coordinated `@contextzero/nest` + hub update). Until then, behavior may follow the current hub/dashboard flows described below; watch [RELEASES.md](../../RELEASES.md) for the exact package and image versions when this lands.

**Related roadmap (projects):** **Project management** targets **May 1, 2026**; **CRM** targets **May 15, 2026** — see [ROADMAP.md](../../ROADMAP.md).

---

## Overview

**ZeroClaw** and **OpenClaw** are NEST's automation engines that give employees complete control over their machines and workflows — beyond just coding.

---

## What They Do

### ZeroClaw

Headless automation with self-correction:

- Runs tasks autonomously
- Observes outcomes
- Adapts and retries
- Full audit trail

**Use cases:**
- Daily report generation
- Data synchronization
- System maintenance
- Scheduled tasks

### OpenClaw

Visual workflow orchestration:

- Drag-and-drop task graphs
- Dependencies and conditions
- Browser automation
- Desktop control

**Use cases:**
- Multi-step processes
- Complex workflows
- Human-in-the-loop approval
- Project orchestration

### Hermes

Computer-use path aligned with **NEST Computer**—ships as a **wrapper inside `annie computer`** on **June 1, 2026**, alongside OpenClaw and ZeroClaw, with the same governed session and audit model.

---

## Capabilities

### Browser Automation

| Feature | Description |
|---------|-------------|
| **Web scraping** | Extract data from any website |
| **Form filling** | Automate data entry |
| **Testing** | UI testing workflows |
| **Monitoring** | Watch for changes |

### Desktop Control

| Feature | Description |
|---------|-------------|
| **File operations** | Copy, move, organize files |
| **Applications** | Open, close, control apps |
| **Keyboard/mouse** | Automate any GUI action |
| **Screenshots** | Capture and process |

### Communication

| Feature | Description |
|---------|-------------|
| **Email** | Send, read, categorize |
| **Slack/Teams** | Post messages, respond |
| **Calendar** | Create events, check availability |

### Data Operations

| Feature | Description |
|---------|-------------|
| **Database** | Query and update |
| **Files** | CSV, JSON, Excel processing |
| **APIs** | Connect to any service |

---

## Task Graph Example

```
┌─────────────┐
│  TRIGGER    │  ← Scheduled or event-based
└──────┬──────┘
       ↓
┌─────────────┐     ┌─────────────┐
│  FETCH DATA │ ──→ │  PROCESS    │
│  (API call) │     │  (transform)│
└─────────────┘     └──────┬──────┘
                          ↓
                  ┌─────────────┐
                  │  DECISION   │  ← Condition check
                  └──────┬──────┘
              ┌───────────┴───────────┐
              ↓                       ↓
       ┌─────────────┐         ┌─────────────┐
       │  APPROVAL   │         │   AUTO      │
       │  (human)    │         │  CONTINUE   │
       └──────┬──────┘         └──────┬──────┘
              │                       │
              └───────────┬───────────┘
                          ↓
                   ┌─────────────┐
                   │  NOTIFY     │  ← Email/Slack
                   │  (result)   │
                   └─────────────┘
```

---

## Creating Workflows

### OpenClaw (Visual)

1. **Open OpenClaw** in NEST dashboard
2. **Drag** task nodes onto canvas
3. **Connect** nodes to define flow
4. **Configure** each task's parameters
5. **Test** with sample data
6. **Deploy** to run automatically

### ZeroClaw (Code)

```yaml
name: Daily Sales Report
trigger:
  type: schedule
  cron: "0 8 * * *"  # 8am daily

tasks:
  - name: Fetch CRM Data
    action: api.get
    config:
      url: https://crm.company.com/api/deals
      auth: $CRM_TOKEN

  - name: Process Data
    action: transform
    input: $FETCH_CRM_DATA
    config:
      script: |
        return deals.filter(d => d.status === 'won')
                   .map(d => ({...d, value: d.amount * d.probability}));

  - name: Generate Report
    action: document.create
    input: $PROCESS_DATA
    config:
      template: sales-weekly
      format: pdf

  - name: Send Email
    action: email.send
    input: $GENERATE_REPORT
    config:
      to: sales-team@company.com
      subject: "Weekly Sales Report"
```

---

## Triggers

| Trigger | Description |
|---------|-------------|
| **Schedule** | Cron-based timing |
| **Webhook** | HTTP request starts workflow |
| **Email** | Incoming email triggers |
| **File** | New file in folder |
| **Manual** | User starts manually |
| **Event** | System event (new user, etc.) |

---

## Self-Correction (ZeroClaw)

ZeroClaw observes outcomes and adapts:

```
Task Failed
    ↓
Analyze Error
    ↓
Identify Cause
    ↓
Generate Fix
    ↓
Retry (up to N times)
    ↓
Still failing? → Alert human
```

### Example

```
1. Task: "Update CRM with new leads"
2. Fails: "Rate limit exceeded"
3. ZeroClaw: "Waiting 60s and retrying"
4. Fails again: "Different error"
5. ZeroClaw: "Trying alternative API endpoint"
6. Success: "Continuing workflow"
7. Alert: "Human notified of issues resolved"
```

---

## Enterprise Features (vs Community)

| Feature | Community | Enterprise |
|---------|-----------|------------|
| Basic automation | ✅ | ✅ |
| Browser automation | ✅ | ✅ |
| Desktop control | ✅ | ✅ |
| Self-correction | Basic | Advanced |
| Scheduled triggers | ✅ | ✅ |
| Webhook triggers | ✅ | ✅ |
| Multi-machine | ❌ | ✅ |
| Custom integrations | ❌ | ✅ |
| Workflow templates | ❌ | ✅ |
| Version control | ❌ | ✅ |

---

## Security

- All actions logged
- Permissions per workflow
- Credential management
- Audit trail complete
- Sandboxed execution

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
