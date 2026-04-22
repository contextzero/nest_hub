<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Entrar-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Entrar-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Início rápido

[English](./QUICKSTART.md) | [Español](./QUICKSTART-ES.md) | [中文](./QUICKSTART-ZH.md) | [Deutsch](./QUICKSTART-DE.md) | **Português** | [Français](./QUICKSTART-FR.md)

**Por Context Zero.** Plataforma de automação de força de trabalho self-hosted — nível enterprise.
Do zero a um hub de força de trabalho IA ao vivo em menos de 5 minutos.

---

## Antes de começar — O que você terá ao terminar

Nos próximos 5 minutos você vai:

1. ✅ Implantar o servidor NEST (Rust + Postgres + nginx) localmente com **um único comando**
2. ✅ Instalar o CLI `annie` em qualquer máquina
3. ✅ Iniciar sua primeira sessão real de agente IA (Claude Code, Codex, Cursor, Gemini, OpenCode ou KiloCode — e a partir de **1 de junho de 2026**, ZeroClaw / OpenClaw **via `annie computer`**)
4. ✅ Acompanhar **ao vivo no navegador** — e no celular

Não é preciso conhecimento prévio de Rust. Não precisa de conta na nuvem. Não precisa de cartão de crédito. Se o Docker roda na sua máquina, o NEST roda na sua máquina.

---

## Passo 0 — Pré-requisitos (2 minutos se precisar)

Você precisa de três coisas. Verifique cada uma:

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**As quatro passaram?** Vá ao Passo 1.

**Falta algo?** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — instala Node, npm e Docker em minutos no Mac, Linux ou Windows.

> **Por que isso?** Node + npm alimentam o CLI `annie` que você instalará nas máquinas dos funcionários. O Docker executa o servidor sem você precisar instalar Rust, Postgres ou nginx manualmente.

---

## Passo 1 — Implantar o Hub (60 segundos)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

É só isso. O `setup.sh` gera automaticamente todos os segredos, baixa imagens Docker, inicia o stack e aguarda o health check. Quando aparecer:

```
=== NEST ready ===
  Web:  http://localhost
```

Seu hub está no ar. Abra no navegador — e no celular.

> **O que aconteceu?** O `setup.sh` criou um `.env` com `POSTGRES_PASSWORD`, `CLI_API_TOKEN` e `ENCRYPTION_KEY` gerados automaticamente. Em seguida puxou e iniciou quatro containers: `nest-server` (Rust), `nest-web` (React PWA), `postgres` e `nginx`.

---

## Passo 2 — Instalar o CLI em qualquer máquina (30 segundos)

O CLI `annie` é o que seus funcionários (ou você) instalam nas máquinas onde os agentes IA rodam. Instale globalmente:

```bash
npm install -g @contextzero/nest
```

Confirme que funciona:

```bash
annie --help
```

Você deve ver a lista completa de comandos. O CLI está pronto nesta máquina.

> **Uma instalação por máquina.** Cada pessoa que for executar sessões de agente precisa instalar o `annie` na própria máquina e apontá-lo para o seu servidor.

---

## Passo 3 — Conectar ao seu servidor (30 segundos)

Duas opções — escolha uma:

**Opção A: Variáveis de ambiente (ótimo para scripts e CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **Onde está o token?** O `setup.sh` salvou em `.env`. Execute: `grep CLI_API_TOKEN .env` para ver.

**Opção B: Login interativo (salva credenciais de forma permanente)**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

Verifique a conexão:

```bash
annie auth status
```

Você deve ver a URL do servidor e um token confirmado. **Você está autenticado.**

---

## Passo 4 — Iniciar sua primeira sessão de agente

Escolha o agente e execute um comando (pacote **`@contextzero/nest`** → **`annie`**). **Referência enterprise:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md).

| Agente | Comando | O que faz |
|--------|---------|-----------|
| **Claude Code** | `annie claude` | Agente de código principal da Anthropic |
| **Codex** | `annie codex` | Agente de execução de código da OpenAI |
| **Cursor** | `annie cursor` | Modo agente do IDE Cursor |
| **Gemini** | `annie gemini` | Agente multimodal do Google |
| **OpenCode** | `annie opencode` | Agente de código open source |
| **KiloCode** | `annie kilocode` | Execução de tarefas + controle remoto |
| **Computer (gestão)** | `annie computer` | Agente multi-ferramenta no hub (shell, navegador, arquivos) |

> **ZeroClaw / OpenClaw:** a partir de **1 de junho de 2026**, **dentro de `annie computer`** como invólucros (o mesmo padrão que Claude, Cursor, …). Não são subcomandos `annie` separados. Veja [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) e [RELEASES.md](RELEASES.md).

