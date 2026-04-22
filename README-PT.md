<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Plataforma de Automação da Força de Trabalho — Auto-hospedada — Enterprise Grade**
<br/>
<em>Seu hub. Seus dados. Sua força de trabalho IA. Na palma da sua mão.</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-Entrar-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Entrar-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![Docker](https://img.shields.io/badge/Docker-Pronto-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## O que é o NEST?

**NEST** é uma plataforma completa e auto-hospedada de **automação da força de trabalho**. Não é apenas para programação — seus funcionários podem gerenciar máquinas, resolver tarefas, enviar emails, pesquisar, construir produtos e mais. Tudo em um hub. Tudo do celular.

> Você implanta: um comando Docker no seu servidor.
> Sua equipe recebe: um hub de força de trabalho IA em tempo real, acessível de qualquer dispositivo.

### Vídeo do produto

Visão geral da experiência do hub (arquivo local neste repositório):

[`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

### Os Quatro Pilares

| Pilar | Significado |
|-------|------------|
| **Hub para a Empresa** | Um app substitui Slack + Notion + Trello + WhatsApp. Projetos → Funcionários → Sessões. |
| **Móvel para o Funcionário** | PWA funciona em qualquer celular. Aprove deploys do ônibus. Sem laptop. |
| **Banco de Memória (Souls)** | O hub aprende cada funcionário. Sem re-explicar contexto a cada sessão. |
| **Enxame de Agentes** | Múltiplos agentes IA especializados trabalhando em paralelo. |

---

## Início Rápido — Online em 5 minutos

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

> **Guia detalhado:** [QUICKSTART.md](QUICKSTART.md)

---

## Agentes suportados

| Agente | Comando | Descrição |
|--------|---------|-----------|
| **Claude Code** | `annie claude` | Agente de código principal da Anthropic |
| **Cursor** | `annie cursor` | Modo agente do IDE Cursor |
| **Codex** | `annie codex` | Agente de execução de código da OpenAI |
| **Gemini** | `annie gemini` | Agente multimodal do Google |
| **OpenCode** | `annie opencode` | Agente de código open source |
| **KiloCode** | `annie kilocode` | Execução de tarefas + controle remoto |
| **Computer (gestão)** | `annie computer` | Agente multi-ferramenta sincronizado com o hub (shell, navegador, ficheiros) |
| **ZeroClaw** | Automação headless | Tarefas autônomas autocorretivas |
| **OpenClaw** | Orquestração de projetos | Fluxos multi-etapa + controle do navegador |

\*A partir de **1 de junho de 2026**, **ZeroClaw** e **OpenClaw** ficam disponíveis como **invólucros dentro de `annie computer`** (o mesmo padrão que outros agentes Computer). Ver [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md).

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs. `annie` solto:** A partir de **1 de junho de 2026**, **ZeroClaw** e **OpenClaw** ficam **dentro de `annie computer`** como invólucros (o mesmo padrão que Claude, Cursor, Codex, …)—ver [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). **Não** há comandos `annie zeroclaw` / `annie openclaw`. Em scripts e CI use sempre um subcomando explícito (`annie claude`, `annie computer`, …). Se o primeiro token não for um subcomando conhecido, a CLI comporta-se como **`annie cursor`**.

### Implantação enterprise — CLI (`@contextzero/nest`)

Sequência para **macOS, Windows e Linux** onde os funcionários usam Cursor, Claude Code, Codex, OpenCode ou KiloCode. Após **`npm install -g @contextzero/nest`** (pacote npm oficial da CLI, binário **`annie`**) cada estação liga-se à **sua** instância NEST; a Context Zero não hospeda o seu hub auto-hospedado nem entra na sua rede.

**1. Instalar a CLI (TI ou funcionário, com Node.js LTS + npm):**

```bash
npm install -g @contextzero/nest
annie --version
```

**2. Autenticar a máquina contra o seu hub**

Executar uma vez por perfil (ou automatizar via MDM / cofre de segredos com as mesmas variáveis que `annie auth login` persiste):

```bash
annie auth login
```

Serão solicitados a **URL base do seu deploy** (por exemplo `https://nest.suaempresa.com`, emitida pela sua organização) e um **token de API da CLI** gerado pelos administradores no servidor. Verificar conectividade:

```bash
annie auth status
```

**3. Pontos de entrada usuais (após o login)**

| Superfície | Comando | Finalidade |
|------------|---------|------------|
| **Claude Code** | `annie claude` | Sessões Claude Code |
| **Cursor** | `annie cursor` | Modo agente Cursor |
| **Codex** | `annie codex` | Sessões Codex (`annie codex resume <id>` quando suportado) |
| **Gemini** | `annie gemini` | Sessões Gemini |
| **OpenCode** | `annie opencode` | Sessões OpenCode |
| **KiloCode** | `annie kilocode` | Execução KiloCode |
| **Computer** | `annie computer` | Agente de gestão multi-ferramenta (shell, navegador, ficheiros, processos) |
| **Ponte MCP** | `annie mcp` | MCP stdio para o seu hub (destino HTTP + token) |
| **Worker** | `annie worker start` · `list` · `stop-session <id>` | Trabalho em segundo plano ligado ao hub |
| **Terminais do hub** | *(PWA ↔ servidor ↔ PTY na CLI)* | Shells remotos para operadores (superfície privilegiada) |

Distribua **somente** URLs e tokens emitidos pelo **seu** domínio corporativo e sistemas de identidade. Os funcionários devem instalar a **PWA ou clientes** a partir de links que vocês controlam (intranet, MDM ou páginas de download da marca) e usar celular, tablet ou desktop para aprovar trabalho, monitorar sessões e auditar atividade—sem compartilhar credenciais fora do seu tenant.

**Leitura adicional:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — superfície completa: agentes de IDE, **`annie computer`**, **terminais remotos (PTY)**, worker, MCP, diagnóstico; sem ligação a repositórios de código privados.

**Automação:** se o primeiro argumento não for um subcomando conhecido, a invocação é tratada como **`annie cursor`**. Em CI, use sempre um subcomando explícito (`annie claude`, `annie computer`, etc.).

---

## Comunidade

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Entrar-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

---

## Aviso importante — implantações auto-hospedadas, responsabilidade e acesso

O texto a seguir é um **aviso informativo geral** para clientes e operadores. **Não** constitui aconselhamento jurídico personalizado; o seu assessor jurídico deve analisá-lo face aos contratos, jurisdição e obrigações regulatórias.

**Uso e conformidade.** A sua organização—**não** a Context Zero Inc. (incluindo afiliadas, contratados ou pessoal, em conjunto «**Context Zero**»)—é **exclusivamente responsável** por como implanta, configura, protege e utiliza o NEST Hub, incluindo todas as saídas de agentes de IA, integrações, tratamento de dados, práticas de trabalho, controlos de exportação, privacidade, regulamentação setorial e políticas internas. A Context Zero não supervisiona o seu ambiente de execução nem assume responsabilidade por decisões dos seus funcionários, agentes ou sistemas na sua infraestrutura.

**Conectividade auto-hospedada.** Quando opera o NEST como software **auto-hospedado** em infraestrutura sob o seu controlo, a **Context Zero não opera esse servidor**, não recebe ligação administrativa automática para o mesmo e **não pode aceder** à sua instalação apenas por ter descarregado ou licenciado materiais nossos. O seu hub é alcançado pelos seus utilizadores e ferramentas (por exemplo a CLI `annie` via `@contextzero/nest`) em **saída** para os endpoints **que** configurar (o seu DNS, os seus certificados TLS, os seus tokens). Salvo contrato separado de serviços geridos que preveja explicitamente administração remota e âmbito de acesso, **nenhum membro da equipa Context Zero tem acesso de entrada** aos seus servidores no modelo de produto auto-hospedado descrito neste repositório.

**Sem representação.** Nada neste README cria parceria, joint venture ou relação de mandato. A Context Zero é fornecedora de software; **a sua empresa permanece exclusivamente responsável** pelo uso lícito, governação da força de trabalho e segurança da implantação.

---

**© 2025–2026 Context Zero** — Plataforma de Automação da Força de Trabalho Auto-hospedada

<div align="center">

*Distribuição pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
