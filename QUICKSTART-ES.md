<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Unirse-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Unirse-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Inicio rápido

[English](./QUICKSTART.md) | **Español** | [中文](./QUICKSTART-ZH.md) | [Deutsch](./QUICKSTART-DE.md) | [Português](./QUICKSTART-PT.md) | [Français](./QUICKSTART-FR.md)

**Por Context Zero.** Plataforma de automatización de fuerza laboral self-hosted — nivel enterprise.
De cero a un hub de fuerza laboral IA en vivo en menos de 5 minutos.

---

## Antes de empezar — Qué tendrás cuando termines

En los próximos 5 minutos:

1. ✅ Desplegarás el servidor NEST (Rust + Postgres + nginx) localmente con **un solo comando**
2. ✅ Instalarás el CLI `annie` en cualquier máquina
3. ✅ Iniciarás tu primera sesión real de agente IA (Claude Code, Codex, Cursor, Gemini, OpenCode o KiloCode; y desde el **1 de junio de 2026**, ZeroClaw / OpenClaw **vía `annie computer`**)
4. ✅ La verás **en vivo desde el navegador** — y desde el teléfono

No necesitas conocimientos previos de Rust. No hace falta cuenta en la nube. No tarjeta de crédito. Si Docker corre en tu máquina, NEST corre en tu máquina.

---

## Paso 0 — Requisitos previos (2 minutos si los necesitas)

Necesitas tres cosas. Comprueba cada una:

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**¿Pasaron las cuatro?** Salta al Paso 1.

**¿Falta algo?** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — instala Node, npm y Docker en minutos en Mac, Linux o Windows.

> **¿Por qué estos?** Node + npm alimentan el CLI `annie` que instalarás en las máquinas de los empleados. Docker ejecuta el servidor sin que tú instales Rust, Postgres o nginx manualmente.

---

## Paso 1 — Desplegar el Hub (60 segundos)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

Eso es todo. `setup.sh` genera automáticamente todos los secretos, descarga imágenes Docker, arranca el stack y espera al health check. Cuando veas:

```
=== NEST ready ===
  Web:  http://localhost
```

Tu hub está en vivo. Ábrelo en el navegador — y en el teléfono.

> **¿Qué acaba de pasar?** `setup.sh` creó un `.env` con `POSTGRES_PASSWORD`, `CLI_API_TOKEN` y `ENCRYPTION_KEY` auto-generados. Luego descargó e inició cuatro contenedores: `nest-server` (Rust), `nest-web` (React PWA), `postgres` y `nginx`.

---

## Paso 2 — Instalar el CLI en cualquier máquina (30 segundos)

El CLI `annie` es lo que instalan tus empleados (o tú) en las máquinas donde corren los agentes IA. Instálalo globalmente:

```bash
npm install -g @contextzero/nest
```

Confirma que funciona:

```bash
annie --help
```

Deberías ver la lista completa de comandos. El CLI ya está listo en esta máquina.

> **Una instalación por máquina.** Cada persona que vaya a ejecutar sesiones de agente debe instalar `annie` en su propia máquina y apuntarlo a tu servidor.

---

## Paso 3 — Conectar a tu servidor (30 segundos)

Tienes dos opciones — elige una:

**Opción A: Variables de entorno (ideal para scripts y CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **¿Dónde está tu token?** `setup.sh` lo guardó en `.env`. Ejecuta: `grep CLI_API_TOKEN .env` para verlo.

**Opción B: Login interactivo (guarda las credenciales de forma permanente)**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

Verifica la conexión:

```bash
annie auth status
```

Deberías ver la URL del servidor y un token confirmado. **Estás autenticado.**

---

## Paso 4 — Iniciar tu primera sesión de agente

Elige tu agente y ejecuta un comando (paquete **`@contextzero/nest`** → **`annie`**). **Referencia enterprise:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md).

| Agente | Comando | Qué hace |
|--------|---------|----------|
| **Claude Code** | `annie claude` | Agente de código insignia de Anthropic |
| **Codex** | `annie codex` | Agente de ejecución de código de OpenAI |
| **Cursor** | `annie cursor` | Modo agente del IDE Cursor |
| **Gemini** | `annie gemini` | Agente multimodal de Google |
| **OpenCode** | `annie opencode` | Agente de código open source |
| **KiloCode** | `annie kilocode` | Ejecución de tareas + control remoto |
| **Computer (gestión)** | `annie computer` | Agente multi-herramienta en el hub (shell, navegador, archivos) |

> **ZeroClaw / OpenClaw:** desde el **1 de junio de 2026** van **dentro de `annie computer`** como envoltorios (mismo patrón que Claude, Cursor, …). No son subcomandos `annie` independientes. Ver [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) y [RELEASES.md](RELEASES.md).

**Automatización:** si el primer argumento no es un subcomando reconocido, la CLI lo trata como **`annie cursor`**. Usa siempre `annie claude`, `annie computer`, etc., sobre todo en CI.

