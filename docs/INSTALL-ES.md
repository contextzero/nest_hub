<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

[English](./INSTALL.md) | **Español** | [中文](./INSTALL-ZH.md) | [Deutsch](./INSTALL-DE.md) | [Português](./INSTALL-PT.md) | [Français](./INSTALL-FR.md)

# NEST — Guía completa de instalación

**Por Context Zero.** Plataforma de automatización de fuerza laboral self-hosted — nivel empresarial.

Esta guía pone en marcha el stack completo de NEST — servidor, base de datos, aplicación web y CLI — usando imágenes públicas de Docker. Sin conocimientos de Rust, sin compilar desde el código fuente, sin cuenta en la nube.

> **¿Poco tiempo?** → [QUICKSTART.md](../QUICKSTART.md) te deja operativo en 5 minutos solo con los pasos esenciales.
> Esta guía es la referencia completa — cada opción, cada flag, cada vía de resolución de problemas.

---

## Qué se instala

| Componente | Cómo llega | Qué hace |
|-----------|---------------|--------------|
| **NEST Server** | Docker descarga `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker descarga `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker descarga `postgres:16-alpine` | Persiste todas las sesiones, mensajes y eventos de auditoría en un volumen con nombre |
| **nginx** | Docker descarga `nginx:alpine` | Punto de entrada único en el puerto 80 — enruta `/api/*`, `/ws/*`, SSE y PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | Ejecuta sesiones de agente en las máquinas de los empleados; se conecta a tu servidor |

**Cero compilación.** Docker descarga la imagen del servidor ya construida. `npm` descarga la CLI ya construida. Todo el stack queda en marcha en menos de 2 minutos en cualquier máquina con Docker y Node.

---

## Requisitos previos

Dos máquinas, dos requisitos:

| Máquina | Necesita |
|---------|-------|
| **Máquina servidor** (aloja el stack) | Docker + Docker Compose |
| **Máquinas de empleados** (ejecutan agentes) | Node.js 18+ y npm |

La máquina servidor y una máquina de empleado pueden ser la misma durante la configuración — es el flujo habitual de desarrollo local.

**¿Aún no los tienes?** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) cubre todos los sistemas operativos.

---

## Parte 1 — Configuración del servidor

### Paso 1.1 — Clonar y ejecutar el setup

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

El script de setup genera un `CLI_API_TOKEN` seguro, crea tu `.env` e inicia el stack completo. Sigue las indicaciones — todo el proceso lleva menos de 2 minutos.

Cuando termine, abre **http://localhost** en el navegador. Deberías ver la aplicación web de NEST. Si carga — tu servidor está operativo por completo.

### Paso 1.2 — Comprobar que el servidor está en marcha

```bash
docker compose ps
```

Los cuatro contenedores deberían mostrar `Up` o `healthy`:

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Ver los logs de arranque:

```bash
docker compose logs -f
```

Estás listo cuando veas que el health check de nest-server pasa. Busca una línea como:
```
nest-server  | Server listening on 0.0.0.0:3000
```

### Avanzado: configuración manual

Si prefieres configurar `.env` a mano en lugar de usar `./setup.sh`:

```bash
cp .env.example .env
```

Abre `.env` en cualquier editor de texto. El único valor obligatorio es `CLI_API_TOKEN`:

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

**El `.env` mínimo viable para uso local:**
```env
CLI_API_TOKEN=paste-your-generated-token-here
```

Todo lo demás tiene valores por defecto razonables para despliegue local.

> **Nota de seguridad:** `CLI_API_TOKEN` es la única clave que conecta las CLI de tu equipo con tu servidor. Genera el valor con `openssl rand -hex 32`. Nunca hagas commit de `.env` al control de versiones.

Luego inicia el stack:

```bash
docker compose up -d
```

Docker descargará cuatro imágenes en la primera ejecución (lleva 1–2 minutos según tu conexión). Los arranques posteriores son instantáneos.

---

## Parte 2 — Configuración de la CLI

Haz esto en **cada máquina** donde un empleado vaya a ejecutar sesiones de agente.

### Paso 2.1 — Instalación

```bash
npm install -g @contextzero/nest
```

Comprobación:

```bash
annie --help
```

