<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Enterprise — NEST Platform

[English](./README.md) | **Español** | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

**CLI + MCP (todos los idiomas):** [Guía Annie y MCP](./annie-cli-mcp-enterprise-ES.md) · [EN](./annie-cli-mcp-enterprise.md) · [DE](./annie-cli-mcp-enterprise-DE.md) · [PT](./annie-cli-mcp-enterprise-PT.md) · [FR](./annie-cli-mcp-enterprise-FR.md) · [ZH](./annie-cli-mcp-enterprise-ZH.md)

La versión **Enterprise** de NEST ofrece funciones avanzadas para organizaciones que necesitan más de lo que el self-hosted puede dar. La versión Community es gratuita y autocontenida; Enterprise añade inteligencia, escala y soporte.

---

## Comparación rápida

| Característica | Community | Enterprise |
|---------|-----------|------------|
| **Precio** | $0 de producto | Suscripción |
| **Despliegue** | Self-hosted Docker | Nube gestionada |
| **Usuarios** | Individual / equipo pequeño | Organizaciones, ONG, gobiernos |
| **Basic Agents** | ✅ | ✅ |
| **Darwin Agents** | ❌ | ✅ |
| **Colony Memory** | ❌ | ✅ |
| **Specialized Agents** | ❌ | ✅ |
| **Advanced Automation** | Básica | ZeroClaw completo |
| **SSO / SAML** | ❌ | ✅ |
| **Audit Logs** | Local | Cumplimiento completo |
| **Soporte** | GitHub | SLA dedicado |
| **Custom Integrations** | ❌ | ✅ |

---

## Funciones Enterprise

### 1. Colony Memory

El sistema aprende de cada interacción en toda tu organización.

**Qué aprende:**
- Qué agentes rinden mejor según el tipo de tarea
- Preferencias y patrones de trabajo de las personas
- Contexto de proyecto que acelera el trabajo
- Flujos de trabajo óptimos descubridos con la experiencia

**Beneficios:**
- Las personas nuevas se vuelven más efectivas al instante
- Las buenas prácticas se difunden solas
- El conocimiento no sale de tu organización

> *"Colony Memory es lo que diferencia a NEST de un simple ejecutor de agentes. Cada tarea enseña al sistema."* — [Propuesta de valor](../business/value-proposition.md)

---

### 2. Darwin Agents

Agentes de IA que evolucionan y mejoran según el rendimiento.

**Ciclo de vida:**

```
┌──────────────┐
│ 1. CREATE    │ ← User describes a need
└──────┬───────┘
       ↓
┌──────────────┐
│ 2. TRAIN     │ ← Agent performs task
└──────┬───────┘
       ↓
┌──────────────┐
│ 3. EVALUATE  │ ← Performance tracked
└──────┬───────┘
       ↓
┌──────────────┐
│ 4. EVOLVE    │ ← Best agents replicate
└──────┬───────┘
       ↓
┌──────────────┐
│ 5. DEPLOY    │ ← Better results next time
└──────────────┘
```

**Ejemplos:**
- Agente de respuesta por correo → Aprende tu estilo de comunicación
- Agente de investigación → Mejor hallando información relevante
- Revisor de código → Entiende los patrones de tu codebase
- Generador de informes → Se adapta a los formatos preferidos

---

### 3. Specialized Agents

Agentes predefinidos para tareas empresariales habituales:

| Agent | Qué hace |
|-------|-------------|
| **Research Agent** | Web scraping, recopilación de datos, resúmenes |
| **Email Agent** | Redactar, enviar y gestionar flujos de correo |
| **Calendar Agent** | Programar reuniones, gestionar disponibilidad |
| **Document Agent** | Generar informes, contratos y resúmenes |
| **Data Agent** | Analizar datos y crear dashboards |
| **Support Agent** | Automatización de respuestas a clientes |
| **HR Agent** | Onboarding y consultas de políticas |
| **Finance Agent** | Procesamiento de facturas y conciliación |

---

### 4. Advanced ZeroClaw

- Acceso más profundo al sistema
- Orquestación multi-máquina
- Plantillas de flujo de trabajo personalizadas
- Automatización programada
- Disparadores orientados a eventos

Consulta [Console Flow](../business/console-flow.md) para ver cómo funciona la automatización.

---

### 5. Seguridad Enterprise

- Integración SSO / SAML
- Control de acceso por roles
- Cumplimiento de auditoría completo
- Opciones de residencia de datos
- Listo para SOC 2

---

## Precios

### Startup

- Hasta 10 usuarios
- Colony memory
- Darwin agents
- Soporte por correo
- **$99/month**

### Business

- Usuarios ilimitados
- Todas las funciones
- Soporte prioritario
- Custom integrations
- **$299/month**

### Enterprise

- Todo ilimitado
- Infraestructura dedicada
- SLA personalizado
- Opción on-premise
- **Contact sales**

---

## Primeros pasos

### Paso 1: Contactar ventas

```
sales@contextzero.ai
```

### Paso 2: Llamada de descubrimiento

Tratamos:
- Las necesidades de tu organización
- Los flujos de trabajo actuales
- Objetivos de automatización
- Requisitos de seguridad

### Paso 3: Programa piloto

- POC de 30 días
- Alcance limitado
- Acceso a todas las funciones
- Métricas de éxito definidas

### Paso 4: Producción

- Despliegue completo
- Formación
- Soporte continuo

---

## Soporte

| Nivel | Tiempo de respuesta | Canal |
|------|--------------|---------|
| Startup | 24h | Email |
| Business | 4h | Email + Chat |
| Enterprise | 1h | Dedicated |

---

## Migración desde Community

¿Ya usas NEST self-hosted?

- Exporta tus datos
- Migramos a Enterprise
- Los mismos flujos, agentes más inteligentes
- Sin interrupciones

---

## Documentos relacionados

- [Guía enterprise Annie + MCP](./annie-cli-mcp-enterprise-ES.md) — CLI completo, MCP (Cursor, VS Code, Claude, ChatGPT), despliegue por fases
- [Business Overview](../business/README.md) — Valor estratégico para fundadores
- [Value Proposition](../business/value-proposition.md) — Beneficios detallados
- [Use Cases](../business/use-cases.md) — Escenarios reales
- [Methodology](../methodology/README.md) — Guía de implementación
- [CLI Business](../CLI-BUSINESS.md) — Profundidad técnica
- [Install Guide](../INSTALL.md) — Referencia de instalación

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribución pública: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
