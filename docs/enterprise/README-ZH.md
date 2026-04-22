<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Enterprise — NEST Platform

[English](./README.md) | [Español](./README-ES.md) | **中文** | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

**CLI + MCP（多语言）：** [中文](./annie-cli-mcp-enterprise-ZH.md) · [EN](./annie-cli-mcp-enterprise.md) · [ES](./annie-cli-mcp-enterprise-ES.md) · [DE](./annie-cli-mcp-enterprise-DE.md) · [PT](./annie-cli-mcp-enterprise-PT.md) · [FR](./annie-cli-mcp-enterprise-FR.md)

**Enterprise** 版 NEST 面向需要超出纯自建能力的组织，提供高级功能。Community 版免费且可完全自建；Enterprise 则增加智能、规模与支持。

---

## 快速对比

| 功能 | Community | Enterprise |
|---------|-----------|------------|
| **价格** | $0 product fee | 订阅制 |
| **部署** | Self-hosted Docker | 托管云 |
| **用户** | 个人 / 小团队 | 组织、非政府组织、政府机构 |
| **Basic Agents** | ✅ | ✅ |
| **Darwin Agents** | ❌ | ✅ |
| **Colony Memory** | ❌ | ✅ |
| **Specialized Agents** | ❌ | ✅ |
| **Advanced Automation** | 基础 | 完整 ZeroClaw |
| **SSO / SAML** | ❌ | ✅ |
| **Audit Logs** | 本地 | 全面合规 |
| **支持** | GitHub | 专属 SLA |
| **Custom Integrations** | ❌ | ✅ |

---

## Enterprise 功能

### 1. Colony Memory

系统会从整个组织的每次交互中学习。

**学习内容：**
- 哪些 agent 在特定任务类型上表现最好
- 员工偏好与工作模式
- 能加速工作的项目上下文
- 实践中发现的最优工作流

**收益：**
- 新员工能更快上手
- 最佳实践自动扩散
- 知识保留在组织内

> *"Colony Memory 让 NEST 不同于简单的 agent 运行器。每个任务都在教会系统。"* — [价值主张](../business/value-proposition.md)

---

### 2. Darwin Agents

基于表现不断演进、改进的 AI agent。

**生命周期：**

```
┌──────────────┐
│ 1. CREATE    │ ← User describes a need
└──────┬───────┘
       ↓
┌──────────────┐
│ 2. TRAIN     │ ← Agent performs task
└──────┬───────┘
       ↓
┌──────────────┐
│ 3. EVALUATE  │ ← Performance tracked
└──────┬───────┘
       ↓
┌──────────────┐
│ 4. EVOLVE    │ ← Best agents replicate
└──────┬───────┘
       ↓
┌──────────────┐
│ 5. DEPLOY    │ ← Better results next time
└──────────────┘
```

**示例：**
- Email response agent → 学习你的沟通风格
- Research agent → 更擅长找到相关信息
- Code reviewer → 理解你代码库的模式
- Report generator → 适配偏好的格式

---

### 3. Specialized Agents

面向常见企业任务的预置 agent：

| Agent | 作用 |
|-------|-------------|
| **Research Agent** | Web scraping、数据采集、摘要 |
| **Email Agent** | 撰写、发送与管理邮件流程 |
| **Calendar Agent** | 安排会议、管理可用时间 |
| **Document Agent** | 生成报告、合同与摘要 |
| **Data Agent** | 分析数据、创建 dashboards |
| **Support Agent** | 客户响应自动化 |
| **HR Agent** | 入职与政策问答 |
| **Finance Agent** | 发票处理与对账 |

---

### 4. Advanced ZeroClaw

- 更深的系统访问
- 多机编排
- 自定义工作流模板
- 定时自动化
- 事件驱动触发

自动化如何运作，见 [Console Flow](../business/console-flow.md)。

---

### 5. Enterprise 安全

- SSO / SAML 集成
- 基于角色的访问控制
- 完整审计合规
- 数据驻留选项
- SOC 2 ready

---

## 定价

### Startup

- 最多 10 名用户
- Colony memory
- Darwin agents
- Email support
- **$99/month**

### Business

- 无限用户
- 全部功能
- Priority support
- Custom integrations
- **$299/month**

### Enterprise

- 全部无限
- Dedicated infrastructure
- Custom SLA
- On-premise option
- **Contact sales**

---

## 入门

### 第一步：联系销售

```
sales@contextzero.ai
```

### 第二步：需求沟通会议

我们会讨论：
- 组织需求
- 当前工作流
- 自动化目标
- 安全要求

### 第三步：试点项目

- 30 天 POC
- 范围有限
- 全功能访问
- 明确成功指标

### 第四步：生产上线

- 完整部署
- 培训
- 持续支持

---

## 支持

| 等级 | 响应时间 | 渠道 |
|------|--------------|---------|
| Startup | 24h | Email |
| Business | 4h | Email + Chat |
| Enterprise | 1h | Dedicated |

---

## 从 Community 迁移

已在用自建 NEST？

- 导出数据
- 我们协助迁移到 Enterprise
- 相同工作流，更智能的 agent
- 零业务中断

---

## 相关文档

- [Annie CLI 与 MCP 企业指南](./annie-cli-mcp-enterprise-ZH.md) — 完整 CLI、MCP、分阶段上线
- [Business Overview](../business/README.md) — 面向创始人的战略价值
- [Value Proposition](../business/value-proposition.md) — 详细收益
- [Use Cases](../business/use-cases.md) — 真实场景
- [Methodology](../methodology/README.md) — 实施指南
- [CLI Business](../CLI-BUSINESS.md) — 技术深入
- [Install Guide](../INSTALL.md) — 安装参考

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*公开发布：[contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI：[@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest)。*

</div>
