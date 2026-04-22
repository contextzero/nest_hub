<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Console Flow — How Requests Become Results on Your Phone

The **console** is the **logical backoffice** of NEST: everything that happens **between** "employee taps Send on the phone" and "employee sees the result on the phone." It is **not** a separate app—it is the **pipeline** implemented by **server + CLI runners + integrations**.

---

## Actors

| Actor | Role |
|-------|------|
| **Employee (PWA)** | Sends requests, specs, voice; receives streams and final answers; approves or denies. |
| **Owner / admin** | Sets policies, providers, indexing, auto vs approval, and employee profiles. |
| **Server (Rust)** | Session authority, DB, events, RPC to CLI, permission gates. |
| **CLI runners** | Cursor, Claude Code, Codex, Gemini, OpenCode, KiloCode; **OpenClaw / ZeroClaw** ( **`annie computer` wrappers from June 1, 2026** ) for project/task automation at scale. |
| **LLM providers** | OpenRouter, Vertex, DeepInfra, etc. — keys on server only. |
| **Voice** | ElevenLabs — bridges mic on phone to tool/session actions. |
| **Media services (roadmap)** | Video, image as **task backends** when enabled. |

---

## End-to-End Pipeline (Request → Phone)

### 1. Intake

- **Input:** Text, voice transcript, SSD/spec payload, attachments.
- **Binding:** User id, project id, session id (or new session).
- **Priority / labels** from project defaults.

### 2. Enrichment & Context Build

- **Indexing:** Pull relevant file snippets from the **project index** (token-efficient).
- **Memory bank:** Prior decisions, patterns, glossary — **less repeated explanation**.
- **Employee profile ("soul"):** Role, preferences, past successful patterns (within **privacy/policy** admin sets) so the **multi-agent** layer **understands needs** and automates **safely**.
- **Prompt composer:** Merges system rules + project brief + user message.

### 3. Planning (Optional Swarm / SSD)

- **Swarm / specialists:** Refine prompt, produce checklist, flag risks.
- **Spec-driven development (SSD):** Spec → **task graph** (subtasks, dependencies).
- **Mode split:**
  - **Auto:** Subtasks that pass policy run **without** blocking the user.
  - **Approval:** User sees **prepared plan** or **per-step** gate on the **phone** before execution continues.

### 4. Orchestration

- **Agent backend selection:** Coding agent vs **ZeroClaw/OpenClaw (inside `annie computer` from June 1, 2026)** vs future media agent.
- **Model routing:** OpenRouter / Vertex / DeepInfra per task type and admin caps.
- **Permission mode:** default / accept edits / bypass (rare) / plan — aligned with runner.

### 5. Execution

- **CLI** (or automation host) runs the agent; **stdout, tools, diffs** stream as events.
- **Sensitive tool** → **permission request** → pushed to **PWA** (and voice path if on).

### 6. Media Hooks (Roadmap)

- **Video task:** Job may call video pipeline; **status + artifact URL** stream like code output.
- **Image task:** Similar pipeline; **thumbnail/link** on phone when ready.

### 7. Delivery to the Phone

- **Realtime:** SSE / Socket.IO → session view updates **live** (thinking, tool use, partial text).
- **Final answer:** Consolidated message + **artifacts** (diffs, logs, links to video/image assets).
- **Errors:** Actionable copy + retry path.

---

## How This Supports Your Workforce

| Goal | Console Behavior |
|------|-------------------|
| **Owner control** | All paths respect **server policies** and **audit**. |
| **Remote employees** | Same pipeline whether user is on **4G** or Wi‑Fi. |
| **Save tokens** | Index + memory + summarization **before** big model calls. |
| **Better communication** | Clear **approval cards**, **session threads**, optional **voice**. |
| **Track progress** | Session state machine visible in **dashboard** (admin) and **session list** (user). |

---

## Design Rules

1. **Secrets:** Never ship LLM/voice keys to the mobile client.  
2. **Audit:** Permission grants/denies and high-risk actions logged.  
3. **UX:** **Multitasking** — never block the whole app on one long task.  
4. **Honesty:** If OpenClaw/ZeroClaw (Computer wrappers), SSD, or media are not shipped for your tenant/version yet, UI labels **beta** or **roadmap**.

---

## Related

- [Business README](./README.md)
- [Value Proposition](./value-proposition.md)
- [Use Cases](./use-cases.md)
- [Phases](./phases.md)
- [Enterprise Features](../enterprise/README.md)

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>