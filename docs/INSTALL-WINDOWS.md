<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

</div>

# NEST on Windows (WSL2 + Docker Desktop)

This guide documents the shortest supported Windows path for self-hosting NEST:
run the stack inside **WSL2**, use **Docker Desktop** as the container runtime,
and open the PWA at `http://localhost`.

## What You Need

- Windows 11, or Windows 10 with WSL2 support
- Docker Desktop for Windows
- A WSL2 Linux distro such as Ubuntu
- Git inside WSL2

## 1. Enable WSL2

In an elevated PowerShell window:

```powershell
wsl --install
```

If WSL is already installed, confirm the version:

```powershell
wsl -l -v
```

Make sure your Linux distro shows **Version 2**.

## 2. Install Docker Desktop

1. Download and install [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/).
2. In Docker Desktop, enable **Use the WSL 2 based engine**.
3. In **Settings → Resources → WSL Integration**, enable integration for the distro you will use for NEST.

Verify from your WSL shell:

```bash
docker --version
docker compose version
```

## 3. Clone the Repository in WSL2

Open your WSL terminal and clone NEST into the Linux filesystem:

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
```

Using the WSL filesystem is recommended for better bind-mount and file-watch behavior than `/mnt/c/...`.

## 4. Run the Setup Script

From the repo root:

```bash
./setup.sh
```

`setup.sh` creates `.env`, pulls the published images, starts the stack, and
waits for health checks.

When setup finishes, open:

```text
http://localhost
```

If you changed `WEB_PORT` in `.env`, use that port instead.

## 5. Day-2 Commands

Run these from the repo root in WSL2:

```bash
docker compose up -d
docker compose down
docker compose logs -f
docker compose pull && docker compose up -d
```

## Troubleshooting

- If `docker` is missing in WSL2, re-check Docker Desktop WSL integration for your distro.
- If `./setup.sh` is not executable, run `chmod +x setup.sh`.
- If `http://localhost` does not load, inspect `docker compose ps` and `docker compose logs -f`.
- If another service already uses port 80, set `WEB_PORT=8080` in `.env`, then run `docker compose up -d`.

## Related Docs

- [Quick Start](../QUICKSTART.md)
- [Install frameworks and tools](INSTALL-FRAMEWORKS.md)
- [Installation reference](INSTALL.md)
- [Production deploy (HTTPS)](DEVOPS.md)
