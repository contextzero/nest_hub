<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

[English](./INSTALL.md) | [Español](./INSTALL-ES.md) | [中文](./INSTALL-ZH.md) | [Deutsch](./INSTALL-DE.md) | **Português** | [Français](./INSTALL-FR.md)

# NEST — Guia completo de instalação

**Por Context Zero.** Plataforma de automação da força de trabalho self-hosted — nível empresarial.

Este guia coloca em execução o stack completo do NEST — servidor, base de dados, aplicação web e CLI — usando imagens públicas do Docker. Sem conhecimento de Rust, sem compilar a partir do código-fonte, sem conta na nuvem.

> **Sem tempo?** → [QUICKSTART.md](../QUICKSTART.md) deixa tudo no ar em 5 minutos só com os passos essenciais.
> Este guia é a referência completa — cada opção, cada flag, cada caminho de resolução de problemas.

---

## O que é instalado

| Componente | Como chega | O que faz |
|-----------|---------------|--------------|
| **NEST Server** | Docker puxa `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker puxa `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker puxa `postgres:16-alpine` | Persiste todas as sessões, mensagens e eventos de auditoria num volume nomeado |
| **nginx** | Docker puxa `nginx:alpine` | Ponto de entrada único na porta 80 — encaminha `/api/*`, `/ws/*`, SSE e PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | Executa sessões de agente nas máquinas dos colaboradores; liga-se ao seu servidor |

**Zero compilação.** O Docker obtém a imagem do servidor já construída. O `npm` obtém a CLI já construída. O stack inteiro fica no ar em menos de 2 minutos em qualquer máquina com Docker e Node.

---

## Pré-requisitos

Duas máquinas, dois requisitos:

| Máquina | Precisa de |
|---------|-------|
| **Máquina servidor** (hospeda o stack) | Docker + Docker Compose |
| **Máquinas dos colaboradores** (executam agentes) | Node.js 18+ e npm |

A máquina servidor e uma máquina de colaborador podem ser a mesma durante a configuração — esse é o fluxo habitual de desenvolvimento local.

**Ainda não tem isso?** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) cobre todos os sistemas operativos.

---

## Parte 1 — Configuração do servidor

### Passo 1.1 — Clonar e executar o setup

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

O script de setup gera um `CLI_API_TOKEN` seguro, cria o seu `.env` e inicia o stack completo. Siga as instruções — todo o processo leva menos de 2 minutos.

Quando terminar, abra **http://localhost** no navegador. Deve ver a aplicação web do NEST. Se carregar — o servidor está totalmente operacional.

### Passo 1.2 — Verificar se o servidor está em execução

```bash
docker compose ps
```

Os quatro contentores devem mostrar `Up` ou `healthy`:

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Acompanhar os logs de arranque:

```bash
docker compose logs -f
```

Está pronto quando vir o health check do nest-server a passar. Procure uma linha como:
```
nest-server  | Server listening on 0.0.0.0:3000
```

### Avançado: configuração manual

Se preferir configurar o `.env` manualmente em vez de usar `./setup.sh`:

```bash
cp .env.example .env
```

Abra o `.env` em qualquer editor de texto. O único valor obrigatório é `CLI_API_TOKEN`:

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

**O `.env` mínimo viável para uso local:**
```env
CLI_API_TOKEN=paste-your-generated-token-here
```

Tudo o resto tem valores por omissão adequados para implantação local.

> **Nota de segurança:** `CLI_API_TOKEN` é a única chave que liga as CLIs da sua equipa ao servidor. Gere-o com `openssl rand -hex 32`. Nunca faça commit do `.env` ao controlo de versões.

Depois inicie o stack:

```bash
docker compose up -d
```

O Docker irá puxar quatro imagens na primeira execução (demora 1–2 minutos conforme a sua ligação). Arranques seguintes são instantâneos.

---

## Parte 2 — Configuração da CLI

Faça isto em **cada máquina** onde um colaborador vá executar sessões de agente.

### Passo 2.1 — Instalação

```bash
npm install -g @contextzero/nest
```

Verificação:

```bash
annie --help
```

