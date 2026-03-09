# Install frameworks and tools

This guide covers installing the runtimes and tools used by NEST and the Facta ecosystem: **Node.js**, **npm**, **Docker**, and **Rust** (for the optional Rust backend). Use it to prepare your machine for the [Quick Start](../QUICKSTART.md) or for contributing to NEST.

---

## Overview

| Framework / tool | Used by | Required for |
|------------------|---------|--------------|
| **Node.js 18+** | NEST CLI (runtime), Server (Bun/Node) | CLI and Server |
| **npm** | NEST CLI install | `npm install -g @factadev/cli` |
| **Docker & Compose** | Server in ctx0_nest_terminal | Server deployment |
| **Rust** | NEST Rust server (hexagonal backend) | Optional; future backend |
| **Bun** | Server dev/build in main NEST repo | Optional; build from source |

---

## Node.js and npm

NEST CLI is distributed via npm and runs on Node.js. Use the LTS version (18 or 20+).

### macOS / Linux (recommended: nvm)

```bash
# Install nvm: https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Restart shell, then:
nvm install 20
nvm use 20
node -v
npm -v
```

### Windows

- Download the LTS installer from [nodejs.org](https://nodejs.org/).
- Or use [nvm-windows](https://github.com/coreybutler/nvm-windows).

### Verify

```bash
node -v   # v18.x or v20.x
npm -v
```

---

## Docker and Docker Compose

Required to run the Server with the [ctx0_nest_terminal](https://github.com/Facta-Dev/ctx0_nest_terminal) Docker setup.

### macOS

- [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/) (includes Compose).

### Linux

```bash
# Ubuntu/Debian: see https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
# Log out and back in
docker --version
docker compose version
```

### Windows

- [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/) (includes Compose).

### Verify

```bash
docker --version
docker compose version
```

---

## Rust (optional — NEST Rust server)

The NEST project includes a **Rust server** with hexagonal architecture (domain, ports, application, adapters). It is used for a future backend option and for contributors. You do **not** need Rust to use the CLI or the Docker Server from this repo.

### Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustc --version
cargo --version
```

### Build NEST Rust server (from main NEST repo)

```bash
cd /path/to/nest/server
cargo build --release
```

---

## Bun (optional — build Server from source)

If you build or develop the Server from the [NEST](https://github.com/ctx0/nest) repo, Bun is used for install and build.

```bash
# macOS / Linux
curl -fsSL https://bun.sh/install | bash
bun --version
```

---

## Summary checklist

| Step | Command / link |
|------|-----------------|
| Node.js 18+ | `nvm install 20` or [nodejs.org](https://nodejs.org/) |
| npm | Comes with Node.js |
| Docker | [Docker Desktop](https://docs.docker.com/desktop/) or distro package |
| Docker Compose | Included with Docker Desktop or `docker-compose-plugin` |
| Rust (optional) | `curl -sSf https://sh.rustup.rs \| sh` |
| Bun (optional) | `curl -fsSL https://bun.sh/install \| bash` |

After installing, continue with the [Quick Start](../QUICKSTART.md).

---

*Powered by [facta.dev](https://facta.dev).*
