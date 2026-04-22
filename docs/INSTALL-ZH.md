<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

[English](./INSTALL.md) | [Español](./INSTALL-ES.md) | **中文** | [Deutsch](./INSTALL-DE.md) | [Português](./INSTALL-PT.md) | [Français](./INSTALL-FR.md)

# NEST — 完整安装指南

**Context Zero 出品。** 自托管劳动力自动化平台 — 企业级。

本指南使用公共 Docker 镜像，让完整的 NEST 栈（服务器、数据库、Web 应用与 CLI）跑起来。无需 Rust、无需从源码构建、也无需云账号。

> **赶时间？** → [QUICKSTART.md](../QUICKSTART.md) 只需约 5 分钟完成核心步骤。  
> 本指南为完整参考 — 涵盖所有选项、所有参数与排错路径。

---

## 将安装哪些内容

| 组件 | 如何获得 | 作用 |
|-----------|---------------|--------------|
| **NEST Server** | Docker 拉取 `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker 拉取 `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker 拉取 `postgres:16-alpine` | 在命名卷中持久化所有 session、消息与审计事件 |
| **nginx** | Docker 拉取 `nginx:alpine` | 在 80 端口作为单一入口 — 路由 `/api/*`、`/ws/*`、SSE 与 PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | 在员工机器上运行 agent session；连接到你的服务器 |

**零编译。** Docker 拉取预构建的服务器镜像。`npm` 拉取预构建的 CLI。在任意装有 Docker 与 Node 的机器上，整个栈可在约 2 分钟内运行。

---

## 前置条件

两台机器，两类要求：

| 机器 | 需要 |
|---------|-------|
| **服务器机器**（托管栈） | Docker + Docker Compose |
| **员工机器**（运行 agent） | Node.js 18+ 与 npm |

在搭建阶段，服务器与员工可以是同一台机器 — 这是常见的本地开发流程。

**还没有这些环境？** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) 涵盖各操作系统。

---

## 第一部分 — 服务器设置

### 步骤 1.1 — 克隆并运行安装脚本

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

安装脚本会生成安全的 `CLI_API_TOKEN`、创建 `.env` 并启动完整栈。按提示操作 — 全程通常不到 2 分钟。

完成后在浏览器打开 **http://localhost**。应能看到 NEST Web 应用。若能加载 — 说明服务器已就绪。

### 步骤 1.2 — 确认服务器在运行

```bash
docker compose ps
```

四个容器应显示为 `Up` 或 `healthy`：

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

查看启动日志：

```bash
docker compose logs -f
```

当看到 nest-server 健康检查通过即可。日志中类似：

```
nest-server  | Server listening on 0.0.0.0:3000
```

### 进阶：手动配置

若希望不用 `./setup.sh`、手动配置 `.env`：

```bash
cp .env.example .env
```

用任意文本编辑器打开 `.env`。必须设置的只有 `CLI_API_TOKEN`：

```env
# REQUIRED — shared secret between CLI and server
# Generate a strong one: openssl rand -hex 32
CLI_API_TOKEN=your-strong-secret-here

# Optional — change if port 80 is in use on your machine
WEB_PORT=80

# Optional — change the default Postgres password (recommended for production)
POSTGRES_PASSWORD=changethis

# Optional — expose Postgres on the host for backups or admin tools
# Set to empty to keep it internal only
PGPORT=5433

# Optional — set for production HTTPS deployments
# NEST_PUBLIC_URL=https://nest.yourdomain.com

# Optional — Telegram bot integration
# TELEGRAM_BOT_TOKEN=your-telegram-token
```

**本地可用的最小 `.env`：**

```env
CLI_API_TOKEN=paste-your-generated-token-here
```

其余项对本地部署均有合理默认值。

> **安全提示：** `CLI_API_TOKEN` 是团队 CLI 连接服务器的唯一密钥。请用 `openssl rand -hex 32` 生成。切勿将 `.env` 提交到版本库。

然后启动栈：

```bash
docker compose up -d
```

首次运行会拉取四个镜像（视网络约 1–2 分钟）。之后启动会很快。

---

## 第二部分 — CLI 设置

在**每一台**需要员工运行 agent session 的机器上执行。

### 步骤 2.1 — 安装

```bash
npm install -g @contextzero/nest
```

验证：

```bash
annie --help
```

