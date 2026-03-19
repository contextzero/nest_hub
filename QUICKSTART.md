# NEST Terminal — Quick Start

Get the NEST Server running and your first agent session in a few minutes using **public Docker images**.

---

## 1. Install tools

- **Node.js 18+** and **npm** — for the NEST CLI.
- **Docker** and **Docker Compose** — for the server.

Check:

```bash
node -v   # v18+
npm -v
docker -v
docker compose version
```

Full guide: [Install frameworks & tools](docs/INSTALL-FRAMEWORKS.md).

---

## 2. Start the Server (public images)

```bash
git clone https://github.com/ctx0/ctx0_nest_terminal.git
cd ctx0_nest_terminal
cp .env.example .env
```

Edit `.env` and set **CLI_API_TOKEN** (e.g. `openssl rand -hex 32`).

```bash
docker compose up -d
```

Web app and API: **http://localhost** (port 80).

---

## 3. Install the NEST CLI

```bash
npm install -g @ctx0/nest
nest --help
```

---

## 4. Run your first session

```bash
export CLI_API_TOKEN="same-as-in-env"
export NEST_API_URL="http://localhost"
nest
```

Or save the token once: **`nest auth login`** and enter the same token.

---

## 5. Use the web UI

Open **http://localhost** in your browser. You'll see your session; chat, approve permissions, and control the agent from the PWA or Telegram Mini App.

---

## Next steps

| Goal | Link |
|------|------|
| Full install guide | [docs/INSTALL.md](docs/INSTALL.md) |
| README (overview, config) | [README.md](README.md) |
| Install Node, Docker, etc. | [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) |
| Releases and versions | [RELEASES.md](RELEASES.md) |
| Roadmap & enterprise | [ROADMAP.md](ROADMAP.md) |
