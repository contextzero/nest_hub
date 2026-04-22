<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Install Frameworks & Tools

**By Context Zero.** Everything you need to run NEST — Node.js, npm, Docker, and optionally Rust — installed correctly in minutes. Follow this guide once, then go straight to the [Quick Start](../QUICKSTART.md).

---

## What You're Installing and Why

Before you copy a single command, here's the full picture — so you know exactly what each tool does and whether you actually need it:

| Tool | Why You Need It | Required? |
|------|----------------|-----------|
| **Node.js 18+** | Runtime for the `annie` CLI — this is what makes `annie` work on any machine | ✅ Yes — every machine running agents |
| **npm** | Installs `annie` globally via `npm install -g @contextzero/nest` | ✅ Yes — comes with Node.js |
| **Docker** | Runs the NEST server stack (Rust server + Postgres + nginx) without building anything from source | ✅ Yes — the machine hosting the server |
| **Docker Compose** | Wires the server containers together with one command | ✅ Yes — included with Docker Desktop |
| **Rust** | Only needed if you want to build the server from source or contribute to the Rust codebase | ❌ Optional |
| **Bun** | Only needed if you're developing or building the server from the main NEST repo | ❌ Optional |

**The most common setup:** Docker on the server machine (yours or a VPS), Node.js + npm on each employee's machine. That's it.

---

## Node.js and npm

The `annie` CLI runs on Node.js. Install the LTS version — Node 18 or 20.

### macOS / Linux — Recommended: nvm

`nvm` (Node Version Manager) lets you install and switch Node versions without `sudo`. It's the cleanest approach on any Unix-based system.

```bash
# Step 1: Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Step 2: Restart your terminal (or run the export lines nvm prints after install)

# Step 3: Install Node 20 LTS
nvm install 20
nvm use 20

# Step 4: Verify
node -v   # Should print v20.x.x
npm -v    # Should print 10.x or higher
```

> **Why nvm instead of a system install?** System Node installs often require `sudo` for global npm packages — which causes permission errors when running `npm install -g @contextzero/nest`. nvm installs Node in your home directory, so global installs work without elevated permissions.

### Windows

