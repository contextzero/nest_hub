# Security Policy

## Reporting a Vulnerability

If you discover a (suspected) security vulnerability in NEST, please report it **privately**. Do not open a
public GitHub issue.

- **Preferred:** open a [GitHub Security Advisory](https://github.com/contextzero/nest_hub/security/advisories/new).
- **Alternative:** reach the maintainers privately via [Discord](https://discord.gg/ygjuuDAw) or
  [Telegram](https://t.me/ctx0_io).

We will acknowledge your report, investigate, and coordinate a fix and disclosure timeline with you.

## Self-hosted hardening

NEST connects real agents to real infrastructure. Treat **CLI tokens** (`CLI_API_TOKEN`), **encryption keys**
(`ENCRYPTION_KEY`), **hub URLs**, and **inbound webhooks** as sensitive:

- Rotate `CLI_API_TOKEN` on any suspected compromise.
- Prefer HTTPS everywhere and scope permission modes per employee and project.
- Keep the database internal-only (the default `docker-compose.yml` does not expose PostgreSQL).

Read [docs/DEVOPS.md](docs/DEVOPS.md) before exposing the stack to the internet.