Deve ver a lista completa de comandos. Se `annie` não for encontrado, veja [Problemas comuns](#common-issues) abaixo.

### Passo 2.2 — Ligar ao seu servidor

Tem duas opções:

**Opção A — Login interativo (guarda de forma permanente, recomendado)**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

As credenciais são guardadas em `~/.nest/config`. Cada comando `annie` seguinte usa-as automaticamente — sem variáveis de ambiente por sessão.

**Opção B — Variáveis de ambiente (útil para CI/CD ou scripts)**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**Verificar a ligação:**

```bash
annie auth status
```

Deve imprimir o URL do servidor e confirmar que o token está definido. Se mostrar erro, veja [Problemas comuns](#common-issues).

### Passo 2.3 — Iniciar a primeira sessão de agente

Pacote: **`npm install -g @contextzero/nest`** → **`annie`**. Referência de comandos: [enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md).

```bash
annie claude     # Claude Code — agente de código Anthropic
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini (via ACP)
annie opencode   # OpenCode — agente open source
annie kilocode   # KiloCode — execução de tarefas com controlo de aprovação
annie computer   # Computer — agente multi-ferramenta no hub (shell, navegador, ficheiros)
```

**Automação:** se o primeiro argumento não for um subcomando conhecido, a CLI comporta-se como **`annie cursor`**. Em scripts e CI use sempre um subcomando explícito (`annie claude`, `annie computer`, …).

**ZeroClaw / OpenClaw** ficarão disponíveis **dentro de `annie computer`** como invólucros (o mesmo padrão que Claude, Cursor, …) a partir de **1 de junho de 2026**—não como subcomandos `annie` separados. Ver [enterprise/zeroclaw.md](enterprise/zeroclaw.md) e [RELEASES.md](../RELEASES.md).

Quando uma sessão iniciar, abra **http://localhost** no navegador (ou no telemóvel). A sessão aparece no painel em tempo real.

---

## Referência de portas

| Porta no host | Serviço | Notas |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | Altere com `WEB_PORT` no `.env` |
| `5433` | PostgreSQL (optional host exposure) | Defina `PGPORT=` (vazio) para manter só interno |

Todo o tráfego de API, Socket.IO e SSE passa pelo nginx na porta 80. Não é necessário abrir portas adicionais para o funcionamento básico.

---

## Comandos de gestão do servidor

Execute-os a partir do directório `nest_hub/`:

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

<h2 id="common-issues">Problemas comuns</h2>

| Sintoma | Causa | Solução |
|---------|-------|-----|
| `annie: command not found` | O bin global do npm não está no PATH | Execute `npm bin -g` para ver o caminho e adicione-o ao `$PATH`. Ou use nvm — ver [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| `401 Unauthorized` from CLI | O token não corresponde | Confirme que `CLI_API_TOKEN` no `.env` coincide exatamente com `~/.nest/config` ou o seu `export`. Sem aspas nem espaços |
| Web app blank / 502 Bad Gateway | O servidor ainda está a arrancar | Espere 30 s, depois execute `docker compose logs nest-server`. Procure a linha em que o health check passa |
| Port 80 already in use | Outro serviço na porta 80 | Defina `WEB_PORT=8080` no `.env`, depois `docker compose restart` |
| `docker compose` not found | Docker Compose V1 instalado | Atualize o Docker Desktop ou instale `docker-compose-plugin`. NEST usa V2 (`docker compose`, não `docker-compose`) |
| Postgres connection errors | A base de dados está a inicializar | A primeira inicialização demora ~10 s. Espere e tente de novo. Veja os logs com `docker compose logs postgres` |
| Session not appearing in dashboard | `NEST_API_URL` errado | O URL mostrado por `annie auth status` deve coincidir com o endereço real do servidor (não `localhost` se ligar de outra máquina) |

**Ainda bloqueado?** Execute `annie diagnose` na máquina onde a CLI está instalada. Imprime um relatório completo de diagnóstico de conectividade e autenticação.

---

## Implantação em produção

Para uma implantação NEST voltada ao público (equipa remota, HTTPS, domínio próprio):

1. Defina `NEST_PUBLIC_URL=https://nest.yourdomain.com` no `.env`
2. Configure a terminação TLS no nginx (ou um balanceador à frente)
3. Use um `POSTGRES_PASSWORD` forte e mantenha `PGPORT` vazio (não exponha o Postgres externamente)
4. Renove o `CLI_API_TOKEN` com `openssl rand -hex 32` — depois atualize todas as CLIs dos colaboradores com `annie auth login`

Referência completa de produção: [DEVOPS.md](DEVOPS.md)

---

## Próximos passos

| O que pretende fazer | Onde ir |
|---------------------|-------------|
| Resumo de instalação em 5 minutos | [QUICKSTART.md](../QUICKSTART.md) |
| Instalar Node, Docker, Rust | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| Configurar chaves de LLM (Vertex, OpenRouter, DeepInfra...) | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| Produção, HTTPS, URL pública | [DEVOPS.md](DEVOPS.md) |
| Valor de negócio para fundadores | [business/README.md](business/README.md) |
| Metodologia de implementação | [methodology/README.md](methodology/README.md) |
| Funcionalidades enterprise | [enterprise/README.md](enterprise/README.md) |
| Referência de todos os comandos e configuração | [README.md](../README.md) |
| O que vem a seguir | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribuição pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