**Option A — Installer (simplest):**
Download the LTS installer from [nodejs.org](https://nodejs.org/) and run it. Node and npm are installed together.

**Option B — nvm-windows (recommended if you manage multiple projects):**
Download and run the installer from [nvm-windows releases](https://github.com/coreybutler/nvm-windows/releases), then:

```powershell
nvm install 20
nvm use 20
node -v
npm -v
```

### Verify — Both Platforms

```bash
node -v   # v18.x or v20.x
npm -v    # 9.x or higher
```

If both commands print version numbers, Node and npm are ready. Move to the next section.

---

## Docker and Docker Compose

Docker runs the NEST server stack — the Rust API, PostgreSQL, and nginx — without you needing to install or configure any of those individually. One command starts everything.

Docker Compose is what makes that one command work. It's included with Docker Desktop on Mac and Windows. On Linux, it's a plugin installed alongside Docker.

### macOS

1. Download [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)
2. Open the `.dmg`, drag Docker to Applications, and launch it
3. Wait for the Docker menu bar icon to show "Docker Desktop is running"

```bash
# Verify
docker --version         # Docker version 24.x or higher
docker compose version   # Docker Compose version v2.x
```

> **Important:** Use `docker compose` (with a space, V2 syntax) — not `docker-compose` (hyphenated, V1). NEST uses V2.

### Linux (Ubuntu / Debian)

```bash
# Step 1: Update and install Docker
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin

# Step 2: Add your user to the docker group (avoids needing sudo for every command)
sudo usermod -aG docker $USER

# Step 3: Apply group change — log out and back in, or run:
newgrp docker

# Step 4: Verify
docker --version
docker compose version
```

**Other Linux distributions:** Follow the official [Docker Engine install guide](https://docs.docker.com/engine/install/) for your distro — Fedora, CentOS, RHEL, Arch, and others are all covered there.

### Windows

1. Download [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
2. Run the installer — it enables WSL 2 automatically if needed
3. Launch Docker Desktop and wait for "Docker Desktop is running"

```powershell
# Verify in PowerShell or Windows Terminal
docker --version
docker compose version
```

### Verify — All Platforms

```bash
docker --version         # Docker version 24.x or higher
docker compose version   # Docker Compose version v2.x or higher
```

Both print version numbers? Docker is ready. You can now run `docker compose up -d` from the `nest_hub` directory and the full NEST stack starts.

---

## Rust — Optional

You do **not** need Rust to run NEST. The server is distributed as a public Docker image — you pull and run it, no compilation required.

Install Rust only if you want to:
- Build the NEST server from source
- Contribute to the Rust codebase
- Inspect or modify the server architecture

### Install

```bash
# macOS / Linux
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Follow the on-screen prompts (default install is fine)
# Then apply the PATH change:
source "$HOME/.cargo/env"

# Verify
rustc --version   # rustc 1.7x.x
cargo --version   # cargo 1.7x.x
```

**Windows:** Download and run [rustup-init.exe](https://rustup.rs/) — it handles everything including the MSVC build tools.

### NEST Rust server — beyond Docker (optional)

For **self-hosted deployments**, run the server from the **published Docker image** (`matiasbaglieri/nest-server`) using `docker compose` in this repo — no local Rust build required.

If you compile a **custom or vendor-specific** server binary, keep your own source checkout and build runbook with your team. This public distribution documents **Docker + npm (`@contextzero/nest`) + `nest_hub`** only.

```bash
# Typical path — Compose in nest_hub (recommended)
cd nest_hub
docker compose pull && docker compose up -d
```

See [RELEASES.md](../RELEASES.md) for components and [DEVOPS.md](DEVOPS.md) for production operations.

---

## Bun — Optional

Bun is only needed for some **local JavaScript tooling** workflows. **It is not required** for deploying or operating NEST with Docker and the `annie` CLI from npm.

```bash
# macOS / Linux
curl -fsSL https://bun.sh/install | bash

# Restart terminal, then verify
bun --version   # 1.x.x
```

**Windows:** [Bun for Windows](https://bun.sh/docs/installation#windows) via npm or WinGet.

---

## Checklist — Before You Go to Quick Start

Run through this before opening [QUICKSTART.md](../QUICKSTART.md). Every box checked means a smooth setup.

```bash
# On the server machine (the one running Docker):
docker --version          # ✅ v24+
docker compose version    # ✅ V2 syntax (space, not hyphen)

# On every employee machine (the ones running annie):
node -v                   # ✅ v18.x or v20.x
npm -v                    # ✅ 9.x+

# Optional — only if you compile a custom server locally:
rustc --version           # ✅ 1.7x+
bun --version             # ✅ 1.x+   # only if your own tooling needs it
```

All green? Head to the [Quick Start →](../QUICKSTART.md)

---

## Common Issues

| Problem | Fix |
|---------|-----|
| `npm install -g` fails with permission error | You're using a system Node install. Switch to nvm — it installs Node in your home directory and fixes this entirely. |
| `docker compose` not found (but `docker-compose` works) | You have Docker Compose V1. Update Docker Desktop, or install `docker-compose-plugin` on Linux. NEST uses V2 syntax. |
| `docker: command not found` after install on Linux | Log out and back in so the PATH changes take effect, or run `source ~/.bashrc`. |
| `docker` requires sudo on Linux | You haven't been added to the `docker` group yet. Run `sudo usermod -aG docker $USER`, then log out and back in. |
| `rustup` install fails on Windows | You need the [MSVC C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/). `rustup-init.exe` will prompt you to install them. |

---

*After this guide, continue with: [QUICKSTART.md](../QUICKSTART.md) · [INSTALL.md](INSTALL.md) · [README.md](../README.md)*

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Public distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>