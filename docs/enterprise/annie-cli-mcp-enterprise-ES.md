<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Guía Enterprise — CLI Annie, MCP e integración multi-cliente

[Español](./annie-cli-mcp-enterprise-ES.md) | [English](./annie-cli-mcp-enterprise.md) | [Deutsch](./annie-cli-mcp-enterprise-DE.md) | [Português](./annie-cli-mcp-enterprise-PT.md) | [Français](./annie-cli-mcp-enterprise-FR.md) | [中文](./annie-cli-mcp-enterprise-ZH.md)

Este documento es la referencia **de nivel enterprise** para desplegar **Annie** (CLI `@contextzero/nest`), usar **todas las superficies de comando soportadas** e integrar **NEST MCP** con ChatGPT, Claude, Cursor y VS Code.

**Nota sobre lenguajes de programación:** NEST es **agnóstico** respecto a los lenguajes de tus repositorios (Python, TypeScript, Rust, Go, Java, .NET, etc.). Las sesiones se vinculan a una **ruta de workspace** y a un **id de sesión en el servidor**, no a un único runtime.

**Idiomas del documento:** Esta guía se publica en **seis lenguas naturales** (EN, ES, DE, FR, PT, ZH) con la **misma estructura por fases** en cada archivo.

---

## Índice

