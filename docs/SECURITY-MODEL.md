<p align="center">
  <img src="../public/nest_logo.png" alt="NEST" width="160"/>
</p>

# NEST — Security Model

**By Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.

This document describes the security and data-residency posture of a **self-hosted** NEST deployment. It is informational and not a substitute for your own security review — see the *Important notice* in the [README](../README.md).

> Reporting a vulnerability? See [SECURITY.md](../SECURITY.md).

---

## 1. Data residency — your data never leaves your perimeter

NEST is deployed on **infrastructure you own** (cloud, on-prem, or air-gapped). The server, web app, and PostgreSQL database all run inside your boundary.

- **Context Zero does not operate your server** and has **no inbound access** to it.
- Employee machines (the `annie` CLI) and browsers (the PWA) connect **outbound** to the endpoints **you** configure — your DNS, your TLS certificates, your tokens.
- Model providers are reached with **your** API keys (BYOK). Prompts and completions flow between your hub and the providers **you** choose.

## 2. Encryption

- **At rest:** sensitive fields are encrypted with **AES-GCM** using a configurable `ENCRYPTION_KEY`.
- **Strict-by-default decryption:** the server fails closed rather than returning plaintext when decryption cannot be verified.
- **In transit:** run the hub behind TLS (see [DEVOPS.md](DEVOPS.md)); the CLI and PWA connect over HTTPS/WSS to the URL you configure.

## 3. Authentication & isolation

- **JWT** authentication for the web app and CLI.
- A shared secret (`CLI_API_TOKEN`) authenticates the CLI ↔ server channel, with **namespace isolation** for multi-tenant separation (`CLI_API_TOKEN:<namespace>`).
- **Per-project RBAC** (owner / admin / member / viewer) and **granular approval flows** — agents surface permission requests that a human accepts or rejects.

## 4. Audit trail

Every session, message, and action is persisted to **PostgreSQL** as a full audit log — the system of record for *who ran what, when, and what the agent did*. Approvals, terminal output, file changes, and git operations are all attributable.

## 5. Secrets & operations

- `setup.sh` generates all secrets (`CLI_API_TOKEN`, `ENCRYPTION_KEY`, database credentials) into `.env` on first run — **keep `.env` out of version control** (it is git-ignored).
- Rotate keys and purge history per your policy; the platform supports key rotation procedures.
- Update images with `docker compose pull && docker compose up -d`.

## 6. What Context Zero can and cannot do

| | Self-hosted (default) |
|---|---|
| Operates your server | ❌ No |
| Inbound/admin access to your install | ❌ No (unless you separately contract managed services) |
| Receives your prompts / data | ❌ No |
| Your users join the hub outbound | ✅ Yes — to endpoints you configure |

---

## Reporting

Found a security issue? Please **do not** open a public issue. Follow [SECURITY.md](../SECURITY.md) or email **caro@ctx0.io**.

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub).*
