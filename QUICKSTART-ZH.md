<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-加入-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-加入-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — 快速入门

[English](./QUICKSTART.md) | [Español](./QUICKSTART-ES.md) | **中文** | [Deutsch](./QUICKSTART-DE.md) | [Português](./QUICKSTART-PT.md) | [Français](./QUICKSTART-FR.md)

**Context Zero 出品。** 自托管劳动力自动化平台 — 企业级。
从零到可用的 AI 劳动力中枢，不到 5 分钟。

---

## 开始之前 — 完成后你将拥有什么

在接下来的约 5 分钟里，你将：

1. ✅ 用**一条命令**在本地部署 NEST 服务器（Rust + Postgres + nginx）
2. ✅ 在任意机器上安装 `annie` CLI
3. ✅ 启动第一个真实的 AI agent 会话（Claude Code、Codex、Cursor、Gemini、OpenCode 或 KiloCode；自 **2026 年 6 月 1 日**起 ZeroClaw / OpenClaw **经 `annie computer`**）
4. ✅ 在**浏览器**里实时查看 — 手机上也可以

无需事先会 Rust。无需云账号。无需信用卡。只要你的机器能跑 Docker，NEST 就能跑。

---

## 第 0 步 — 前置条件（若尚未具备，约 2 分钟）

需要三样东西，逐项检查：

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**四项都通过？** 跳到第 1 步。

**缺了什么？** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — 在 Mac、Linux 或 Windows 上几分钟内安装 Node、npm 和 Docker。

> **为什么需要这些？** Node + npm 驱动你要装在员工机器上的 `annie` CLI。Docker 负责跑 server，你不必自己安装 Rust、Postgres 或 nginx。

---

## 第 1 步 — 部署 Hub（约 60 秒）

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

就这样。`setup.sh` 会自动生成所有密钥、拉取 Docker 镜像、启动栈并等待健康检查。当你看到：

```
=== NEST ready ===
  Web:  http://localhost
```

Hub 已就绪。在浏览器里打开 — 手机上也可以。

> **刚才发生了什么？** `setup.sh` 创建了带自动生成 `POSTGRES_PASSWORD`、`CLI_API_TOKEN` 和 `ENCRYPTION_KEY` 的 `.env`。随后拉取并启动了四个容器：`nest-server`（Rust）、`nest-web`（React PWA）、`postgres` 和 `nginx`。

---

## 第 2 步 — 在任意机器上安装 CLI（约 30 秒）

`annie` CLI 是员工（或你）在运行 AI agent 的机器上要装的东西。全局安装：

```bash
npm install -g @contextzero/nest
```

确认可用：

```bash
annie --help
```

应能看到完整命令列表。此机器上的 CLI 已就绪。

> **每台机器装一次。** 每个要跑 agent 会话的人都需要在自己的机器上安装 `annie`，并指向你的 server。

---

## 第 3 步 — 连接到你的 Server（约 30 秒）

两种方式 — 任选其一：

**选项 A：环境变量（适合脚本和 CI）**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **Token 在哪？** `setup.sh` 已写入 `.env`。执行：`grep CLI_API_TOKEN .env` 查看。

**选项 B：交互式登录（永久保存凭据）**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

验证连接：

```bash
annie auth status
```

应能看到 server URL 和已确认的 token。**你已认证成功。**

---

## 第 4 步 — 启动第一个 Agent 会话

选择你的 agent，执行一条命令（包 **`@contextzero/nest`** → **`annie`**）。**企业级参考：** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md)。

| Agent | 命令 | 说明 |
|-------|------|------|
| **Claude Code** | `annie claude` | Anthropic 旗舰编程 agent |
| **Codex** | `annie codex` | OpenAI 代码执行 agent |
| **Cursor** | `annie cursor` | Cursor IDE agent 模式 |
| **Gemini** | `annie gemini` | Google 多模态 agent |
| **OpenCode** | `annie opencode` | 开源编程 agent |
| **KiloCode** | `annie kilocode` | 任务执行 + 远程控制 |
| **Computer（管理）** | `annie computer` | Hub 上的多工具 agent（shell、浏览器、文件） |

> **ZeroClaw / OpenClaw：** 自 **2026 年 6 月 1 日**起在 **`annie computer`** 内以包装器形式提供（与 Claude、Cursor 等相同方式）。不是独立的 `annie` 子命令。见 [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) 与 [RELEASES.md](RELEASES.md)。

**自动化：** 若第一个参数不是已知子命令，调用会按 **`annie cursor`** 处理。在 CI 中请始终使用 `annie claude`、`annie computer` 等。