**Automação:** se o primeiro argumento não for um subcomando conhecido, a chamada é tratada como **`annie cursor`**. Em CI, use sempre `annie claude`, `annie computer`, etc.

Exemplo — iniciar Claude Code:

```bash
annie claude
```

O terminal mostrará a sessão conectando e transmitindo. **Não feche este terminal.** O agente está ativo.

---

## Passo 5 — Seu momento eureka 🎯

Mude para o navegador (ou celular) e abra:

```
http://localhost
```

**Agora você deve ver a sessão ao vivo no dashboard.**

Daqui você pode:
- 💬 **Conversar** com o agente em execução em tempo real
- ✅ **Aprovar ou rejeitar** pedidos de permissão do agente
- 🖥️ **Acompanhar o terminal** enquanto executa
- 📱 **Fazer tudo isso pelo celular** — a PWA funciona em qualquer navegador móvel

Este é o momento. Você acabou de transformar uma sessão CLI no laptop de alguém em uma **sessão IA visível remotamente, aprovável e auditável** que pode monitorar de qualquer lugar.

---

## Referência rápida — Comandos mais úteis

```bash
annie claude            # Sessão Claude Code
annie codex             # Sessão Codex
annie cursor            # Agente Cursor
annie gemini            # Sessão Gemini
annie opencode          # Sessão OpenCode
annie kilocode          # Sessão KiloCode
annie computer          # Agente multi-ferramenta (gestão)
annie worker start      # Worker em segundo plano
annie worker list       # Sessões worker ativas
annie auth login        # Guardar credenciais
annie auth status       # Estado de autenticação
annie diagnose          # Diagnóstico
```

**Gestão do servidor (a partir da pasta `nest_hub/`):**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## O que aconteceu — E por que importa

Agora você tem:

| O quê | Onde | Por que importa |
|-------|------|-----------------|
| Dashboard de sessões ao vivo | Navegador / celular | Ver cada sessão de agente que a equipe executa, em tempo real |
| Fluxo de aprovação | PWA móvel | Agentes aguardam seu OK antes de ações de alto risco |
| Log de auditoria completo | Seu PostgreSQL | Cada mensagem, cada ação, persistida no seu servidor |
| Suporte multi-agente | Qualquer máquina de funcionário | Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode, mais **Computer** (invólucros ZeroClaw / OpenClaw a partir de **1 de junho de 2026**) — tudo em um hub |
| Custo mensal zero | Sua infraestrutura | Você é dono do servidor, dos dados e das chaves |

> **Quer ir além?** Explore esta documentação:
> - [Business Overview](docs/business/README.md) — Valor estratégico para fundadores
> - [Value Proposition](docs/business/value-proposition.md) — Benefícios detalhados
> - [Methodology](docs/methodology/README.md) — Guia de implementação
> - [Enterprise Features](docs/enterprise/README.md) — Para organizações em escala

---

## Próximos passos

| O que você quer fazer | Onde ir |
|------------------------|---------|
| Implantar em um servidor real com HTTPS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| Configurar chaves LLM (Vertex, OpenRouter, DeepInfra, ElevenLabs...) | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Adicionar mais máquinas de funcionários | Compartilhe este doc + seu `NEST_API_URL` + o token |
| Entender modos de agente OpenClaw / ZeroClaw | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Valor de negócio para fundadores | [docs/business/README.md](docs/business/README.md) |
| Metodologia de implementação | [docs/methodology/README.md](docs/methodology/README.md) |
| Referência completa de variáveis de ambiente | [README.md](README.md) |
| Ver o que vem por aí | [ROADMAP.md](ROADMAP.md) |
| Consultar o changelog | [RELEASES.md](RELEASES.md) |

---

## Solução de problemas — Correções rápidas

| Problema | Correção |
|----------|----------|
| `annie` não encontrado após instalar | Execute `npm install -g @contextzero/nest` de novo; verifique seu `$PATH` |
| App web em branco / não carrega | Espere 30s pela inicialização do BD; execute `docker compose logs nest-server` |
| `401 Unauthorized` no CLI | Token incorreto — o `setup.sh` gera automaticamente. Execute `grep CLI_API_TOKEN .env` para ver seu token. |
| Porta 80 já em uso | Defina `WEB_PORT=8080` no `.env`, depois `docker compose restart` |
| Sessão não aparece no dashboard | Confirme que `NEST_API_URL` no CLI aponta para o endereço correto do servidor |
| Outro problema | Execute `annie diagnose` — imprime um relatório de diagnóstico completo |

---

> **Você está executando um hub de força de trabalho IA nível enterprise. De graça. Na sua própria infraestrutura.**
> 
> Quando quiser ir além — HTTPS, várias equipes, roteamento LLM customizado — está tudo em [docs/DEVOPS.md](docs/DEVOPS.md) e [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribuição pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