Deberías ver la lista completa de comandos. Si no se encuentra `annie`, consulta [Problemas frecuentes](#common-issues) más abajo.

### Paso 2.2 — Conectar con tu servidor

Tienes dos opciones:

**Opción A — Login interactivo (se guarda de forma permanente, recomendado)**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

Las credenciales se guardan en `~/.nest/config`. Cada comando `annie` posterior las usa automáticamente — no hace falta variables de entorno por sesión.

**Opción B — Variables de entorno (útil para CI/CD o scripts)**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**Comprobar la conexión:**

```bash
annie auth status
```

Debería mostrar la URL de tu servidor y confirmar que el token está definido. Si muestra un error, consulta [Problemas frecuentes](#common-issues).

### Paso 2.3 — Iniciar tu primera sesión de agente

Paquete: **`npm install -g @contextzero/nest`** → **`annie`**. Referencia de comandos: [enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md).

```bash
annie claude     # Claude Code — agente de código de Anthropic
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini (vía ACP)
annie opencode   # OpenCode — agente open source
annie kilocode   # KiloCode — ejecución de tareas con control de aprobación
annie computer   # Computer — agente multi-herramienta en el hub (shell, navegador, archivos)
```

**Automatización:** si el primer argumento no es un subcomando conocido, la CLI se comporta como **`annie cursor`**. En scripts y CI usa siempre un subcomando explícito (`annie claude`, `annie computer`, …).

**ZeroClaw / OpenClaw** estarán disponibles **dentro de `annie computer`** como envoltorios (mismo patrón que Claude, Cursor, …) a partir del **1 de junio de 2026**—no como subcomandos `annie` aparte. Ver [enterprise/zeroclaw.md](enterprise/zeroclaw.md) y [RELEASES.md](../RELEASES.md).

Cuando arranque una sesión, abre **http://localhost** en el navegador (o en el móvil). La sesión aparece en el panel en tiempo real.

---

## Referencia de puertos

| Puerto en el host | Servicio | Notas |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | Cambia con `WEB_PORT` en `.env` |
| `5433` | PostgreSQL (optional host exposure) | Pon `PGPORT=` (vacío) para mantenerlo solo interno |

Todo el tráfico de API, Socket.IO y SSE pasa por nginx en el puerto 80. No hace falta abrir puertos adicionales para el funcionamiento básico.

---

## Comandos de gestión del servidor

Ejecútalos desde el directorio `nest_hub/`:

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

<h2 id="common-issues">Problemas frecuentes</h2>

| Síntoma | Causa | Solución |
|---------|-------|-----|
| `annie: command not found` | El binario global de npm no está en PATH | Ejecuta `npm bin -g` para ver la ruta y añádela a `$PATH`. O usa nvm — ver [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| `401 Unauthorized` from CLI | El token no coincide | Confirma que `CLI_API_TOKEN` en `.env` coincide exactamente con `~/.nest/config` o tu `export`. Sin comillas ni espacios |
| Web app blank / 502 Bad Gateway | El servidor aún está arrancando | Espera 30 s, luego ejecuta `docker compose logs nest-server`. Busca la línea en la que pasa el health check |
| Port 80 already in use | Otro servicio usa el puerto 80 | Pon `WEB_PORT=8080` en `.env`, luego `docker compose restart` |
| `docker compose` not found | Docker Compose V1 instalado | Actualiza Docker Desktop o instala `docker-compose-plugin`. NEST usa V2 (`docker compose`, no `docker-compose`) |
| Postgres connection errors | La base de datos se está inicializando | La primera inicialización tarda ~10 s. Espera y reintenta. Revisa logs con `docker compose logs postgres` |
| Session not appearing in dashboard | `NEST_API_URL` incorrecta | La URL que muestra `annie auth status` debe coincidir con la dirección real del servidor (no `localhost` si te conectas desde otra máquina) |

**¿Sigues atascado?** Ejecuta `annie diagnose` en la máquina donde está instalada la CLI. Imprime un informe completo de diagnóstico de conectividad y autenticación.

---

## Despliegue en producción

Para un despliegue NEST expuesto a Internet (equipo remoto, HTTPS, dominio propio):

1. Define `NEST_PUBLIC_URL=https://nest.yourdomain.com` en `.env`
2. Configura la terminación TLS en nginx (o un balanceador delante)
3. Usa un `POSTGRES_PASSWORD` fuerte y deja `PGPORT` vacío (no expongas Postgres al exterior)
4. Rota `CLI_API_TOKEN` con `openssl rand -hex 32` — luego actualiza todas las CLI de los empleados con `annie auth login`

Referencia completa de producción: [DEVOPS.md](DEVOPS.md)

---

## Próximos pasos

| Qué quieres hacer | Dónde ir |
|---------------------|-------------|
| Resumen de instalación en 5 minutos | [QUICKSTART.md](../QUICKSTART.md) |
| Instalar Node, Docker, Rust | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| Configurar claves de LLM (Vertex, OpenRouter, DeepInfra...) | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| Producción, HTTPS, URL pública | [DEVOPS.md](DEVOPS.md) |
| Valor de negocio para fundadores | [business/README.md](business/README.md) |
| Metodología de implementación | [methodology/README.md](methodology/README.md) |
| Funciones enterprise | [enterprise/README.md](enterprise/README.md) |
| Referencia de todos los comandos y configuración | [README.md](../README.md) |
| Próximas novedades | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribución pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
