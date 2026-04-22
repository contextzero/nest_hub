<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**自托管劳动力自动化平台 — 企业级**
<br/>
<em>你的中心。你的数据。你的AI劳动力。掌中掌控。</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-加入-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-加入-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![Docker](https://img.shields.io/badge/Docker-就绪-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## 什么是 NEST？

**NEST** 是一个完整的、自托管的**劳动力自动化平台**。不仅仅是编程工具——你的员工可以管理机器、处理任务、发送邮件、进行研究、构建产品等。一切都在一个中心。一切都在手机上。

> 你部署：在服务器上运行一个 Docker 命令。
> 你的团队获得：一个实时 AI 劳动力中心，可从任何设备访问——手机、平板、桌面。

### 产品视频

平台体验概览（本仓库中的本地文件）：

[`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

### 四大支柱

| 支柱 | 含义 |
|------|------|
| **企业中心** | 一个应用替代 Slack + Notion + Trello + WhatsApp。项目 → 员工 → 会话。单一事实来源。 |
| **员工移动端** | PWA 适用于任何手机。在公交车上批准部署。无需笔记本电脑。 |
| **记忆库 (Souls)** | 中心学习每位员工的模式。无需每次会话重新解释上下文。智能持续积累。 |
| **代理集群** | 多个专业 AI 代理并行工作——而非一个通才按顺序处理所有事务。 |

---

## 快速开始 — 5分钟上线

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

`setup.sh` 自动生成所有密钥、拉取 Docker 镜像、启动堆栈并等待健康检查。

```
=== NEST ready ===
  Web:  http://localhost
```

在手机上打开。安装 PWA。你的中心已上线。

> **详细指南：** [QUICKSTART.md](QUICKSTART.md)

---

## 支持的代理

| 代理 | 命令 | 描述 |
|------|------|------|
| **Claude Code** | `annie claude` | Anthropic 的旗舰编码代理 |
| **Cursor** | `annie cursor` | Cursor IDE 代理模式 |
| **Codex** | `annie codex` | OpenAI 的代码执行代理 |
| **Gemini** | `annie gemini` | Google 的多模态代理 |
| **OpenCode** | `annie opencode` | 开源编码代理 |
| **KiloCode** | `annie kilocode` | 任务执行 + 远程控制 |
| **Computer（运维）** | `annie computer` | 与 Hub 同步的多工具代理（Shell、浏览器、文件等） |
| **ZeroClaw** | 无头自动化 | 自我纠正的自主任务 |
| **OpenClaw** | 项目编排 | 多步骤工作流 + 浏览器控制 |

\*自 **2026 年 6 月 1 日**起，**ZeroClaw** 与 **OpenClaw** 以 **`annie computer`** 内包装器形式提供（与其它 Computer 代理相同方式）。详见 [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md)。

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer 与裸 `annie`：** 自 **2026 年 6 月 1 日**起，**ZeroClaw** 与 **OpenClaw** 在 **`annie computer`** 内以包装器运行（与 Claude、Cursor、Codex 等相同方式）—见 [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md)。**没有**独立的 `annie zeroclaw` / `annie openclaw` 命令。在脚本与 CI 中请始终使用显式子命令（`annie claude`、`annie computer` 等）。若第一个参数不是已知子命令，CLI 会按 **`annie cursor`** 处理。

### 企业级推广 — CLI（`@contextzero/nest`）

适用于员工使用 **Cursor、Claude Code、Codex、OpenCode 或 KiloCode** 的 **macOS、Windows 与 Linux**。执行 **`npm install -g @contextzero/nest`**（官方 CLI npm 包，命令 **`annie`**）后，即可将各工作站连接到 **你们自有** 的 NEST 实例；Context Zero 不托管你们的自托管中心，也不会接入你们的网络。

**1. 安装 CLI（IT 或员工，需 Node.js LTS + npm）：**

```bash
npm install -g @contextzero/nest
annie --version
```

**2. 将机器与你们的 Hub 绑定**

每个用户配置文件执行一次（或通过 MDM / 密钥库自动化，使用与 `annie auth login` 相同的持久化变量）：

```bash
annie auth login
```

系统将提示输入**部署基址 URL**（例如由贵司签发的 `https://nest.yourcompany.com`）以及管理员在服务器上生成的 **CLI API 令牌**。验证连接：

```bash
annie auth status
```

**3. 登录后的常用入口**

| 界面 | 命令 | 用途 |
|------|------|------|
| **Claude Code** | `annie claude` | Claude Code 会话 |
| **Cursor** | `annie cursor` | Cursor IDE 代理模式 |
| **Codex** | `annie codex` | Codex 会话（若支持则 `annie codex resume <id>`） |
| **Gemini** | `annie gemini` | Gemini 会话 |
| **OpenCode** | `annie opencode` | OpenCode 会话 |
| **KiloCode** | `annie kilocode` | KiloCode 任务执行 |
| **Computer** | `annie computer` | 多工具运维代理（Shell、浏览器、文件、进程等） |
| **MCP 桥接** | `annie mcp` | 指向 Hub 的 stdio MCP（HTTP 目标 + 令牌） |
| **Worker** | `annie worker start` · `list` · `stop-session <id>` | 与 Hub 关联的后台任务 |
| **Hub 终端** | *（PWA ↔ 服务器 ↔ CLI 内 PTY）* | 供运维使用的远程 Shell（高权限面） |

仅通过**贵公司域名与身份体系**分发 URL 与令牌。员工应通过**你们控制的链接**（内网、MDM 或品牌下载页）安装 **PWA 或客户端**，并使用手机、平板或桌面进行审批、会话监控与审计——勿在租户外共享凭据。

**延伸阅读：** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — 完整能力面：各 IDE 代理、**`annie computer`**、**远程 PTY 终端**、Worker、MCP、诊断；不链接私有源码仓库。

**自动化提示：**若第一个参数不是已注册的子命令，CLI 会按 **`annie cursor`** 解析。在 CI 中务必写全子命令（如 `annie claude`、`annie computer`）。

---

## 社区

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-加入服务器-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

---

## 重要说明 — 自托管部署、责任与访问

以下为面向客户与运维人员的**一般性信息提示**。**不构成**针对贵司的个性化法律意见；请由法律顾问结合合同、司法辖区与监管义务审阅。

**使用与合规。**贵组织——**而非** Context Zero Inc.（含其关联方、承包商或人员，统称「**Context Zero**」）——对如何部署、配置、保障与使用 NEST Hub **单独承担责任**，包括所有 AI 代理输出、集成、数据处理、用工实践、出口管制、隐私、行业法规与内部政策。Context Zero 不监管贵司的运行环境，也不对贵司基础设施上员工、代理或系统所作决定承担责任。

**自托管连接。**当贵司在自有基础设施上以**自托管**方式运行 NEST 时，**Context Zero 不运营该服务器**、不自动获得面向该服务器的管理连接，且**不能**仅因贵司从我方下载或许可材料而访问贵司安装实例。Hub 由贵司用户与工具（例如通过 `@contextzero/nest` 安装的 `annie` CLI）按贵司配置的端点进行**出站**连接（贵司 DNS、TLS 证书、令牌）。除非另行签订明确提供远程管理及访问范围的托管服务合同，否则按本仓库所述自托管产品模式，**Context Zero 团队成员未被授予对贵司服务器的入站访问权限**。

**非代理关系。**本 README 任何内容均不构成合伙、合资或代理关系。Context Zero 为软件供应商；**贵司仍对合法使用、人员治理与部署安全单独承担责任**。

---

**© 2025–2026 Context Zero** — 自托管劳动力自动化平台

<div align="center">

*公开发布：[contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI：[@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)。*

</div>
