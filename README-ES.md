<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Plataforma de Automatización de Fuerza Laboral — Autoalojada — Enterprise Grade**
<br/>
<em>Tu hub. Tus datos. Tu fuerza laboral IA. Desde la palma de tu mano.</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-Unirse-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Unirse-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![Docker](https://img.shields.io/badge/Docker-Listo-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## ¿Qué es NEST?

**NEST** es una plataforma completa y autoalojada de **automatización de fuerza laboral**. No es solo para programar: tus empleados pueden gestionar máquinas, resolver tareas, enviar emails, investigar, construir productos y más. Todo desde un hub. Todo desde su teléfono.

> Tú despliegas: un comando Docker en tu servidor.
> Tu equipo obtiene: un hub de fuerza laboral IA en tiempo real, accesible desde cualquier dispositivo.

### Vídeo del producto

Resumen de la experiencia del hub (archivo local en este repositorio):

[`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

### Los Cuatro Pilares

| Pilar | Qué Significa |
|-------|--------------|
| **Hub para la Empresa** | Una app reemplaza Slack + Notion + Trello + WhatsApp. Proyectos → Empleados → Sesiones. |
| **Móvil para el Empleado** | PWA funciona en cualquier teléfono. Aprueba despliegues desde el autobús. Sin laptop. |
| **Banco de Memoria (Souls)** | El hub aprende de cada empleado. Sin re-explicar contexto cada sesión. |
| **Enjambre de Agentes** | Múltiples agentes especializados trabajando en paralelo. |

---

## Inicio Rápido — En vivo en 5 minutos

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

`setup.sh` genera secretos automáticamente, descarga imágenes Docker, inicia el stack y espera la verificación de salud.

```
=== NEST ready ===
  Web:  http://localhost
```

Ábrelo en tu teléfono. Instala la PWA. Tu hub está en vivo.

> **Guía detallada:** [QUICKSTART.md](QUICKSTART.md)

---

## Agentes Soportados

| Agente | Comando | Descripción |
|--------|---------|------------|
| **Claude Code** | `annie claude` | Agente de código insignia de Anthropic |
| **Cursor** | `annie cursor` | Modo agente del IDE Cursor |
| **Codex** | `annie codex` | Agente de ejecución de código de OpenAI |
| **Gemini** | `annie gemini` | Agente multimodal de Google |
| **OpenCode** | `annie opencode` | Agente de código open-source |
| **KiloCode** | `annie kilocode` | Ejecución de tareas + control remoto |
| **Computer (gestión)** | `annie computer` | Agente multi-herramienta sincronizado con el hub (shell, navegador, archivos, operaciones) |
| **ZeroClaw** | Automatización headless | Tareas autónomas con autocorrección |
| **OpenClaw** | Orquestación de proyectos | Flujos multi-paso + control de navegador |

\*A partir del **1 de junio de 2026**, **ZeroClaw** y **OpenClaw** se publican como **envoltorios dentro de `annie computer`** (el mismo patrón que otros agentes de Computer). Ver [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md).

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs. `annie` suelto:** A partir del **1 de junio de 2026**, **ZeroClaw** y **OpenClaw** van **dentro de `annie computer`** como envoltorios (mismo patrón que Claude, Cursor, Codex, …)—véase [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). **No** existirán comandos `annie zeroclaw` / `annie openclaw`. En scripts e integración continua usa siempre un subcomando explícito (`annie claude`, `annie computer`, …). Si el primer token no es un subcomando conocido, la CLI se comporta como **`annie cursor`**.

### Despliegue enterprise — CLI (`@contextzero/nest`)

Secuencia para **macOS, Windows y Linux** donde los empleados usan Cursor, Claude Code, Codex, OpenCode o KiloCode. Tras **`npm install -g @contextzero/nest`** (paquete npm oficial de la CLI, binario **`annie`**) cada puesto queda enlazado a **tu** instancia NEST; Context Zero no aloja tu hub autoalojado ni se une a tu red.

**1. Instalar la CLI (TI o empleado, con Node.js LTS + npm):**

```bash
npm install -g @contextzero/nest
annie --version
```

**2. Autenticar el equipo contra tu hub**

Ejecutar una vez por perfil (o automatizar vía MDM / almacén de secretos con las mismas variables que persiste `annie auth login`):

```bash
annie auth login
```

Se solicitarán la **URL base de tu despliegue** (por ejemplo `https://nest.tuempresa.com`, emitida por tu organización) y un **token de API CLI** que generen tus administradores en el servidor. Comprobar conectividad:

```bash
annie auth status
```

**3. Puntos de entrada habituales (después del login)**

| Superficie | Comando | Uso |
|------------|---------|-----|
| **Claude Code** | `annie claude` | Sesiones Claude Code |
| **Cursor** | `annie cursor` | Modo agente de Cursor |
| **Codex** | `annie codex` | Sesiones Codex (`annie codex resume <id>` cuando aplique) |
| **Gemini** | `annie gemini` | Sesiones Gemini |
| **OpenCode** | `annie opencode` | Sesiones OpenCode |
| **KiloCode** | `annie kilocode` | Ejecución KiloCode |
| **Computer** | `annie computer` | Agente de gestión multi-herramienta (shell, navegador, archivos, procesos) |
| **Puente MCP** | `annie mcp` | MCP stdio hacia tu hub (HTTP + token) |
| **Worker** | `annie worker start` · `list` · `stop-session <id>` | Trabajo en segundo plano ligado al hub |
| **Terminales del hub** | *(PWA ↔ servidor ↔ PTY en la CLI)* | Shells remotos para operadores (superficie privilegiada) |

Distribuir **solo** URLs y tokens emitidos por **tu** dominio e identidad corporativa. Los empleados deben instalar la **PWA o clientes** desde enlaces que controléis (intranet, MDM o descargas con marca), y usar móvil, tableta o escritorio para aprobar trabajo, supervisar sesiones y auditar actividad—sin compartir credenciales fuera de vuestro tenant.

**Más información:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — superficie completa: agentes de IDE, **`annie computer`**, **terminales remotos (PTY)**, worker, MCP, diagnóstico; sin enlaces a repositorios de código privados.

**Automatización:** si el primer argumento no es un subcomando reconocido, la invocación se interpreta como **`annie cursor`**. En CI, usa siempre un subcomando explícito (`annie claude`, `annie computer`, etc.).

---

## ¿Por qué NEST?

| Problema | Cómo NEST lo Resuelve |
|----------|----------------------|
| 15+ apps fragmentadas | **Un hub reemplaza la pila** |
| Fuerza laboral atada al escritorio | **PWA phone-first — aprueba desde cualquier lugar** |
| La IA olvida todo | **Souls — el hub aprende de cada empleado** |
| Un solo agente como cuello de botella | **Enjambre de agentes — especialistas en paralelo** |
| Shadow AI / sin visibilidad | **Auditoría completa a través del hub** |
| Asistentes personales no escalan | **Hub de fuerza laboral — memoria compartida** |

---

## Comunidad

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Unirse-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

---

## Aviso importante — despliegues autoalojados, responsabilidad y acceso

El siguiente texto es un **aviso informativo general** para clientes y operadores. **No** constituye asesoramiento jurídico personalizado; debe revisarlo vuestro asesor legal según vuestros contratos, jurisdicción y obligaciones regulatorias.

**Uso y cumplimiento.** Vuestra organización—**no** Context Zero Inc. (incluidas filiales, contratistas o personal, en conjunto «**Context Zero**»)—es **exclusivamente responsable** de cómo desplegáis, configuráis, aseguráis y usáis NEST Hub, incluidas todas las salidas de agentes de IA, integraciones, tratamiento de datos, prácticas laborales, controles de exportación, privacidad, normativa sectorial y políticas internas. Context Zero no supervisa vuestro entorno de ejecución ni asume responsabilidad por decisiones que tomen vuestros empleados, agentes o sistemas en vuestra infraestructura.

**Conectividad autoalojada.** Cuando operáis NEST como software **autoalojado** en infraestructura bajo vuestro control, **Context Zero no opera ese servidor**, no recibe una conexión administrativa automática hacia él y **no puede acceder** a vuestra instalación solo por haber descargado u obtenido licencias de nosotros. Vuestro hub es alcanzado por vuestros usuarios y herramientas (por ejemplo la CLI `annie` instalada con `@contextzero/nest`) de forma **saliente** hacia los endpoints **que** configuréis (vuestro DNS, vuestros certificados TLS, vuestros tokens). Salvo que contratéis por separado servicios gestionados que prevean explícitamente administración remota y el alcance de acceso, **ningún miembro del equipo de Context Zero dispone de acceso entrante** a vuestros servidores como parte del modelo de producto autoalojado descrito en este repositorio.

**Sin representación.** Nada en este README crea sociedad, joint venture ni relación de mandato. Context Zero es proveedor de software; **vuestra empresa sigue siendo exclusivamente responsable** del uso lícito, la gobernanza de la plantilla y la seguridad del despliegue.

---

**© 2025–2026 Context Zero** — Plataforma de Automatización de Fuerza Laboral Autoalojada

<div align="center">

*Distribución pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