1. [Resumen ejecutivo](#1-resumen-ejecutivo)
2. [Modelo de fases en una vista](#2-modelo-de-fases-en-una-vista)
3. [Fases del flujo de ingeniería CTO](#3-fases-del-flujo-de-ingeniería-cto)
4. [Fases de implementación NEST 0–6](#4-fases-de-implementación-nest-06)
5. [Fases de madurez técnica MCP (M1–M4)](#5-fases-de-madurez-técnica-mcp-m1m4)
6. [Fases de despliegue operativo (P0–P4)](#6-fases-de-despliegue-operativo-p0p4)
7. [Arquitectura resumida](#7-arquitectura-resumida)
8. [CLI (`@contextzero/nest`) — referencia de comandos](#section-8-cli-es)
9. [Configuración y reglas de URL](#9-configuración-y-reglas-de-url)
10. [MCP — protocolo, seguridad y endpoints](#10-mcp--protocolo-seguridad-y-endpoints)
11. [Patrones por cliente](#11-patrones-por-cliente)
12. [Riesgo, validación y gobernanza](#12-riesgo-validación-y-gobernanza)
13. [Documentos relacionados](#13-documentos-relacionados)

---

## 1. Resumen ejecutivo

| Capa | Qué responde |
|------|--------------|
| **Flujo CTO** | *Cómo* pensamos antes de entregar (análisis → diseño → riesgo → implementación) |
| **Fases NEST 0–6** | *Cuándo* aterrizan infraestructura, agentes y gobernanza en la organización |
| **Fases MCP M1–M4** | *Cómo* evoluciona el MCP desde archivos locales seguros hasta proxy en servidor autenticado e IDEs externos |
| **Fases operativas P0–P4** | *Cómo* escalar del piloto a operación productiva |

**Requisitos no negociables para MCP enterprise**

1. **URL + Bearer** en `POST /mcp/sessions/<session_id>` — nunca solo «URL».
2. **Higiene Git** para `.cursor/mcp.json` y copias de seguridad — tratar como superficie de secretos local.
3. **Subcomandos CLI explícitos** en automatización (`annie claude`, no defaults ambiguos).

---

## 2. Modelo de fases en una vista

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Flujo CTO     Análisis → Diseño → Riesgo → Implementación               │
│       │                   (continuo; aplica en cada fase NEST)           │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6      Discovery → … → Operate   (ciclo de vida de plataforma)   │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4     Git seguro → Detección obsoleta → Proxy servidor → IDE ext.│
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4     Piloto → Estandarizar → Worker → Escala MCP → Operar      │
└─────────────────────────────────────────────────────────────────────────┘
```

**Cómo leer este documento:** Ejecuta las **fases NEST** en orden. En **fases 2–4**, incorpora como mínimo **MCP M1–M3** antes del despliegue masivo de IDEs. Usa **P0–P4** para secuenciar personas y carga de soporte. Aplica el **flujo CTO** en cada hito.

---

## 3. Fases del flujo de ingeniería CTO

Toma de decisiones estructurada (primeros principios, trade-offs, riesgo, validación). Úsala como **puerta de control** antes de cerrar cada fase NEST.

### Fase A — Análisis

| Elemento | Práctica |
|----------|----------|
| **Propósito** | Separar síntomas de requisitos; sacar supuestos ocultos |
| **Preguntas clave** | ¿Quién ejecuta el CLI? ¿Quién posee el servidor? ¿El MCP está en la superficie de ataque? ¿Qué datos salen del puesto? |
| **Entregables** | Mapa de partes interesadas, supuestos de amenaza, inventario de transportes MCP (stdio vs HTTP) por equipo |
| **Puerta de salida** | «Threat model MCP de una página» aprobado por seguridad o liderazgo técnico |

### Fase B — Diseño

| Elemento | Práctica |
|----------|----------|
| **Propósito** | Comparar opciones reales con trade-offs explícitos |
| **Opciones** | (1) Solo MCP local, (2) MCP proxificado con Bearer, (3) Puente stdio (`annie mcp`) para clientes heredados |
| **Matriz de trade-offs** | Seguridad vs comodidad; auditoría central vs latencia local; compatibilidad stdio vs HTTP nativo |
| **Puerta de salida** | Patrón elegido por perfil (portátil dev vs host runner vs IDE externo) |

### Fase C — Riesgo

| Elemento | Práctica |
|----------|----------|
| **Propósito** | Modos de fallo y rollback |
| **Ejemplos** | Fuga de token por `mcp.json` commiteado; URLs localhost huérfanas; superficie de herramientas MCP demasiado amplia |
| **Entregables** | Runbook de rollback (deshabilitar entrada MCP, rotar token, purgar caché) |
| **Puerta de salida** | Simulacro de rollback documentado y con responsable |

### Fase D — Implementación

| Elemento | Práctica |
|----------|----------|
| **Propósito** | Entregar con valores por defecto defensivos y observabilidad |
| **Prácticas** | Bearer obligatorio en MCP servidor; sin secretos en repo; logs en stderr en el puente stdio |
| **Puerta de salida** | Las comprobaciones del §12 pasan en el entorno objetivo |

---

## 4. Fases de implementación NEST 0–6

Alineado con la **[metodología NEST](../methodology/README.md)**.

### Fase 0 — Discovery

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Mapear equipos, agentes, IDEs; confirmar métricas de éxito |
| **Actividades Annie** | Inventariar quién necesita `annie claude` vs `annie cursor` vs `annie codex`; documentar SO y ruta de instalación |
| **Actividades MCP** | Listar equipos con Cursor HTTP vs VS Code vs Claude Desktop stdio |
| **Entregables** | Lista del piloto; inventario de IDEs; borrador de política «sin MCP sin auth» |
| **Puerta de salida** | Aprobación del sponsor del alcance del piloto |

### Fase 1 — Strategy

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Modelo de tokens, rutas de proxy, narrativa de cumplimiento |
| **Actividades Annie** | Decidir emisión de `CLI_API_TOKEN` (namespace por equipo si aplica); vault vs `annie auth login` |
| **Actividades MCP** | Nginx (o edge) debe reenviar **`/mcp/`** a Rust; documentar terminación TLS |
| **Entregables** | Diagrama de arquitectura; RACI de rotación de tokens |
| **Puerta de salida** | Revisión de seguridad de exposición de URL MCP (interno vs VPN vs público) |

### Fase 2 — Foundation

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Servidor listo para producción; secretos distribuidos |
| **Actividades Annie** | Estandarizar `NEST_API_URL` por entorno; verificar `annie auth status` en imágenes doradas |
| **Actividades MCP** | Completar **M1** (patrones gitignore) antes de adopción masiva de Cursor |
| **Entregables** | Runbook: «onboarding de nuevo portátil» |
| **Puerta de salida** | Health checks OK; sesión de muestra desde PWA |

### Fase 3 — Build

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Workers, configs de IDE, puentes |
| **Actividades Annie** | `annie worker start` en hosts designados; formación en `annie worker list` / `stop-session` |
| **Actividades MCP** | Completar **M2–M3** (detección de entradas obsoletas + MCP proxificado para sesiones runner) |
| **Entregables** | Plantilla `mcp.json` con `url` + `headers` (redactada); ejemplos de envoltorio stdio |
| **Puerta de salida** | Extremo a extremo: acción PWA → RPC → resultado de herramienta |

### Fase 4 — Hardening

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Refuerzo de auth, escaneo de secretos, formación |
| **Actividades Annie** | Imagen CI con versión fijada del CLI; `annie diagnose` en docs de soporte |
| **Actividades MCP** | Verificar **401** sin Bearer; hooks pre-commit para `mcp.json` |
| **Entregables** | Evidencias de pruebas de seguridad; macros de soporte |
| **Puerta de salida** | Checklist §12 al 100% en staging |

### Fase 5 — Launch

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Piloto → departamento → empresa con bucles de feedback |
| **Actividades Annie** | Medir fallos de creación de sesión, desconexiones del worker |
| **Actividades MCP** | Capturar versiones de clientes IDE; tickets específicos MCP |
| **Entregables** | Retrospectiva de lanzamiento; panel KPI |
| **Puerta de salida** | Revisión del sponsor frente a métricas |

### Fase 6 — Operate

| Dimensión | Detalle |
|-----------|---------|
| **Objetivos** | Operación estilo SRE, control de coste y riesgo |
| **Actividades Annie** | Comunicación trimestral de actualización del CLI; muestreo de logs |
| **Actividades MCP** | Calendario de rotación de tokens; revisión trimestral de herramientas expuestas |
| **Entregables** | Métricas operativas: tasas 4xx/5xx MCP, latencia RPC |
| **Puerta de salida** | Backlog de mejora continua con presupuesto |

**RACI orientativo (adaptar a tu organización)**

| Actividad | Ingeniería | Seguridad | IT / Desktop | Soporte |
|-----------|------------|-----------|--------------|---------|
| Emisión de token | C | A | I | I |
| Ruta nginx `/mcp/` | R | C | A | I |
| Runbooks MCP | R | C | I | A |
| Usuarios piloto | A | I | C | R |

*(R = responsable, A = accountable, C = consultado, I = informado)*

---

## 5. Fases de madurez técnica MCP (M1–M4)

### M1 — Git y seguridad en repositorio

| Elemento | Acción |
|----------|--------|
| **Meta** | Evitar commit accidental de config MCP inyectada |
| **Acciones** | `.gitignore` para `**/.cursor/mcp.json`, `**/.cursor/mcp.json.nest-backup`; formación |
| **Verificación** | CI con grep que falla si se trackea `mcp.json` |

### M2 — Detección de entradas obsoletas

| Elemento | Acción |
|----------|--------|
| **Meta** | Reducir URLs localhost rotas tras cierres inesperados |
| **Acciones** | Lógica de inyección Annie (comprobación de alcanzabilidad donde aplique); limpieza manual documentada |
| **Verificación** | Simular crash → siguiente arranque recupera o sobrescribe entrada obsoleta |

### M3 — MCP proxificado en servidor

| Elemento | Acción |
|----------|--------|
| **Meta** | Runner / Cursor remoto usa URL de servidor, no solo loopback |
| **Acciones** | Base API efectiva + `/mcp/sessions/<id>` + **Bearer**; proxy `/mcp/` en prod |
| **Verificación** | MCP funciona cuando Cursor y worker están en hosts distintos |

### M4 — Escala a IDE externo

| Elemento | Acción |
|----------|--------|
| **Meta** | VS Code, Claude Desktop, conectores ChatGPT (si aplica) con el mismo modelo de auth |
| **Acciones** | Plantillas estándar por cliente; automatización futura tipo `annie mcp install` según release |
| **Verificación** | Cliente no-Cursor pasa las mismas pruebas del §12 |

---

## 6. Fases de despliegue operativo (P0–P4)

Secuencia de personas y proceso (ortogonal a NEST 0–6 pero suele solaparse con fases 2–6).

### P0 — Piloto (5–20 usuarios)

| Tema | Detalle |
|------|---------|
| **Alcance** | Un modo de agente principal; una familia de IDE; MCP opcional pero Bearer obligatorio si está activo |
| **Duración** | Típicamente 2–4 semanas |
| **Métricas** | Tasa de éxito de sesión, cero incidentes de secretos, horas de soporte por usuario |
| **Salida** | Go / no-go a P1 |

### P1 — Estandarizar

| Tema | Detalle |
|------|---------|
| **Alcance** | `NEST_API_URL` dorada; `annie auth login` obligatorio o env distribuido por MDM |
| **MCP** | M1 completo en toda la org |
| **Salida** | Muestra de auditoría: 95%+ máquinas pasan `annie auth status` |

### P2 — Worker en producción

| Tema | Detalle |
|------|---------|
| **Alcance** | Hosts runner dedicados; guardia para `annie worker status` |
| **MCP** | M3 validado para spawn remoto |
| **Salida** | Demo de sesión remota desde PWA con entrada en log de auditoría |

### P3 — Escala MCP

| Tema | Detalle |
|------|---------|
| **Alcance** | MCP HTTP para Cursor; puente stdio para otros; runbooks publicados |
| **MCP** | Piloto M4 con segundo cliente (p. ej. VS Code) |
| **Salida** | Incidentes MCP auth con MTTR conocido |

### P4 — Operación en régimen

| Tema | Detalle |
|------|---------|
| **Alcance** | Rotación trimestral de tokens; política de fijación de versión del CLI |
| **Métricas** | Errores RPC, códigos HTTP MCP, reinicios del worker |
| **Salida** | Evidencia continua de cumplimiento |

---

## 7. Arquitectura resumida

```
Máquina del empleado                 Servidor NEST                      Clientes
─────────────────                    ─────────────                      ───────
annie <agente>  ── Socket.IO ──────►  Servidor Rust  ◄── SSE/REST ─────  Web PWA / Telegram
     │                               Postgres (auditoría)
     │                               POST /mcp/sessions/:sessionId
     ▼                                         ▲
Cursor / VS Code MCP  ── Streamable HTTP ─────┘
```

**Invariantes:** `CLI_API_TOKEN`; URL base efectiva; ruta **`/mcp/sessions/<session_id>`** con **Bearer**.

---

<a id="section-8-cli-es"></a>

## 8. CLI (`@contextzero/nest`) — referencia de comandos

Instalación: **`npm install -g @contextzero/nest`** → ejecutable **`annie`**. La **referencia canónica y más detallada** (modo Computer, terminales PTY remotas, resolución por defecto a `cursor`, `hook-forwarder`, etc.) está en la **versión en inglés**: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) — sin enlaces a repositorios privados.

**Envoltorios Computer (1 de junio de 2026):** **OpenClaw**, **ZeroClaw** y **Hermes** en **`annie computer`**. **Proyectos:** **gestión de proyectos — 1 de mayo de 2026** · **CRM — 15 de mayo de 2026** — [ROADMAP.md](../../ROADMAP.md) · detalle en **inglés** §8.3: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) · [zeroclaw.md](./zeroclaw.md).

| Área | Comando | Propósito |
|------|---------|-----------|
| Claude Code | `annie claude [args…]` | Claude Code + NEST |
| Cursor | `annie cursor [args…]` | Cursor Agent |
| Codex | `annie codex [args…]` | Codex; `annie codex resume <id>` |
| Gemini | `annie gemini [args…]` | Gemini (ACP) |
| OpenCode | `annie opencode [args…]` | OpenCode |
| KiloCode | `annie kilocode [args…]` | KiloCode |
| **Computer (gestión)** | `annie computer [args…]` | Agente multi-herramienta en el hub: shell, navegador, archivos, automatización |
| Auth | `annie auth login` / `status` / `logout` | Credenciales |
| Worker | `annie worker start` / `stop` / `status` / `list` / `stop-session <id>` / `logs` | Worker en segundo plano |
| MCP | `annie mcp [--url <url>] [--token \| --bearer <secreto>]` | Puente stdio → HTTP MCP |
| Servidor | `annie server [--host …] [--port …]` | Hub empaquetado (si tu instalación lo incluye) |
| Diagnóstico | `annie diagnose` / `annie diagnose clean` | Diagnóstico / limpieza |
| Limitado | `hook-forwarder`; `connect`; `notify` | Ver guía en inglés |

---

## 9. Configuración y reglas de URL

| Variable | Obligatoria | Descripción |
|----------|-------------|-------------|
| `CLI_API_TOKEN` | **Sí** | Debe coincidir con el servidor |
| `NEST_API_URL` | No | URL base normalizada |
| `NEST_HOME` | No | `~/.nest` por defecto |
| `NEST_HTTP_MCP_URL` | No | Objetivo por defecto para `annie mcp` |
| `NEST_MCP_BEARER_TOKEN` | No | Bearer alternativo para el puente |

---

## 10. MCP — protocolo, seguridad y endpoints

### 10.1 Endpoint

- **POST** `/mcp/sessions/<session_id>`
- **Cabecera:** `Authorization: Bearer <token>`
- **Cuerpo:** JSON-RPC 2.0 (MCP Streamable HTTP)

### 10.2 Ejemplo Cursor (`mcp.json`)

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/TU_SESSION_ID",
      "headers": {
        "Authorization": "Bearer TU_CLI_API_TOKEN"
      }
    }
  }
}
```

### 10.3 Puente stdio

```bash
# Preferible en producción: variables de entorno
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/TU_SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

También puedes pasar **URL y token por línea de comandos** (útil en pruebas locales; el token puede verse en `ps` y en el historial):

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/TU_SESSION_ID" --token "TU_CLI_API_TOKEN"
```

`--bearer` es alias de `--token`. Los argumentos del CLI tienen prioridad sobre el entorno para el token.

### 10.4 Higiene Git

`.cursor/mcp.json` local a la máquina; nunca commitear tokens; preferir inyección desde gestor de secretos.

---

## 11. Patrones por cliente

| Cliente | Patrón recomendado |
|---------|-------------------|
| **Cursor** | HTTP `url` + `headers.Authorization` |
| **VS Code** | HTTP nativo de extensión **o** stdio con `annie mcp` |
| **Claude** | Stdio → `annie mcp` + env o llavero |
| **ChatGPT** | MCP HTTP personalizado cuando el producto lo permita |

Independiente del **lenguaje del repositorio**.

---

## 12. Riesgo, validación y gobernanza

| Riesgo | Mitigación |
|--------|------------|
| Exfiltración de token | Rotación; tokens por equipo; vault |
| URL MCP obsoleta en Git | `.gitignore`, CI, formación |
| Herramientas demasiado amplias | Revisión de seguridad |
| «Localhost es seguro» | Bearer sigue siendo obligatorio en el proxy |

**Checklist:** `annie auth status`; `annie diagnose`; MCP sin auth → **401**; con auth → `initialize` / `tools/list`; PWA controla la sesión.

---

## 13. Documentos relacionados

| Documento | Contenido |
|-----------|-----------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | Visión de negocio |
| [INSTALL.md](../INSTALL.md) | Instalación |
| [DEVOPS.md](../DEVOPS.md) | HTTPS, proxy |
| [Methodology](../methodology/README.md) | Fases NEST 0–6 |
| [Enterprise README](./README.md) | Enterprise |
| [Imagen nest-server](https://hub.docker.com/r/matiasbaglieri/nest-server) | Rutas en la imagen publicada; contratos documentados en **nest_hub** |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribución pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