应看到完整命令列表。若提示找不到 `annie`，见下文 [常见问题](#common-issues)。

### 步骤 2.2 — 连接到你的服务器

两种方式：

**方式 A — 交互式登录（持久保存，推荐）**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

凭据写入 `~/.nest/config`。之后每次 `annie` 命令会自动使用 — 无需每次设置环境变量。

**方式 B — 环境变量（适合 CI/CD 或脚本）**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**验证连接：**

```bash
annie auth status
```

应打印服务器 URL 并确认 token 已设置。若报错，见 [常见问题](#common-issues)。

### 步骤 2.3 — 启动第一个 agent session

包：**`npm install -g @contextzero/nest`** → **`annie`**。完整命令说明：[enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md)。

```bash
annie claude     # Claude Code — Anthropic 编程 agent
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini（经 ACP）
annie opencode   # OpenCode — 开源 agent
annie kilocode   # KiloCode — 任务执行与审批控制
annie computer   # Computer — hub 上的多工具管理 agent（shell、浏览器、文件）
```

**自动化：** 若第一个参数不是已知子命令，CLI 会按 **`annie cursor`** 处理。在脚本与 CI 中请始终写显式子命令（`annie claude`、`annie computer` 等）。

**ZeroClaw / OpenClaw** 自 **2026 年 6 月 1 日**起在 **`annie computer`** 内以 **包装器（wrapper）** 形式提供（与 Claude、Cursor 等相同集成方式）— 不是独立的 `annie` 子命令。见 [enterprise/zeroclaw.md](enterprise/zeroclaw.md) 与 [RELEASES.md](../RELEASES.md)。

Session 启动后，在浏览器（或手机）打开 **http://localhost**。Dashboard 会实时显示该 session。

---

## 端口说明

| 主机端口 | 服务 | 说明 |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | 在 `.env` 中用 `WEB_PORT` 修改 |
| `5433` | PostgreSQL (optional host exposure) | 设 `PGPORT=`（空）则仅内部可访问 |

所有 API、Socket.IO 与 SSE 均经 nginx 的 80 端口。基本使用无需再开其他端口。

---

## 服务器管理命令

在 `nest_hub/` 目录下执行：

```bash
# Start the stack (detached)
docker compose up -d

# Stop the stack (preserves data in Postgres volume)
docker compose down

# Stop and delete all data (destructive — removes the Postgres volume)
docker compose down -v

# Stream all logs
docker compose logs -f

# Stream logs for a specific container
docker compose logs -f nest-server

# Check container status
docker compose ps

# Restart after .env changes
docker compose restart

# Pull latest images and restart
docker compose pull && docker compose up -d
```

---

<h2 id="common-issues">常见问题</h2>

| 现象 | 原因 | 处理 |
|---------|-------|-----|
| `annie: command not found` | npm 全局 bin 不在 PATH | 运行 `npm bin -g` 找到路径并加入 `$PATH`。或使用 nvm — 见 [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| CLI 返回 `401 Unauthorized` | Token 不一致 | 确认 `.env` 中的 `CLI_API_TOKEN` 与 `~/.nest/config` 或 `export` 的值完全一致。无引号、无多余空格 |
| Web 空白 / 502 Bad Gateway | 服务仍在启动 | 等待约 30 秒后执行 `docker compose logs nest-server`，查找健康检查通过的那一行 |
| 80 端口已被占用 | 其他服务占用 80 | 在 `.env` 中设置 `WEB_PORT=8080`，然后 `docker compose restart` |
| 找不到 `docker compose` | 仍为 Docker Compose V1 | 更新 Docker Desktop，或安装 `docker-compose-plugin`。NEST 使用 V2（`docker compose`，不是 `docker-compose`） |
| Postgres 连接错误 | 数据库仍在初始化 | 首次初始化约需 10 秒。等待后重试。用 `docker compose logs postgres` 查看日志 |
| Dashboard 中看不到 session | `NEST_API_URL` 错误 | `annie auth status` 中的 URL 须与实际服务器地址一致（从其他机器连接时不能用错误的 `localhost`） |

**仍无法解决？** 在安装了 CLI 的机器上运行 `annie diagnose`。会输出完整的连通性与认证诊断报告。

---

## 生产部署

面向公网的 NEST（远程团队、HTTPS、自定义域名）：

1. 在 `.env` 中设置 `NEST_PUBLIC_URL=https://nest.yourdomain.com`
2. 在 nginx（或其前的负载均衡）上配置 TLS 终结
3. 使用强 `POSTGRES_PASSWORD`，并保持 `PGPORT` 为空（不要将 Postgres 暴露到公网）
4. 用 `openssl rand -hex 32` 轮换 `CLI_API_TOKEN` — 然后让所有员工 CLI 执行 `annie auth login` 更新

完整生产参考：[DEVOPS.md](DEVOPS.md)

---

## 后续步骤

| 你想做的事 | 前往 |
|---------------------|-------------|
| 5 分钟快速搭建摘要 | [QUICKSTART.md](../QUICKSTART.md) |
| 安装 Node、Docker、Rust | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| 配置 LLM 密钥（Vertex、OpenRouter、DeepInfra…） | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| 生产、HTTPS、公网 URL | [DEVOPS.md](DEVOPS.md) |
| 面向创始人的商业价值 | [business/README.md](business/README.md) |
| 实施方法论 | [methodology/README.md](methodology/README.md) |
| 企业功能 | [enterprise/README.md](enterprise/README.md) |
| 全部命令与配置参考 | [README.md](../README.md) |
| 后续规划 | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*公开发布：[contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI：[@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)。*

</div>
