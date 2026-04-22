<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# 企业级指南 — Annie CLI、MCP 与多客户端集成

[中文](./annie-cli-mcp-enterprise-ZH.md) | [English](./annie-cli-mcp-enterprise.md) | [Español](./annie-cli-mcp-enterprise-ES.md) | [Deutsch](./annie-cli-mcp-enterprise-DE.md) | [Português](./annie-cli-mcp-enterprise-PT.md) | [Français](./annie-cli-mcp-enterprise-FR.md)

本文档是部署 **Annie**（`@contextzero/nest` CLI）、使用**全部已支持命令面**并将 **NEST MCP** 与 ChatGPT、Claude、Cursor、VS Code 集成的**企业级**参考。

**编程语言说明：** NEST 对仓库中的**编程语言**保持**无关性**（Python、TypeScript、Rust、Go、Java、.NET 等）。会话绑定在 **workspace 路径**与**服务器会话 ID**上，而非单一语言运行时。

**文档语言：** 本指南以**六种自然语言**（EN、ES、DE、FR、PT、ZH）发布，每种语言的文件采用**相同的分阶段结构**。

---

## 目录

1. [执行摘要](#1-执行摘要)
2. [阶段模型一览](#2-阶段模型一览)
3. [CTO 工程工作流阶段](#3-cto-工程工作流阶段)
4. [NEST 实施阶段 0–6](#4-nest-实施阶段-06)
5. [MCP 技术成熟度阶段（M1–M4）](#5-mcp-技术成熟度阶段m1m4)
6. [运营推广阶段（P0–P4）](#6-运营推广阶段p0p4)
7. [架构概览](#7-架构概览)
8. [CLI（`@contextzero/nest`）— 命令参考](#section-8-cli-zh)
9. [配置与 URL 规则](#9-配置与-url-规则)
10. [MCP — 协议、安全与端点](#10-mcp--协议安全与端点)
11. [各客户端集成模式](#11-各客户端集成模式)
12. [风险、验证与治理](#12-风险验证与治理)
13. [相关文档](#13-相关文档)

---

## 1. 执行摘要

| 层次 | 回答的问题 |
|------|------------|
| **CTO 工作流** | *如何*在交付前思考（分析 → 设计 → 风险 → 实施） |
| **NEST 0–6** | *何时*将基础设施、智能体与治理落地到组织 |
| **MCP M1–M4** | *如何*使 MCP 从安全的本地文件演进为带认证的服务端代理 + 外部 IDE |
| **Ops P0–P4** | *如何*从试点扩展到生产运营 |

**企业 MCP 不可妥协项**

1. `POST /mcp/sessions/<session_id>` 必须 **URL + Bearer** — 禁止“仅 URL”。
2. **Git 卫生**：`.cursor/mcp.json` 及备份 — 视为本地密钥面。
3. 自动化中使用**显式 CLI 子命令**（如 `annie claude`），避免模糊默认行为。

---

## 2. 阶段模型一览

```
┌─────────────────────────────────────────────────────────────────────────┐
│  CTO 工作流      分析 → 设计 → 风险 → 实施                                  │
│       │                     （持续进行；每个 NEST 阶段设门控）              │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6        发现 → … → 运营        （平台生命周期）                    │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4       Git 安全 → 陈旧检测 → 服务端代理 → 外部 IDE               │
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4       试点 → 标准化 → Worker → MCP 规模 → 运营                  │
└─────────────────────────────────────────────────────────────────────────┘
```

**阅读方式：** 按顺序执行 **NEST 阶段**。在**第 2–4 阶段**中，在全公司 IDE 推广前至少完成 **MCP M1–M3**。用 **P0–P4** 安排人力与支持负载。每个门控应用 **CTO 工作流**。

---

## 3. CTO 工程工作流阶段

### 阶段 A — 分析

| 项 | 实践 |
|----|------|
| **目的** | 区分症状与需求；暴露隐含假设 |
| **关键问题** | 谁运行 CLI？谁拥有服务器？ MCP 是否暴露在攻击面？哪些数据离开终端？ |
| **产出** | 干系人地图、威胁假设、各团队 MCP 传输方式清单（stdio vs HTTP） |
| **出口门控** | 一页纸 «MCP 威胁模型» 经安全或技术负责人批准 |

### 阶段 B — 设计

| 项 | 实践 |
|----|------|
| **目的** | 在明确权衡下比较真实方案 |
| **方案** | (1) 仅本地 MCP；(2) 带 Bearer 的服务端 MCP；(3) stdio 桥（`annie mcp`） |
| **权衡** | 安全 vs 便利；集中审计 vs 本地时延；stdio 兼容 vs 原生 HTTP |
| **出口门控** | 按角色（开发笔记本 / runner 主机 / 外部 IDE）选定模式 |

### 阶段 C — 风险

| 项 | 实践 |
|----|------|
| **目的** | 失效模式与回滚 |
| **示例** | 已提交的 `mcp.json` 导致令牌泄露；孤儿 localhost URL；工具面过大 |
| **产出** | 回滚手册（禁用 MCP 配置项、轮换令牌、清理缓存） |
| **出口门控** | 已记录并指定负责人的回滚演练 |

### 阶段 D — 实施

| 项 | 实践 |
|----|------|
| **目的** | 防御性默认与可观测性 |
| **实践** | 服务端 MCP 强制 Bearer；仓库无密钥；stdio 桥日志走 stderr |
| **出口门控** | 目标环境通过 §12 检查清单 |

---

## 4. NEST 实施阶段 0–6

与 **[NEST 方法论](../methodology/README.md)** 对齐。

### 阶段 0 — 发现

| 维度 | 要点 |
|------|------|
| **目标** | 梳理团队、智能体、IDE；确认成功指标 |
| **Annie** | 谁需要 `annie claude` / `annie cursor` / `annie codex`；操作系统与安装路径 |
| **MCP** | Cursor HTTP vs VS Code vs Claude Desktop stdio |
| **交付物** | 试点名单、IDE 清单、「无认证则无 MCP」政策草案 |
| **出口门控** | 发起人签署试点范围 |

### 阶段 1 — 战略

| 维度 | 要点 |
|------|------|
| **目标** | 令牌模型、代理路由、合规叙事 |
| **Annie** | `CLI_API_TOKEN` 发放（若使用按团队命名空间）；密钥库 vs `annie auth login` |
| **MCP** | Nginx（或边缘）必须将 **`/mcp/`** 转发至 Rust；记录 TLS 终结 |
| **交付物** | 架构图、令牌轮换 RACI |
| **出口门控** | MCP URL 暴露面（内网 / VPN / 公网）安全评审 |

### 阶段 2 — 基础

| 维度 | 要点 |
|------|------|
| **目标** | 生产级服务器；密钥已分发 |
| **Annie** | 按环境统一 `NEST_API_URL`；黄金镜像验证 `annie auth status` |
| **MCP** | 大规模采用 Cursor 前完成 **M1**（gitignore 规则） |
| **交付物** | 手册：「新员工笔记本入网」 |
| **出口门控** | 健康检查通过；PWA 示例会话 |

### 阶段 3 — 构建

| 维度 | 要点 |
|------|------|
| **目标** | Worker、IDE 配置、桥接 |
| **Annie** | 在指定主机 `annie worker start`；培训 `worker list` / `stop-session` |
| **MCP** | **M2–M3**（陈旧项检测 + runner 的服务端 MCP） |
| **交付物** | 脱敏模板 `mcp.json`（`url` + `headers`）；stdio 包装脚本示例 |
| **出口门控** | 端到端：PWA 操作 → RPC → 工具结果 |

### 阶段 4 — 加固

| 维度 | 要点 |
|------|------|
| **目标** | 认证强化、密钥扫描、培训 |
| **Annie** | CI 镜像固定 CLI 版本；支持文档含 `annie diagnose` |
| **MCP** | 无 Bearer 返回 **401**；`mcp.json` 预提交钩子 |
| **交付物** | 安全测试证据、支持宏 |
| **出口门控** | 预发布环境 §12 清单 100% |

### 阶段 5 — 上线

| 维度 | 要点 |
|------|------|
| **目标** | 试点 → 部门 → 全公司，含反馈闭环 |
| **Annie** | 统计会话创建失败、worker 断连 |
| **MCP** | 记录 IDE 客户端版本；MCP 相关工单 |
| **交付物** | 上线复盘、KPI 看板 |
| **出口门控** | 发起人按指标评审 |

### 阶段 6 — 运营

| 维度 | 要点 |
|------|------|
| **目标** | SRE 式运营，控制成本与风险 |
| **Annie** | 季度 CLI 升级通报；日志抽样 |
| **MCP** | 令牌轮换日历；季度工具面评审 |
| **交付物** | 运营指标：MCP 4xx/5xx、RPC 时延 |
| **出口门控** | 持续改进 backlog 有预算 |

**RACI 示例**

| 活动 | 工程 | 安全 | IT / 桌面 | 支持 |
|------|------|------|-----------|------|
| 令牌发放 | C | A | I | I |
| Nginx `/mcp/` 路由 | R | C | A | I |
| MCP 手册 | R | C | I | A |
| 试点用户 | A | I | C | R |

---

## 5. MCP 技术成熟度阶段（M1–M4）

### M1 — Git 与仓库安全

| 项 | 行动 |
|----|------|
| **目标** | 防止误提交注入的 MCP 配置 |
| **行动** | `.gitignore`：`**/.cursor/mcp.json`、`**/.cursor/mcp.json.nest-backup`；培训 |
| **验证** | CI grep 对已跟踪的 `mcp.json` 失败 |

### M2 — 陈旧条目检测

| 项 | 行动 |
|----|------|
| **目标** | 减少崩溃后失效的 localhost URL |
| **行动** | Annie 注入逻辑（可达性检测）；手工清理文档 |
| **验证** | 模拟崩溃 → 下次启动修复或覆盖陈旧项 |

### M3 — 服务端代理 MCP

| 项 | 行动 |
|----|------|
| **目标** | 远程 runner/Cursor 使用服务器 URL，而非仅 loopback |
| **行动** | 有效 API 基址 + `/mcp/sessions/<id>` + **Bearer**；生产环境代理 `/mcp/` |
| **验证** | Cursor 与 worker 在不同主机时 MCP 仍可用 |

### M4 — 外部 IDE 扩展

| 项 | 行动 |
|----|------|
| **目标** | VS Code、Claude Desktop、ChatGPT 连接器（若产品支持） |
| **行动** | 各客户端标准模板；未来可按版本提供 `annie mcp install` 类自动化 |
| **验证** | 非 Cursor 客户端通过相同 §12 检查 |

---

## 6. 运营推广阶段（P0–P4）

### P0 — 试点（5–20 用户）

| 主题 | 要点 |
|------|------|
| **范围** | 一种主智能体模式；一类 IDE；MCP 可选但若启用必须 Bearer |
| **周期** | 通常 2–4 周 |
| **指标** | 会话成功率、零密钥事故、每用户支持工时 |
| **出口** | 是否进入 P1 的 Go/No-Go |

### P1 — 标准化

| 主题 | 要点 |
|------|------|
| **范围** | 黄金 `NEST_API_URL`；强制 `annie auth login` 或 MDM 下发环境变量 |
| **MCP** | 全组织完成 M1 |
| **出口** | 抽样审计：95%+ 机器 `annie auth status` 正常 |

### P2 — Worker 生产化

| 主题 | 要点 |
|------|------|
| **范围** | 专用 runner 主机；`worker status` 值班 |
| **MCP** | 远程 spawn 通过 M3 验证 |
| **出口** | PWA 远程会话演示 + 审计日志条目 |

### P3 — MCP 规模

| 主题 | 要点 |
|------|------|
| **范围** | Cursor 使用 HTTP MCP；其他用 stdio 桥；已发布手册 |
| **MCP** | 第二客户端（如 VS Code）做 M4 试点 |
| **出口** | MCP 认证事件有已知 MTTR |

### P4 — 稳态运营

| 主题 | 要点 |
|------|------|
| **范围** | 季度令牌轮换；CLI 版本固定策略 |
| **指标** | RPC 错误、MCP HTTP 状态码、worker 重启 |
| **出口** | 持续合规证据 |

---

## 7. 架构概览

```
员工机器                         NEST 服务器                     客户端
────────                         ──────────                     ──────
annie <代理>  ── Socket.IO ──►  Rust 服务  ◄── SSE/REST ───  PWA / Telegram
     │                          Postgres 审计
     │                          POST /mcp/sessions/:sessionId
     ▼                                    ▲
Cursor / VS Code MCP  ── Streamable HTTP ─┘
```

**不变量：** `CLI_API_TOKEN`；有效 API 基址；路径 **`/mcp/sessions/<session_id>`** 且必须 **Bearer**。

---

<a id="section-8-cli-zh"></a>

## 8. CLI（`@contextzero/nest`）— 命令参考

安装：**`npm install -g @contextzero/nest`** → 可执行文件 **`annie`**。**完整权威说明**（Computer 模式、远程 PTY 终端、未识别子命令时默认按 `cursor` 解析、`hook-forwarder` 等）见**英文版**：[annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) — 不链接私有源码仓库。

**Computer 包装器（2026-06-01）：** **OpenClaw**、**ZeroClaw**、**Hermes** 在 **`annie computer`** 内。**项目：** **项目管理 2026-05-01** · **CRM 2026-05-15** — [ROADMAP.md](../../ROADMAP.md) · 详见**英文** §8.3：[annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) · [zeroclaw.md](./zeroclaw.md)。

| 领域 | 命令 | 用途 |
|------|------|------|
| Claude | `annie claude [args…]` | Claude Code + NEST |
| Cursor | `annie cursor [args…]` | Cursor Agent |
| Codex | `annie codex [args…]` | Codex；`annie codex resume <id>` |
| Gemini | `annie gemini [args…]` | Gemini（ACP） |
| OpenCode | `annie opencode [args…]` | OpenCode |
| KiloCode | `annie kilocode [args…]` | KiloCode |
| **Computer（运维）** | `annie computer [args…]` | Hub 侧多工具代理（Shell、浏览器、文件、自动化等） |
| 认证 | `annie auth login` / `status` / `logout` | 凭据 |
| Worker | `annie worker start` / `stop` / `status` / `list` / `stop-session <id>` / `logs` | 后台 worker |
| MCP | `annie mcp [--url <url>] [--token \| --bearer <密钥>]` | stdio → HTTP MCP |
| 服务器 | `annie server [--host …] [--port …]` | 捆绑 Hub（若你的安装包含） |
| 诊断 | `annie diagnose` / `annie diagnose clean` | 诊断 / 清理进程 |
| 受限 | `hook-forwarder`；`connect`；`notify` | 见英文指南 |

---

## 9. 配置与 URL 规则

| 变量 | 必填 | 说明 |
|------|------|------|
| `CLI_API_TOKEN` | **是** | 须与服务器一致 |
| `NEST_API_URL` | 否 | 规范化后的基址 URL |
| `NEST_HOME` | 否 | 默认 `~/.nest` |
| `NEST_HTTP_MCP_URL` | 否 | `annie mcp` 默认目标 |
| `NEST_MCP_BEARER_TOKEN` | 否 | 桥接可选 Bearer |

---

## 10. MCP — 协议、安全与端点

### 10.1 端点

- **POST** `/mcp/sessions/<session_id>`
- **头：** `Authorization: Bearer <token>`
- **正文：** JSON-RPC 2.0（MCP Streamable HTTP）

### 10.2 Cursor 示例（`mcp.json`）

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/SESSION_ID",
      "headers": {
        "Authorization": "Bearer YOUR_CLI_API_TOKEN"
      }
    }
  }
}
```

### 10.3 stdio 桥

```bash
# 生产环境优先：环境变量
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

也可在**命令行传入 URL 与令牌**（便于本地测试；令牌可能出现在 `ps` 与 shell 历史中）：

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/SESSION_ID" --token "YOUR_CLI_API_TOKEN"
```

`--bearer` 与 `--token` 同义。同时设置时，**命令行参数优先于环境变量**。

### 10.4 Git

`.cursor/mcp.json` 为机器本地配置；勿提交令牌；优先从密钥管理系统注入。

---

## 11. 各客户端集成模式

| 客户端 | 推荐模式 |
|--------|----------|
| **Cursor** | HTTP `url` + `headers.Authorization` |
| **VS Code** | 扩展原生 HTTP **或** stdio + `annie mcp` |
| **Claude** | stdio → `annie mcp` + 环境变量或钥匙串包装 |
| **ChatGPT** | 若产品支持自定义 HTTP MCP，采用相同 Bearer 模型 |

与仓库**编程语言**无关。

---

## 12. 风险、验证与治理

| 风险 | 缓解 |
|------|------|
| 令牌外泄 | 轮换；命名空间令牌；密钥库 |
| 陈旧 MCP URL 进入 Git | `.gitignore`、CI grep、培训 |
| 工具面过大 | 安全评审后再扩展 |
| 「localhost 即安全」误区 | 服务端 MCP 仍须 Bearer |

**验证清单：** `annie auth status`；`annie diagnose`；无 `Authorization` 的 MCP → **401**；有效令牌 → `initialize` / `tools/list`；PWA 可驱动会话。

---

## 13. 相关文档

| 文档 | 内容 |
|------|------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | CLI 业务视角 |
| [INSTALL.md](../INSTALL.md) | 安装 |
| [DEVOPS.md](../DEVOPS.md) | HTTPS、反向代理 |
| [Methodology](../methodology/README.md) | NEST 0–6 |
| [Enterprise README](./README.md) | 企业版功能 |
| [nest-server 镜像](https://hub.docker.com/r/matiasbaglieri/nest-server) | 路由与契约以已发布容器及 **nest_hub** 文档为准 |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*公开发布：[contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI：[@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)。*

</div>
