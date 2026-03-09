# NEST Terminal

Repositorio para usar el **CLI de NEST** y ejecutar el **servidor (hub)** en Docker. Incluye branding (logo y *powered by facta.dev*) en `public/`.

## Requisitos

- **CLI:** [NEST CLI](https://github.com/ctx0/nest#instalación-cli) instalado en tu máquina (para sesiones locales).
- **Servidor:** Docker y Docker Compose (para levantar el hub).

## Uso del CLI

El CLI se instala y usa desde el [repositorio principal NEST](https://github.com/ctx0/nest).

1. Instala el CLI (según tu SO):
   ```bash
   # macOS / Linux
   curl -fsSL https://nest.ctx0.io/install | bash

   # O con npm/bun desde el repo nest
   cd /ruta/a/nest && bun install && bun run build:cli
   ```

2. Configura el token y la URL del hub (el servidor que levantes con Docker):
   ```bash
   export CLI_API_TOKEN="tu-token-secreto"
   export NEST_API_URL="http://localhost:3006"
   # Opcional: guardar token
   nest auth login
   ```

3. Ejecuta una sesión:
   ```bash
   nest              # Claude Code
   nest codex        # Codex
   nest cursor       # Cursor Agent
   nest gemini       # Gemini
   nest opencode     # OpenCode
   ```

4. Abre la web en el navegador (o PWA/Telegram) en `http://localhost:3006` para ver y controlar las sesiones.

## Servidor con Docker

Este repo permite levantar el hub NEST en Docker para que cualquier cliente (CLI o web) se conecte.

### Variables de entorno

Copia el ejemplo y ajusta:

```bash
cp .env.example .env
# Edita .env con tu CLI_API_TOKEN y, si usas Telegram, NEST_PUBLIC_URL y TELEGRAM_BOT_TOKEN
```

### Levantar el servidor

```bash
docker compose up -d
```

El hub queda en **http://localhost:3006**. La web se sirve en la misma URL.

### Parar el servidor

```bash
docker compose down
```

### Reconstruir la imagen (tras cambios en NEST o en `public/`)

```bash
docker compose build --no-cache
docker compose up -d
```

### Build con otro repositorio NEST

Por defecto la imagen clona `https://github.com/ctx0/nest.git`. Para usar otro repo o rama:

```bash
docker build --build-arg NEST_REPO=https://github.com/tu-org/nest.git --build-arg NEST_REF=main -t nest-terminal-hub .
```

## Branding (`public/`)

La carpeta `public/` de este repo se copia dentro del servidor para servir:

- **Logo:** `icon.svg`, `mask-icon.svg`, `facta.svg`, `facta_isotype.svg`
- Disponibles en la web en `/public/` (por ejemplo `/public/facta.svg`).

*Powered by [facta.dev](https://facta.dev).*

## Estructura del repo

```
ctx0_nest_terminal/
├── README.md           # Este archivo
├── Dockerfile          # Imagen del hub NEST + web + public
├── docker-compose.yml  # Servicio hub + volúmenes
├── .env.example       # Plantilla de variables de entorno
└── public/             # Logo y assets de facta.dev
    ├── icon.svg
    ├── mask-icon.svg
    ├── facta.svg
    └── facta_isotype.svg
```

## Resumen de flujo

1. **Servidor:** `docker compose up -d` en este repo → hub en `http://localhost:3006`.
2. **CLI:** En otra terminal, `export CLI_API_TOKEN=...` y `export NEST_API_URL=http://localhost:3006`, luego `nest` (o `nest codex`, etc.).
3. **Web:** Abre `http://localhost:3006` en el navegador para listar sesiones, chatear y aprobar permisos.

---

*Powered by [facta.dev](https://facta.dev).*
