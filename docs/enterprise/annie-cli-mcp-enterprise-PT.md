<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Guia Enterprise — CLI Annie, MCP e integração multi-cliente

[Português](./annie-cli-mcp-enterprise-PT.md) | [English](./annie-cli-mcp-enterprise.md) | [Español](./annie-cli-mcp-enterprise-ES.md) | [Deutsch](./annie-cli-mcp-enterprise-DE.md) | [Français](./annie-cli-mcp-enterprise-FR.md) | [中文](./annie-cli-mcp-enterprise-ZH.md)

Este documento é a referência **nível enterprise** para implantar **Annie** (CLI `@contextzero/nest`), usar **todas as superfícies de comando suportadas** e integrar **NEST MCP** com ChatGPT, Claude, Cursor e VS Code.

**Linguagens de programação:** o NEST é **agnóstico** em relação às linguagens dos seus repositórios (Python, TypeScript, Rust, Go, Java, .NET, etc.). As sessões ligam-se a um **caminho de workspace** e a um **id de sessão no servidor**, não a um único runtime.

**Idiomas do documento:** o guia está disponível em **seis línguas naturais** (EN, ES, DE, FR, PT, ZH) com a **mesma estrutura em fases** em cada ficheiro.

---

## Índice

1. [Resumo executivo](#1-resumo-executivo)
2. [Modelo de fases — visão geral](#2-modelo-de-fases--visão-geral)
3. [Fases do fluxo de engenharia CTO](#3-fases-do-fluxo-de-engenharia-cto)
4. [Fases de implementação NEST 0–6](#4-fases-de-implementação-nest-06)
5. [Fases de maturidade técnica MCP (M1–M4)](#5-fases-de-maturidade-técnica-mcp-m1m4)
6. [Fases de rollout operacional (P0–P4)](#6-fases-de-rollout-operacional-p0p4)
7. [Arquitetura](#7-arquitetura)
8. [CLI (`@contextzero/nest`) — referência de comandos](#section-8-cli-pt)
9. [Configuração e regras de URL](#9-configuração-e-regras-de-url)
10. [MCP — protocolo, segurança e endpoints](#10-mcp--protocolo-segurança-e-endpoints)
11. [Padrões por cliente](#11-padrões-por-cliente)
12. [Risco, validação e governação](#12-risco-validação-e-governação)
13. [Documentos relacionados](#13-documentos-relacionados)

---

## 1. Resumo executivo

| Camada | O que responde |
|--------|----------------|
| **Fluxo CTO** | *Como* pensar antes de entregar (análise → desenho → risco → implementação) |
| **NEST 0–6** | *Quando* infraestrutura, agentes e governação chegam à organização |
| **MCP M1–M4** | *Como* o MCP evolui de ficheiros locais seguros para proxy autenticado no servidor + IDEs externos |
| **Ops P0–P4** | *Como* escalar do piloto à operação em produção |

**Requisitos não negociáveis MCP enterprise**

1. **URL + Bearer** em `POST /mcp/sessions/<session_id>` — nunca só «URL».
2. **Higiene Git** para `.cursor/mcp.json` e backups — tratar como superfície de segredos local.
3. **Subcomandos CLI explícitos** em automação (`annie claude`, sem defaults ambíguos).

---

## 2. Modelo de fases — visão geral

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Fluxo CTO      Análise → Desenho → Risco → Implementação                │
│       │                    (contínuo; gate em cada fase NEST)              │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6       Discovery → … → Operate   (ciclo de vida da plataforma)   │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4      Git seguro → Stale → Proxy servidor → IDE externo         │
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4      Piloto → Padronizar → Worker → Escala MCP → Operar        │
└─────────────────────────────────────────────────────────────────────────┘
```

**Leitura:** executar **fases NEST** em ordem. Nas **fases 2–4**, integrar no mínimo **MCP M1–M3** antes do rollout massivo de IDEs. **P0–P4** para pessoas e carga de suporte. **Fluxo CTO** em cada gate.

---

## 3. Fases do fluxo de engenharia CTO

### Fase A — Análise

| Item | Prática |
|------|---------|
| **Propósito** | Separar sintomas de requisitos; tornar suposições visíveis |
| **Perguntas** | Quem executa o CLI? Quem é dono do servidor? MCP na superfície de ataque? Dados a sair do posto? |
| **Entregáveis** | Mapa de stakeholders, suposições de ameaça, inventário de transportes MCP |
| **Saída** | «Threat model MCP» de uma página aprovado por segurança / tech lead |

### Fase B — Desenho

| Item | Prática |
|------|---------|
| **Propósito** | Opções reais com trade-offs explícitos |
| **Opções** | (1) Só MCP local, (2) MCP no servidor com Bearer, (3) Ponte stdio (`annie mcp`) |
| **Trade-offs** | Segurança vs conveniência; auditoria central vs latência; stdio vs HTTP nativo |
| **Saída** | Padrão escolhido por persona (laptop / runner / IDE externo) |

### Fase C — Risco

| Item | Prática |
|------|---------|
| **Propósito** | Modos de falha e rollback |
| **Exemplos** | Fuga de token por `mcp.json` commitado; URLs localhost órfãs; superfície de ferramentas excessiva |
| **Entregáveis** | Runbook de rollback |
| **Saída** | Ensaio de rollback documentado e com dono |

### Fase D — Implementação

| Item | Prática |
|------|---------|
| **Propósito** | Defaults defensivos, observabilidade |
| **Práticas** | Bearer obrigatório no MCP servidor; sem segredos no repo; logs stdio em stderr |
| **Saída** | Verificações §12 passam no ambiente alvo |

---

## 4. Fases de implementação NEST 0–6

Alinhado à **[metodologia NEST](../methodology/README.md)**.

### Fase 0 — Discovery

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Mapear equipas, agentes, IDEs; métricas de sucesso |
| **Annie** | Necessidade `annie claude` / `annie cursor` / `annie codex`; SO e caminhos |
| **MCP** | Cursor HTTP vs VS Code vs Claude stdio |
| **Entregáveis** | Lista piloto; inventário IDE; rascunho de política «sem MCP sem auth» |
| **Saída** | Sponsor aprova âmbito do piloto |

### Fase 1 — Strategy

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Modelo de tokens, rotas de proxy, narrativa de compliance |
| **Annie** | Emissão `CLI_API_TOKEN` (namespace por equipa); vault vs `annie auth login` |
| **MCP** | Nginx / edge deve encaminhar **`/mcp/`** para Rust; TLS documentado |
| **Entregáveis** | Diagrama de arquitetura; RACI rotação de tokens |
| **Saída** | Revisão de segurança da exposição da URL MCP |

### Fase 2 — Foundation

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Servidor pronto para produção; segredos distribuídos |
| **Annie** | `NEST_API_URL` por ambiente; `annie auth status` em imagens golden |
| **MCP** | **M1** (gitignore) antes de adoção Cursor em larga escala |
| **Entregáveis** | Runbook «onboarding de novo portátil» |
| **Saída** | Health OK; sessão exemplo na PWA |

### Fase 3 — Build

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Workers, configs IDE, pontes |
| **Annie** | `annie worker start` em hosts dedicados; formação `list` / `stop-session` |
| **MCP** | **M2–M3** (deteção stale + MCP proxificado para runner) |
| **Entregáveis** | Template `mcp.json` com `url` + `headers` (redigido); wrappers stdio |
| **Saída** | E2E: ação PWA → RPC → resultado de ferramenta |

### Fase 4 — Hardening

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Endurecimento de auth, varredura de segredos, formação |
| **Annie** | Imagem CI com CLI fixado; `annie diagnose` na documentação de suporte |
| **MCP** | **401** sem Bearer; pre-commit para `mcp.json` |
| **Entregáveis** | Evidências de testes de segurança; macros de suporte |
| **Saída** | Checklist §12 em staging 100% |

### Fase 5 — Launch

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Piloto → departamento → empresa com feedback |
| **Annie** | Medir falhas de sessão, desconexões do worker |
| **MCP** | Versões de clientes IDE; tickets MCP |
| **Entregáveis** | Retrospectiva de lançamento; painel KPI |
| **Saída** | Revisão do sponsor vs métricas |

### Fase 6 — Operate

| Dimensão | Detalhe |
|----------|---------|
| **Objetivos** | Operação estilo SRE, controlo de custo e risco |
| **Annie** | Comunicação trimestral de upgrade do CLI; amostragem de logs |
| **MCP** | Calendário de rotação de tokens; revisão trimestral da superfície de ferramentas |
| **Entregáveis** | Métricas operacionais: MCP 4xx/5xx, latência RPC |
| **Saída** | Backlog de melhoria financiado |

**RACI (exemplo)**

| Atividade | Engineering | Security | IT / Desktop | Support |
|-----------|-------------|----------|--------------|---------|
| Emissão de token | C | A | I | I |
| Rota nginx `/mcp/` | R | C | A | I |
| Runbooks MCP | R | C | I | A |
| Utilizadores piloto | A | I | C | R |

---

## 5. Fases de maturidade técnica MCP (M1–M4)

### M1 — Git e repositório

| Item | Ação |
|------|------|
| **Meta** | Evitar commit acidental de config MCP injetada |
| **Ações** | `.gitignore` `**/.cursor/mcp.json`, `**/.cursor/mcp.json.nest-backup`; formação |
| **Verificação** | CI grep falha com `mcp.json` rastreado |

### M2 — Entradas obsoletas

| Item | Ação |
|------|------|
| **Meta** | Menos URLs localhost mortas após crashes |
| **Ações** | Lógica de injeção Annie; doc de limpeza manual |
| **Verificação** | Crash simulado → próximo arranque repara ou sobrescreve |

### M3 — MCP proxificado no servidor

| Item | Ação |
|------|------|
| **Meta** | Runner / Cursor remoto usa URL do servidor |
| **Ações** | Base API efetiva + `/mcp/sessions/<id>` + **Bearer**; `/mcp/` em prod |
| **Verificação** | MCP OK com Cursor e worker em hosts diferentes |

### M4 — IDE externo em escala

| Item | Ação |
|------|------|
| **Meta** | VS Code, Claude Desktop, conectores ChatGPT quando suportados |
| **Ações** | Templates padrão; automação futura tipo `annie mcp install` |
| **Verificação** | Cliente não-Cursor passa §12 |

---

## 6. Fases de rollout operacional (P0–P4)

### P0 — Piloto (5–20 utilizadores)

| Tópico | Detalhe |
|--------|---------|
| **Âmbito** | Um modo de agente principal; uma família IDE; MCP opcional mas Bearer obrigatório se ativo |
| **Duração** | Tipicamente 2–4 semanas |
| **Métricas** | Taxa de sucesso de sessão, zero incidentes de segredos, horas de suporte / utilizador |
| **Saída** | Go / no-go para P1 |

### P1 — Padronizar

| Tópico | Detalhe |
|--------|---------|
| **Âmbito** | `NEST_API_URL` de referência; `annie auth login` obrigatório ou env MDM |
| **MCP** | M1 em toda a org |
| **Saída** | Auditoria por amostragem: 95%+ máquinas `annie auth status` OK |

### P2 — Worker em produção

| Tópico | Detalhe |
|--------|---------|
| **Âmbito** | Hosts runner dedicados; on-call para `worker status` |
| **MCP** | M3 validado para spawn remoto |
| **Saída** | Demo de sessão remota na PWA com entrada no log de auditoria |

### P3 — Escala MCP

| Tópico | Detalhe |
|--------|---------|
| **Âmbito** | MCP HTTP Cursor; ponte stdio noutros casos; runbooks |
| **MCP** | Piloto M4 segundo cliente (ex.: VS Code) |
| **Saída** | MTTR conhecido para incidentes de auth MCP |

### P4 — Estado estacionário

| Tópico | Detalhe |
|--------|---------|
| **Âmbito** | Rotação trimestral de tokens; política de fixação de versão do CLI |
| **Métricas** | Erros RPC, códigos HTTP MCP, reinícios do worker |
| **Saída** | Evidência contínua de compliance |

---

## 7. Arquitetura

```
Máquina do colaborador            Servidor NEST                  Clientes
─────────────────────             ─────────────                  ────────
annie <agente>  ── Socket.IO ──►  Servidor Rust  ◄── SSE/REST ─  PWA / Telegram
     │                            Auditoria Postgres
     │                            POST /mcp/sessions/:sessionId
     ▼                                      ▲
Cursor / VS Code MCP  ── Streamable HTTP ──┘
```

**Invariantes:** `CLI_API_TOKEN` ; URL base efetiva ; **`/mcp/sessions/<session_id>`** com **Bearer**.

---

<a id="section-8-cli-pt"></a>

## 8. CLI (`@contextzero/nest`) — referência de comandos

Instalação: **`npm install -g @contextzero/nest`** → binário **`annie`**. A **referência canónica completa** (modo Computer, terminais PTY remotos, resolução por omissão para `cursor`, `hook-forwarder`, etc.) está na **versão em inglês**: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) — sem ligações a repositórios privados.

**Invólucros Computer (1 de junho de 2026):** **OpenClaw**, **ZeroClaw** e **Hermes** em **`annie computer`**. **Projetos:** **gestão de projetos — 1 de maio de 2026** · **CRM — 15 de maio de 2026** — [ROADMAP.md](../../ROADMAP.md) · detalhe em **inglês** §8.3: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) · [zeroclaw.md](./zeroclaw.md).

| Área | Comando | Função |
|------|---------|--------|
| Claude | `annie claude [args…]` | Claude Code + NEST |
| Cursor | `annie cursor [args…]` | Cursor Agent |
| Codex | `annie codex [args…]` | Codex ; `annie codex resume <id>` |
| Gemini | `annie gemini [args…]` | Gemini (ACP) |
| OpenCode | `annie opencode [args…]` | OpenCode |
| KiloCode | `annie kilocode [args…]` | KiloCode |
| **Computer (gestão)** | `annie computer [args…]` | Agente multi-ferramenta no hub (shell, navegador, ficheiros, automação) |
| Auth | `annie auth login` / `status` / `logout` | Credenciais |
| Worker | `annie worker start` / `stop` / `status` / `list` / `stop-session <id>` / `logs` | Worker |
| MCP | `annie mcp [--url <url>] [--token \| --bearer <segredo>]` | Stdio → MCP HTTP |
| Servidor | `annie server [--host …] [--port …]` | Hub empacotado (se incluído na sua instalação) |
| Diagnóstico | `annie diagnose` / `annie diagnose clean` | Diagnóstico / limpeza |
| Limitado | `hook-forwarder` ; `connect` ; `notify` | Ver guia EN |

---

## 9. Configuração e regras de URL

| Variável | Obrigatória | Descrição |
|----------|-------------|-----------|
| `CLI_API_TOKEN` | **Sim** | Deve coincidir com o servidor |
| `NEST_API_URL` | Não | URL base normalizada |
| `NEST_HOME` | Não | Predefinição `~/.nest` |
| `NEST_HTTP_MCP_URL` | Não | Alvo predefinido `annie mcp` |
| `NEST_MCP_BEARER_TOKEN` | Não | Bearer alternativo |

---

## 10. MCP — protocolo, segurança e endpoints

### 10.1 Endpoint

- **POST** `/mcp/sessions/<session_id>`
- **Cabeçalho:** `Authorization: Bearer <token>`
- **Corpo:** JSON-RPC 2.0 (MCP Streamable HTTP)

### 10.2 Exemplo Cursor (`mcp.json`)

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/SESSION_ID",
      "headers": {
        "Authorization": "Bearer SEU_TOKEN"
      }
    }
  }
}
```

### 10.3 Ponte stdio

```bash
# Preferível em produção: variáveis de ambiente
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

**URL e token na linha de comandos** (testes locais; o token pode aparecer em `ps` e no histórico):

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/SESSION_ID" --token "SEU_TOKEN"
```

`--bearer` é alias de `--token`. Os argumentos do CLI prevalecem sobre o ambiente para o token.

### 10.4 Git

`.cursor/mcp.json` local à máquina; não commitar tokens; preferir injeção a partir de cofre.

---

## 11. Padrões por cliente

| Cliente | Padrão recomendado |
|---------|-------------------|
| **Cursor** | HTTP `url` + `headers.Authorization` |
| **VS Code** | HTTP nativo da extensão **ou** stdio com `annie mcp` |
| **Claude** | Stdio → `annie mcp` + env ou keychain |
| **ChatGPT** | MCP HTTP personalizado quando o produto permitir |

Independente da **linguagem do repositório**.

---

## 12. Risco, validação e governação

| Risco | Mitigação |
|-------|-----------|
| Exfiltração de token | Rotação ; namespaces ; cofre |
| URL MCP obsoleta no Git | `.gitignore`, CI, formação |
| Superfície de ferramentas demasiado ampla | Revisão de segurança |
| «Localhost é seguro» | Bearer continua obrigatório |

**Checklist:** `annie auth status` ; `annie diagnose` ; MCP sem auth → **401** ; com auth → `initialize` / `tools/list` ; PWA controla a sessão.

---

## 13. Documentos relacionados

| Documento | Conteúdo |
|-----------|----------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | Visão de negócio |
| [INSTALL.md](../INSTALL.md) | Instalação |
| [DEVOPS.md](../DEVOPS.md) | HTTPS, proxy |
| [Methodology](../methodology/README.md) | NEST 0–6 |
| [Enterprise README](./README.md) | Enterprise |
| [Imagem nest-server](https://hub.docker.com/r/matiasbaglieri/nest-server) | Rotas distribuídas na imagem publicada; contratos neste repositório **nest_hub** |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribuição pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
