# NEST Terminal — Quick Start

Get the NEST Hub running and your first agent session in under 5 minutes.

---

## 1. Install frameworks and tools

Install the runtimes and tools NEST depends on. **Recommended:** follow the full guide for your OS:

- **[Install frameworks & tools](docs/INSTALL-FRAMEWORKS.md)** — Node.js, npm, Docker, Rust (optional), and related tooling.

**Minimum for this quick start:**

- **Node.js 18+** and **npm** — to install the NEST CLI.
- **Docker** and **Docker Compose** — to run the Hub.

```bash
# Check versions
node -v   # v18+
npm -v
docker -v
docker compose version
```

---

## 2. Clone and start the Hub

```bash
git clone https://github.com/Facta-Dev/ctx0_nest_terminal.git
cd ctx0_nest_terminal
cp .env.example .env
```

Edit `.env` and set a strong `CLI_API_TOKEN` (e.g. `openssl rand -hex 32`).

```bash
docker compose up -d
```

The Hub and web app are at **http://localhost:3006** (or your `NEST_LISTEN_PORT`).

---

## 3. Install the NEST CLI

```bash
npm install -g @factadev/cli
nest --help
```

---

## 4. Run your first session

```bash
export CLI_API_TOKEN="paste-the-same-token-from-env"
export NEST_API_URL="http://localhost:3006"
nest
```

Or save the token once: `nest auth login` and enter the same token.

---

## 5. Use the web UI

Open **http://localhost:3006** in your browser. You’ll see your session; you can chat, approve permissions, and control the agent from the PWA or Telegram Mini App.

---

## Next steps

| Goal | Link |
|------|------|
| Full README | [README.md](README.md) |
| Install Rust, Node, Docker, etc. | [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) |
| What’s shipped and versions | [RELEASES.md](RELEASES.md) |
| Roadmap (Souls, multi-agents, Forge) | [ROADMAP.md](ROADMAP.md) |

---

*Powered by [facta.dev](https://facta.dev).*