Ejemplo — iniciar Claude Code:

```bash
annie claude
```

La terminal mostrará la sesión conectándose y transmitiendo. **No cierres esta terminal.** El agente está en vivo.

---

## Paso 5 — Tu momento eureka 🎯

Cambia al navegador (o al teléfono) y abre:

```
http://localhost
```

**Ahora deberías ver la sesión en vivo en el dashboard.**

Desde aquí puedes:
- 💬 **Chatear** con el agente en ejecución en tiempo real
- ✅ **Aprobar o rechazar** solicitudes de permiso del agente
- 🖥️ **Ver la salida del terminal** mientras ejecuta
- 📱 **Hacer todo esto desde el teléfono** — la PWA funciona en cualquier navegador móvil

Este es el momento. Acabas de convertir una sesión CLI en el portátil de alguien en una **sesión IA visible de forma remota, aprobable y auditable** que puedes supervisar desde cualquier sitio.

---

## Referencia rápida — Comandos más útiles

```bash
annie claude            # Sesión Claude Code
annie codex             # Sesión Codex
annie cursor            # Agente Cursor
annie gemini            # Sesión Gemini
annie opencode          # Sesión OpenCode
annie kilocode          # Sesión KiloCode
annie computer          # Agente multi-herramienta (gestión)
annie worker start      # Worker en segundo plano
annie worker list       # Sesiones activas del worker
annie auth login        # Guardar credenciales
annie auth status       # Estado de autenticación
annie diagnose          # Diagnóstico
```

**Gestión del servidor (desde la carpeta `nest_hub/`):**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## Qué acaba de pasar — Y por qué importa

Ahora tienes:

| Qué | Dónde | Por qué importa |
|-----|-------|-----------------|
| Dashboard de sesiones en vivo | Navegador / teléfono | Ver cada sesión de agente que ejecuta tu equipo, en tiempo real |
| Flujo de aprobación | PWA móvil | Los agentes esperan tu OK antes de acciones de alto riesgo |
| Registro de auditoría completo | Tu PostgreSQL | Cada mensaje, cada acción, persistido en tu servidor |
| Soporte multi-agente | Cualquier máquina de empleado | Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode, más **Computer** (envoltorios ZeroClaw / OpenClaw desde el **1 de junio de 2026**) — todo en un hub |
| Coste mensual cero | Tu infraestructura | Tú eres dueño del servidor, los datos y las claves |

> **¿Listo para más?** Explora esta documentación:
> - [Business Overview](docs/business/README.md) — Valor estratégico para fundadores
> - [Value Proposition](docs/business/value-proposition.md) — Beneficios detallados
> - [Methodology](docs/methodology/README.md) — Guía de implementación
> - [Enterprise Features](docs/enterprise/README.md) — Para organizaciones que escalan

---

## Próximos pasos

| Qué quieres hacer | Dónde ir |
|-------------------|----------|
| Desplegar en un servidor real con HTTPS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| Configurar claves LLM (Vertex, OpenRouter, DeepInfra, ElevenLabs...) | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Añadir más máquinas de empleados | Comparte este doc + tu `NEST_API_URL` + el token |
| Entender los modos de agente OpenClaw / ZeroClaw | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Valor de negocio para fundadores | [docs/business/README.md](docs/business/README.md) |
| Metodología de implementación | [docs/methodology/README.md](docs/methodology/README.md) |
| Referencia completa de variables de entorno | [README.md](README.md) |
| Ver qué viene | [ROADMAP.md](ROADMAP.md) |
| Consultar el changelog | [RELEASES.md](RELEASES.md) |

---

## Solución de problemas — Arreglos rápidos

| Problema | Solución |
|-----------|----------|
| No se encuentra `annie` tras instalar | Ejecuta de nuevo `npm install -g @contextzero/nest`; comprueba tu `$PATH` |
| La web en blanco / no carga | Espera 30s a la inicialización de la BD; ejecuta `docker compose logs nest-server` |
| `401 Unauthorized` en el CLI | Token incorrecto — `setup.sh` lo genera automáticamente. Ejecuta `grep CLI_API_TOKEN .env` para ver tu token. |
| El puerto 80 ya está en uso | Pon `WEB_PORT=8080` en `.env`, luego `docker compose restart` |
| La sesión no aparece en el dashboard | Confirma que `NEST_API_URL` en el CLI apunta a la dirección correcta del servidor |
| Algo más va mal | Ejecuta `annie diagnose` — imprime un informe de diagnóstico completo |

---

> **Estás ejecutando un hub de fuerza laboral IA de nivel enterprise. Gratis. En tu propia infraestructura.**
> 
> Cuando quieras ir más allá — HTTPS, varios equipos, enrutamiento LLM personalizado — todo está en [docs/DEVOPS.md](docs/DEVOPS.md) y [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribución pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
