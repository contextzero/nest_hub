<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Selbstgehostete Workforce-Automatisierungsplattform — Enterprise Grade**
<br/>
<em>Das Betriebssystem dafür, wie Ihr Unternehmen mit KI arbeitet.</em>
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

> **Ja, Sie haben noch 15+ Apps**—und diese Fragmentation tat schon 2018 weh. Heute kommt **Schatten-KI im Unternehmen** dazu: Menschen nutzen bereits ChatGPT, Claude, Cursor, Copilot, Bildtools und lose API-Keys—oft wissen Sie nicht **wo**, **welches Modell** und **was es kostet**. Prompts starten in jedem Tab bei null; wenn jemand geht, geht das **mit KI verfeinerte Urteil** mit. Sie haben Dashboards für Umsatz und Server, aber nicht dafür, **wie Arbeit mit KI wirklich passiert**.

**NEST** ist die **selbstgehostete Schicht, die Ihr Unternehmen betreibt**: **Projekte**, **Rollen**, **Memory** und **Governance**, damit Agenten und Chat **unter Ihren URLs, Ihren Tokens und Ihrem Audit-Log** laufen—nicht als unsichtbare Schatten-IT.

**NEST** ist auch eine vollständige **Workforce-Automatisierungsplattform**: Coding, Chat und Computer-Nutzung in einem Hub—Telefon, Tablet und Desktop.

> Du deployst: einen Docker-Befehl auf deinem Server.
> Dein Team erhält: einen Echtzeit-KI-Workforce-Hub, erreichbar von jedem Gerät.

### Drei Oberflächen — in Projekten, die Admins verwalten

Arbeit wird in **Projekten** gebündelt, die Ihre Administratoren anlegen. Das liefert **Tracking pro Projekt** (wer hat was in welcher Session getan), eine **Memory Bank**, die Kontext pro Nutzer und Team ansammelt (die „Seele“, wie jede Person mit KI arbeitet), und **Freigaben** vor riskanten Aktionen—statt loser Browser-Tabs.

| Oberfläche | Was Mitarbeitende heute bekommen | Hinweise |
|--------|----------------------------|--------|
| **Development** | **Claude Code**, **Cursor**, **Codex**, **OpenCode** und **KiloCode** über die **`annie`**-CLI (`npm install -g @contextzero/nest`), mit **MCP** für **Cursor** und **Visual Studio Code** | [Vollständige CLI- + MCP-Referenz](docs/enterprise/annie-cli-mcp-enterprise.md) |
| **Chat** | Ein Hub-Chat auf **Web, Desktop und mobiler PWA**, angetrieben von **OpenRouter**, **Fal.ai**, **Google Vertex AI** und **DeepInfra** — **über 700** Modelle für **Text, Bild, Audio und Video** | Provider-Keys bleiben auf dem **Server**; Mitarbeitende authentifizieren sich an **Ihrem** Hub |
| **Computer** | **`annie computer`** — hub-synchronisierte „Computer-Nutzung“ aus CLI und PWA (Shell, Browser wo erlaubt, Dateien, Runbooks). Ab **1. Juni 2026** liefern wir **OpenClaw**, **ZeroClaw** und **Hermes** als **Wrapper in Computer** (gleiches Muster wie Claude, Cursor, …)—nicht als eigenständige `annie`-Unterbefehle ([Details](docs/enterprise/zeroclaw.md)) | Gleiche Haltung **prüfen → freigeben → ausführen** wie in Development-Sessions |

### Produkt-Roadmap (2026)

| Datum | Meilenstein |
|------|-----------|
| **1. Mai 2026** | **Projektmanagement** in Projekten — Backlogs, Workflow-Status und Sichtbarkeit über Aufgaben |
| **15. Mai 2026** | **CRM** — Kontakte und Lifecycle (z. B. Pre-Sales → Sales → Post-Sales) **projektübergreifend** |
| **1. Juni 2026** | **`annie computer`-Wrapper** — **OpenClaw**, **ZeroClaw** und **Hermes** integriert **in Computer** (gleiches Anbinde-Muster wie andere Hub-Agenten) |

Rollenbewusstes Routing (Mitarbeitende **prüfen → genehmigen →** Ausführung auf **Computer**, **Claude**, **Cursor** usw.) verbindet diese Module—siehe [ROADMAP.md](ROADMAP.md) für Umfang und Lieferhinweise.

### Produktvideo


https://github.com/user-attachments/assets/abfe0d75-8808-45a6-a671-8b84dd21fd2f


Auch im Repository: [`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

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
| **Computer (Management)** | `annie computer` | Multi-Tool-Agent am Hub: Shell, Browser, Dateien, Git, Prozesse, Planung—über einen einzelnen IDE hinaus |
| **ZeroClaw** | *über `annie computer` (ab 1. Juni 2026)* | Headless-Automatisierungs-Wrapper — selbstkorrigierende autonome Aufgaben ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **OpenClaw** | *über `annie computer` (ab 1. Juni 2026)* | Orchestrierungs-Wrapper — Mehrschritt-Workflows + Browsersteuerung ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **Hermes** | *über `annie computer` (ab 1. Juni 2026)* | Computer-Use-Wrapper neben OpenClaw / ZeroClaw ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs. bare `annie`:** Ab **1. Juni 2026** laufen **OpenClaw**, **ZeroClaw** und **Hermes** als **Wrapper in `annie computer`** (gleiches Muster wie Claude, Cursor, Codex, …)—siehe [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). Es gibt **keine** eigenständigen Befehle `annie openclaw` / `annie zeroclaw` / `annie hermes`. In Skripten und CI immer einen expliziten Unterbefehl verwenden (`annie claude`, `annie computer`, …). Ist das erste Argument kein bekannter Unterbefehl, verhält sich die CLI wie **`annie cursor`**.

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
