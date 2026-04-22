<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Selbstgehostete Workforce-Automatisierungsplattform — Enterprise Grade**
<br/>
<em>Dein Hub. Deine Daten. Deine KI-Belegschaft. Direkt aus deiner Hand.</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-Beitreten-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Beitreten-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![Docker](https://img.shields.io/badge/Docker-Bereit-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## Was ist NEST?

**NEST** ist eine vollständige, selbstgehostete **Workforce-Automatisierungsplattform**. Nicht nur zum Programmieren — Mitarbeiter können Maschinen verwalten, Aufgaben lösen, E-Mails senden, recherchieren, Produkte bauen und mehr. Alles über einen Hub. Alles vom Handy.

> Du deployst: einen Docker-Befehl auf deinem Server.
> Dein Team erhält: einen Echtzeit-KI-Workforce-Hub, erreichbar von jedem Gerät.

### Produktvideo

Überblick über die Hub-Erfahrung (lokale Datei in diesem Repository):

[`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

### Die vier Säulen

| Säule | Bedeutung |
|-------|-----------|
| **Hub für Unternehmen** | Eine App ersetzt Slack + Notion + Trello + WhatsApp. Projekte → Mitarbeiter → Sitzungen. |
| **Mobil für Mitarbeiter** | PWA funktioniert auf jedem Handy. Deployments im Bus genehmigen. Kein Laptop nötig. |
| **Gedächtnisbank (Souls)** | Der Hub lernt jeden Mitarbeiter kennen. Kein wiederholtes Erklären des Kontexts. |
| **Agenten-Schwarm** | Mehrere spezialisierte KI-Agenten arbeiten parallel. |

---

## Schnellstart — In 5 Minuten live

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

> **Ausführliche Anleitung:** [QUICKSTART.md](QUICKSTART.md)

---

## Unterstützte Agenten

| Agent | Befehl | Beschreibung |
|-------|--------|--------------|
| **Claude Code** | `annie claude` | Anthropic Flagship-Coding-Agent |
| **Cursor** | `annie cursor` | Cursor-IDE-Agentenmodus |
| **Codex** | `annie codex` | OpenAI Code-Ausführungsagent |
| **Gemini** | `annie gemini` | Google Multimodal-Agent |
| **OpenCode** | `annie opencode` | Open-Source-Coding-Agent |
| **KiloCode** | `annie kilocode` | Aufgabenausführung + Fernsteuerung |
| **Computer (Management)** | `annie computer` | Multi-Tool-Agent am Hub (Shell, Browser, Dateien, Prozesse) |
| **ZeroClaw** | Headless-Automatisierung | Selbstkorrigierende autonome Aufgaben |
| **OpenClaw** | Projekt-Orchestrierung | Mehrschritt-Workflows + Browsersteuerung |

\*Ab **1. Juni 2026** werden **ZeroClaw** und **OpenClaw** als **Wrapper in `annie computer`** bereitgestellt (gleiches Muster wie andere Computer-Agenten). Siehe [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md).

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs. bare `annie`:** Ab **1. Juni 2026** laufen **ZeroClaw** und **OpenClaw** als **Wrapper in `annie computer`** (gleiches Muster wie Claude, Cursor, Codex, …)—siehe [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). Es gibt **keine** eigenständigen Befehle `annie zeroclaw` / `annie openclaw`. In Skripten und CI immer einen expliziten Unterbefehl verwenden (`annie claude`, `annie computer`, …). Ist das erste Argument kein bekannter Unterbefehl, verhält sich die CLI wie **`annie cursor`**.

### Enterprise-Rollout — CLI (`@contextzero/nest`)

Ablauf für **macOS, Windows und Linux**, auf denen Mitarbeitende Cursor, Claude Code, Codex, OpenCode oder KiloCode nutzen. Nach **`npm install -g @contextzero/nest`** (offizielles npm-Paket der CLI, Binary **`annie`**) ist jeder Arbeitsplatz mit **Ihrer** NEST-Instanz verknüpfbar; Context Zero hostet Ihren selbstgehosteten Hub nicht und verbindet sich nicht mit Ihrem Netzwerk.

**1. CLI installieren (IT oder Mitarbeitende, Node.js LTS + npm):**

```bash
npm install -g @contextzero/nest
annie --version
```

**2. Rechner gegen Ihren Hub authentifizieren**

Einmal pro Profil ausführen (oder per MDM / Secret-Store automatisieren, mit denselben Variablen, die `annie auth login` speichert):

```bash
annie auth login
```

Sie werden nach der **Basis-URL Ihres Deployments** (z. B. `https://nest.ihrefirma.de`, von Ihrer Organisation vorgegeben) und einem **CLI-API-Token** gefragt, das Ihre Admins auf dem Server erzeugen. Verbindung prüfen:

```bash
annie auth status
```

**3. Übliche Einstiegspunkte (nach Login)**

| Oberfläche | Befehl | Zweck |
|------------|--------|--------|
| **Claude Code** | `annie claude` | Claude-Code-Sitzungen |
| **Cursor** | `annie cursor` | Cursor-Agentenmodus |
| **Codex** | `annie codex` | Codex-Sitzungen (`annie codex resume <id>` wo unterstützt) |
| **Gemini** | `annie gemini` | Gemini-Sitzungen |
| **OpenCode** | `annie opencode` | OpenCode-Sitzungen |
| **KiloCode** | `annie kilocode` | KiloCode-Ausführung |
| **Computer** | `annie computer` | Management-Agent mit Shell, Browser, Dateien, Prozessen |
| **MCP-Brücke** | `annie mcp` | stdio-MCP zu Ihrem Hub (HTTP-Ziel + Token) |
| **Worker** | `annie worker start` · `list` · `stop-session <id>` | Hintergrundarbeit am Hub |
| **Hub-Terminals** | *(PWA ↔ Server ↔ PTY in der CLI)* | Remote-Shells für Operatoren (hochprivilegiert) |

Verteilen Sie **ausschließlich** URLs und Tokens aus **Ihrer** Firmendomain und Identitätsinfrastruktur. Mitarbeitende installieren **PWA oder Clients** nur über von Ihnen kontrollierte Links (Intranet, MDM, Branding-Downloadseiten) und nutzen Smartphone, Tablet oder Desktop für Freigaben, Session-Monitoring und Audit—ohne Credentials außerhalb Ihres Mandanten zu teilen.

**Vertiefung:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — vollständige Oberfläche: Entwicklungsagenten, **`annie computer`**, **Hub-Terminals (PTY)**, Worker, MCP, Diagnose; ohne Link auf private Quellrepos.

**Hinweis für Automatisierung:** Ist das erste Argument kein bekannter Subbefehl, wird die Aufrufzeile wie **`annie cursor`** interpretiert. In CI immer explizit `annie claude`, `annie computer`, usw. angeben.

---

## Gemeinschaft

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Beitreten-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

---

## Wichtiger Hinweis — selbstgehostete Deployments, Verantwortung und Zugriff

Folgendes ist ein **allgemeiner Informationshinweis** für Kunden und Betreiber. Es ist **keine** individuelle Rechtsberatung; Ihre Rechtsabteilung sollte dies anhand Ihrer Verträge, Jurisdiktion und regulatorischen Pflichten prüfen.

**Nutzung und Compliance.** Ihre Organisation—**nicht** Context Zero Inc. (einschließlich verbundener Unternehmen, Auftragnehmer und Personals, zusammen „**Context Zero**“)—trägt die **alleinige Verantwortung** dafür, wie Sie NEST Hub bereitstellen, konfigurieren, absichern und nutzen, einschließlich aller Ausgaben von KI-Agenten, Integrationen, Datenverarbeitung, arbeitsrechtlicher Praxis, Exportkontrollen, Datenschutz, Branchenvorschriften und interner Richtlinien. Context Zero überwacht Ihre Laufzeitumgebung nicht und übernimmt keine Haftung für Entscheidungen Ihrer Mitarbeitenden, Agenten oder Systeme auf Ihrer Infrastruktur.

**Selbstgehostete Konnektivität.** Wenn Sie NEST als **selbstgehostete** Software auf von Ihnen kontrollierter Infrastruktur betreiben, **betreibt Context Zero diesen Server nicht**, erhält keine automatische administrative Verbindung dorthin und **kann nicht** auf Ihre Installation allein deshalb zugreifen, weil Sie Materialien von uns heruntergeladen oder lizenziert haben. Ihr Hub wird von Ihren Nutzern und Tools (z. B. der CLI `annie` aus `@contextzero/nest`) **ausgehend** zu den Endpunkten erreicht, **die Sie** konfigurieren (Ihr DNS, Ihre TLS-Zertifikate, Ihre Tokens). Sofern Sie nicht gesondert verwaltete Dienste mit ausdrücklich vereinbartem Remote-Administrationsumfang beauftragen, hat **kein Mitglied des Context-Zero-Teams** im beschriebenen Selbsthosting-Modell dieses Repositories **eingehenden Zugriff** auf Ihre Server.

**Keine Vertretung.** Nichts in diesem README begründet eine Partnerschaft, Joint Venture oder Vertretung. Context Zero ist Softwareanbieter; **Ihr Unternehmen bleibt allein verantwortlich** für rechtmäßige Nutzung, Workforce-Governance und die Sicherheit Ihres Deployments.

---

**© 2025–2026 Context Zero** — Selbstgehostete Workforce-Automatisierungsplattform

<div align="center">

*Öffentliche Distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