示例 — 启动 Claude Code：

```bash
annie claude
```

终端会显示会话连接与流式输出。**不要关闭此终端。** Agent 正在运行。

---

## 第 5 步 — 你的「顿悟」时刻 🎯

切换到浏览器（或手机）并打开：

```
http://localhost
```

**此时你应在 dashboard 中看到实时会话。**

由此你可以：
- 💬 与运行中的 agent **实时对话**
- ✅ **批准或拒绝** agent 的权限请求
- 🖥️ **观看终端**输出随其执行滚动
- 📱 **在手机上完成上述一切** — PWA 可在任意移动浏览器使用

就是这一刻。你把某人笔记本上跑的 CLI 会话，变成了可从任意地点监控的**远程可见、可审批、可审计的 AI 会话**。

---

## 速查 — 最常用命令

```bash
annie claude            # Claude Code 会话
annie codex             # Codex 会话
annie cursor            # Cursor agent
annie gemini            # Gemini 会话
annie opencode          # OpenCode 会话
annie kilocode          # KiloCode 会话
annie computer          # 多工具管理 agent
annie worker start      # 后台 worker
annie worker list       # 活跃 worker 会话
annie auth login        # 交互保存凭据
annie auth status       # 认证状态
annie diagnose          # 诊断
```

**Server 管理（在 `nest_hub/` 目录下）：**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## 刚才做了什么 — 以及为何重要

你现在拥有：

| 能力 | 位置 | 意义 |
|------|------|------|
| 实时会话 dashboard | 浏览器 / 手机 | 实时查看团队运行的每个 agent 会话 |
| 审批工作流 | Mobile PWA | 高风险操作前 agent 等待你的确认 |
| 完整审计日志 | 你的 PostgreSQL | 每条消息、每个动作都持久化在你的 server |
| 多 agent 支持 | 任意员工机器 | Claude Code、Codex、Cursor、Gemini、OpenCode、KiloCode，以及 **Computer**（**2026 年 6 月 1 日**起 ZeroClaw / OpenClaw 包装器）— 同一 hub |
| 零月费 | 你的基础设施 | Server、数据、密钥都由你掌控 |

> **想深入？** 可阅读：
> - [Business Overview](docs/business/README.md) — 面向创始人的战略价值
> - [Value Proposition](docs/business/value-proposition.md) — 详细收益
> - [Methodology](docs/methodology/README.md) — 实施指南
> - [Enterprise Features](docs/enterprise/README.md) — 规模化组织

---

## 下一步

| 你想做的事 | 前往 |
|------------|------|
| 在真实 server 上部署并启用 HTTPS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| 配置 LLM 密钥（Vertex、OpenRouter、DeepInfra、ElevenLabs…） | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| 增加更多员工机器 | 分享本文档 + 你的 `NEST_API_URL` + token |
| 了解 OpenClaw / ZeroClaw agent 模式 | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| 面向创始人的商业价值 | [docs/business/README.md](docs/business/README.md) |
| 实施方法论 | [docs/methodology/README.md](docs/methodology/README.md) |
| 完整环境变量说明 | [README.md](README.md) |
| 路线图 | [ROADMAP.md](ROADMAP.md) |
| 更新日志 | [RELEASES.md](RELEASES.md) |

---

## 故障排除 — 快速处理

| 问题 | 处理 |
|------|------|
| 安装后找不到 `annie` | 再执行一次 `npm install -g @contextzero/nest`；检查 `$PATH` |
| Web 白屏 / 无法加载 | 等待约 30 秒完成 DB 初始化；执行 `docker compose logs nest-server` |
| CLI 报 `401 Unauthorized` | Token 不一致 — `setup.sh` 会自动生成。执行 `grep CLI_API_TOKEN .env` 查看你的 token。 |
| 端口 80 已被占用 | 在 `.env` 中设置 `WEB_PORT=8080`，然后 `docker compose restart` |
| Dashboard 中看不到会话 | 确认 CLI 中的 `NEST_API_URL` 指向正确的 server 地址 |
| 其他问题 | 执行 `annie diagnose` — 会输出完整诊断报告 |

---

> **你正在运行企业级 AI 劳动力 hub。免费。在自己的基础设施上。**
> 
> 准备好更进一步 — HTTPS、多团队、自定义 LLM 路由 — 详见 [docs/DEVOPS.md](docs/DEVOPS.md) 与 [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md)。

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*公开发布：[contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI：[@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)。*

</div>
