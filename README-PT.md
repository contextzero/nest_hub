<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Plataforma de Automação da Força de Trabalho — Auto-hospedada — Enterprise Grade**
<br/>
<em>O sistema operacional de como a sua empresa trabalha com IA.</em>
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

> **Sim, você ainda tem 15+ apps**—e essa fragmentação já doía em 2018. Hoje soma-se a **IA corporativa nas sombras**: as pessoas já usam ChatGPT, Claude, Cursor, Copilot, ferramentas de imagem e API soltas—muitas vezes você não sabe **onde**, **qual modelo** nem **quanto custa**. Os prompts começam do zero em cada aba; quando alguém sai, o **julgamento refinado com IA** sai junto. Você tem painéis para receita e servidores, mas não para **como o trabalho realmente acontece com IA**.

**NEST** é a **camada auto-hospedada que a sua empresa executa**: **projetos**, **papéis**, **memória** e **governança** para agentes e chat rodarem **sob os seus URLs, os seus tokens e o seu registo de auditoria**—não como TI invisível.

**NEST** é também uma **plataforma completa de automação da força de trabalho**: código, chat e uso do computador num único hub—telefone, tablet e desktop.

> Você implanta: um comando Docker no seu servidor.
> Sua equipe recebe: um hub de força de trabalho IA em tempo real, acessível de qualquer dispositivo.

### Três superfícies — dentro de projetos que os administradores possuem

O trabalho agrupa-se em **projetos** criados pelos administradores. Isso dá **rastreio por projeto** (quem fez o quê, em que sessão), um **banco de memória** que acumula contexto por utilizador e equipa (a «alma» de como cada pessoa trabalha com IA) e **aprovações** antes de ações de alto risco—em vez de separadores soltos do navegador.

| Superfície | O que os funcionários obtêm hoje | Notas |
|--------|----------------------------|--------|
| **Desenvolvimento** | **Claude Code**, **Cursor**, **Codex**, **OpenCode** e **KiloCode** através da CLI **`annie`** (`npm install -g @contextzero/nest`), com **MCP** para **Cursor** e **Visual Studio Code** | [Referência completa CLI + MCP](docs/enterprise/annie-cli-mcp-enterprise.md) |
| **Chat** | Um chat do hub em **web, desktop e PWA móvel** com **OpenRouter**, **Fal.ai**, **Google Vertex AI** e **DeepInfra** — **mais de 700** modelos em **texto, imagem, áudio e vídeo** | As chaves dos fornecedores ficam no **servidor**; os funcionários autenticam-se no **seu** hub |
| **Computer** | **`annie computer`** — «computer use» sincronizado com o hub a partir da CLI e da PWA (shell, navegador onde permitido, ficheiros, runbooks). A partir de **1 de junho de 2026**, **OpenClaw**, **ZeroClaw** e **Hermes** são entregues como **invólucros dentro de Computer** (o mesmo padrão que Claude, Cursor, …)—não como subcomandos isolados de `annie` ([detalhe](docs/enterprise/zeroclaw.md)) | A mesma postura **rever → aprovar → executar** das sessões de desenvolvimento |

### Roteiro do produto (2026)

| Data | Marco |
|------|-----------|
| **1 de maio de 2026** | **Gestão de projetos** nos projetos — backlogs, estados de fluxo e visibilidade entre tarefas |
| **15 de maio de 2026** | **CRM** — contactos e ciclo de vida (p. ex. pré-vendas → vendas → pós-vendas) partilhados **entre projetos** |
| **1 de junho de 2026** | **Invólucros `annie computer`** — **OpenClaw**, **ZeroClaw** e **Hermes** integrados **dentro de Computer** (o mesmo padrão de anexar que outros agentes ligados ao hub) |

Encaminhamento consciente do papel (o funcionário **revê → aprova →** execução em **Computer**, **Claude**, **Cursor**, etc.) liga estes módulos—ver [ROADMAP.md](ROADMAP.md) para âmbito e notas de entrega.

### Vídeo do produto


https://github.com/user-attachments/assets/abfe0d75-8808-45a6-a671-8b84dd21fd2f


Também no repositório: [`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

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
| **Computer (gestão)** | `annie computer` | Agente multi-ferramenta sincronizado com o hub: shell, navegador, ficheiros, git, processos, agendamento—para além de um único IDE |
| **ZeroClaw** | *via `annie computer` (a partir de 1 jun 2026)* | Invólucro de automação headless — tarefas autónomas autocorretivas ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **OpenClaw** | *via `annie computer` (a partir de 1 jun 2026)* | Invólucro de orquestração — fluxos multi-etapa + controlo do navegador ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **Hermes** | *via `annie computer` (a partir de 1 jun 2026)* | Invólucro de uso do computador junto a OpenClaw / ZeroClaw ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs. `annie` solto:** A partir de **1 de junho de 2026**, **OpenClaw**, **ZeroClaw** e **Hermes** correm como **invólucros dentro de `annie computer`** (o mesmo padrão que Claude, Cursor, Codex, …)—ver [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). **Não** há comandos autónomos `annie openclaw` / `annie zeroclaw` / `annie hermes`. Em scripts e CI use sempre um subcomando explícito (`annie claude`, `annie computer`, …). Se o primeiro token não for um subcomando conhecido, a CLI comporta-se como **`annie cursor`**.

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
