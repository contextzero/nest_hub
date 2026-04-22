<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Enterprise-Leitfaden — Annie CLI, MCP & Multi-Client-Integration

[Deutsch](./annie-cli-mcp-enterprise-DE.md) | [English](./annie-cli-mcp-enterprise.md) | [Español](./annie-cli-mcp-enterprise-ES.md) | [Português](./annie-cli-mcp-enterprise-PT.md) | [Français](./annie-cli-mcp-enterprise-FR.md) | [中文](./annie-cli-mcp-enterprise-ZH.md)

Dieses Dokument ist die **Enterprise-Referenz** für den Einsatz von **Annie** (CLI `@contextzero/nest`), **alle unterstützten Befehlsoberflächen** und die Integration von **NEST MCP** mit ChatGPT, Claude, Cursor und VS Code.

**Hinweis zu Programmiersprachen:** NEST ist **sprachunabhängig** bezüglich der Sprachen in Ihren Repositories (Python, TypeScript, Rust, Go, Java, .NET usw.). Sessions binden an einen **Workspace-Pfad** und eine **Server-Session-ID**, nicht an eine einzelne Laufzeitumgebung.

**Dokumentensprachen:** Dieser Leitfaden liegt in **sechs natürlichen Sprachen** (EN, ES, DE, FR, PT, ZH) vor — **gleiche Phasenstruktur** in jeder Datei.

---

## Inhalt

1. [Executive Summary](#1-executive-summary)
2. [Phasenmodell auf einen Blick](#2-phasenmodell-auf-einen-blick)
3. [CTO-Engineering-Workflow-Phasen](#3-cto-engineering-workflow-phasen)
4. [NEST-Implementierungsphasen 0–6](#4-nest-implementierungsphasen-06)
5. [MCP-Technische-Reifephasen (M1–M4)](#5-mcp-technische-reifephasen-m1m4)
6. [Operatives Rollout (P0–P4)](#6-operatives-rollout-p0p4)
7. [Architekturüberblick](#7-architekturüberblick)
8. [CLI (`@contextzero/nest`) — Befehlsreferenz](#section-8-cli-de)
9. [Konfiguration & URL-Regeln](#9-konfiguration--url-regeln)
10. [MCP — Protokoll, Sicherheit, Endpunkte](#10-mcp--protokoll-sicherheit-endpunkte)
11. [Integrationsmuster pro Client](#11-integrationsmuster-pro-client)
12. [Risiko, Validierung, Governance](#12-risiko-validierung-governance)
13. [Weitere Dokumente](#13-weitere-dokumente)

---

## 1. Executive Summary

| Ebene | Beantwortet |
|-------|-------------|
| **CTO-Workflow** | *Wie* wir vor dem Release denken (Analyse → Design → Risiko → Umsetzung) |
| **NEST 0–6** | *Wann* Infrastruktur, Agenten und Governance in der Organisation ankommen |
| **MCP M1–M4** | *Wie* MCP von sicheren lokalen Dateien zu authentifiziertem Server-Proxy + externen IDEs reift |
| **Ops P0–P4** | *Wie* Teams vom Piloten bis zum Produktionsbetrieb skalieren |

**Unverhandelbare MCP-Enterprise-Regeln**

1. **URL + Bearer** bei `POST /mcp/sessions/<session_id>` — niemals „nur URL“.
2. **Git-Hygiene** für `.cursor/mcp.json` und Backups — als lokale Secret-Fläche behandeln.
3. **Explizite CLI-Subbefehle** in Automatisierung (`annie claude`, keine zweideutigen Defaults).

---

## 2. Phasenmodell auf einen Blick

```
┌─────────────────────────────────────────────────────────────────────────┐
│  CTO-Workflow   Analyse → Design → Risiko → Implementierung                │
│       │                    (kontinuierlich; gate je NEST-Phase)          │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6       Discovery → … → Operate   (Plattform-Lebenszyklus)        │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4      Git-Sicherheit → Stale → Server-Proxy → Ext. IDE         │
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4      Pilot → Standard → Worker → MCP-Skala → Betrieb          │
└─────────────────────────────────────────────────────────────────────────┘
```

**Lesen:** NEST-Phasen **der Reihe nach**. In **Phase 2–4** mindestens **MCP M1–M3** vor breitem IDE-Rollout. **P0–P4** für Personal und Supportlast. **CTO-Workflow** an jedem Gate.

---

## 3. CTO-Engineering-Workflow-Phasen

### Phase A — Analyse

| Punkt | Praxis |
|-------|--------|
| **Zweck** | Symptome von Anforderungen trennen; Annahmen sichtbar machen |
| **Fragen** | Wer führt CLI aus? Wer besitzt den Server? Liegt MCP auf der Angriffsfläche? Welche Daten verlassen den Arbeitsplatz? |
| **Ergebnisse** | Stakeholder-Karte, Bedrohungsannahmen, MCP-Transport-Inventar (stdio vs HTTP) |
| **Gate** | Einseitiges „MCP Threat Model“ von Security oder Tech Lead freigegeben |

### Phase B — Design

| Punkt | Praxis |
|-------|--------|
| **Zweck** | Optionen mit klaren Trade-offs |
| **Optionen** | (1) Nur lokales MCP, (2) Server-MCP mit Bearer, (3) Stdio-Brücke (`annie mcp`) |
| **Trade-offs** | Sicherheit vs Komfort; zentrales Audit vs Latenz; stdio vs natives HTTP |
| **Gate** | Muster pro Persona (Laptop / Runner / externes IDE) gewählt |

### Phase C — Risiko

| Punkt | Praxis |
|-------|--------|
| **Zweck** | Fehlerbilder und Rollback |
| **Beispiele** | Token-Leck durch committetes `mcp.json`; verwaiste localhost-URLs; zu große Tool-Fläche |
| **Ergebnisse** | Rollback-Runbook (MCP-Eintrag deaktivieren, Token rotieren) |
| **Gate** | Trockenübung dokumentiert und verantwortet |

### Phase D — Implementierung

| Punkt | Praxis |
|-------|--------|
| **Zweck** | Defensive Defaults, Observability |
| **Praxis** | Pflicht-Bearer auf Server-MCP; keine Secrets im Repo; Stdio-Logs nach stderr |
| **Gate** | §12-Checks in Zielumgebung bestanden |

---

## 4. NEST-Implementierungsphasen 0–6

An **[NEST-Methodik](../methodology/README.md)** ausgerichtet.

### Phase 0 — Discovery

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Teams, Agenten, IDEs kartieren; Erfolgsmetriken |
| **Annie** | Bedarf `annie claude` vs `annie cursor` vs `annie codex`; OS und Installationspfad |
| **MCP** | Cursor-HTTP vs VS Code vs Claude-Desktop-stdio |
| **Deliverables** | Pilotliste; IDE-Inventar; Policy-Entwurf „kein MCP ohne Auth“ |
| **Gate** | Sponsor billigt Pilotumfang |

### Phase 1 — Strategy

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Token-Modell, Proxy-Routen, Compliance-Erzählung |
| **Annie** | `CLI_API_TOKEN`-Vergabe (Namespace pro Team); Vault vs `annie auth login` |
| **MCP** | Edge muss **`/mcp/`** an Rust weiterleiten; TLS-Terminierung dokumentieren |
| **Deliverables** | Architekturdiagramm; RACI Token-Rotation |
| **Gate** | Security-Review MCP-URL-Exposure |

### Phase 2 — Foundation

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Produktionsreifer Server; Secrets verteilt |
| **Annie** | `NEST_API_URL` pro Umgebung; `annie auth status` auf Golden Images |
| **MCP** | **M1** (gitignore) vor breiter Cursor-Adoption |
| **Deliverables** | Runbook „Neues Laptop-Onboarding“ |
| **Gate** | Health OK; Beispielsession PWA |

### Phase 3 — Build

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Worker, IDE-Konfigurationen, Brücken |
| **Annie** | `annie worker start` auf dedizierten Hosts; Schulung `worker list` / `stop-session` |
| **MCP** | **M2–M3** (Stale-Erkennung + serverseitiges MCP für Runner) |
| **Deliverables** | Template `mcp.json` mit `url` + `headers` (geschwärzt); Stdio-Wrapper |
| **Gate** | E2E: PWA → RPC → Tool-Ergebnis |

### Phase 4 — Hardening

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Auth-Härtung, Secret-Scanning, Training |
| **Annie** | CI-Image mit pinnter CLI-Version; `annie diagnose` in Support-Docs |
| **MCP** | **401** ohne Bearer; Pre-Commit für `mcp.json` |
| **Deliverables** | Security-Testnachweise; Support-Makros |
| **Gate** | §12-Checkliste Staging 100% |

### Phase 5 — Launch

| Dimension | Detail |
|-----------|--------|
| **Ziele** | Pilot → Abteilung → Unternehmen mit Feedback |
| **Annie** | Session-Fehler, Worker-Disconnects messen |
| **MCP** | IDE-Client-Versionen; MCP-Tickets |
| **Deliverables** | Launch-Retrospektive; KPI-Dashboard |
| **Gate** | Sponsor-Review gegen Metriken |

### Phase 6 — Operate

| Dimension | Detail |
|-----------|--------|
| **Ziele** | SRE-Betrieb, Kosten- und Risikosteuerung |
| **Annie** | Quartalsweise CLI-Upgrade-Kommunikation; Log-Stichproben |
| **MCP** | Token-Rotationskalender; vierteljährliche Tool-Flächen-Review |
| **Deliverables** | Betriebsmetriken: MCP 4xx/5xx, RPC-Latenz |
| **Gate** | Finanzierter Verbesserungs-Backlog |

**RACI (Beispiel)**

| Aktivität | Engineering | Security | IT / Desktop | Support |
|-----------|-------------|----------|--------------|---------|
| Token-Vergabe | C | A | I | I |
| Nginx `/mcp/` | R | C | A | I |
| MCP-Runbooks | R | C | I | A |
| Pilotnutzer | A | I | C | R |

---

## 5. MCP-Technische-Reifephasen (M1–M4)

### M1 — Git & Repo-Sicherheit

| Punkt | Aktion |
|-------|--------|
| **Ziel** | Kein versehentliches Commit injizierter MCP-Config |
| **Aktionen** | `.gitignore` für `**/.cursor/mcp.json`, `**/.cursor/mcp.json.nest-backup`; Schulung |
| **Prüfung** | CI-Grep schlägt bei getracktem `mcp.json` fehl |

### M2 — Stale-Einträge

| Punkt | Aktion |
|-------|--------|
| **Ziel** | Weniger tote localhost-URLs nach Crashes |
| **Aktionen** | Annie-Injektionslogik (Erreichbarkeit); manuelle Cleanup-Doku |
| **Prüfung** | Crash simuliert → nächster Start repariert oder überschreibt |

### M3 — Server-proxied MCP

| Punkt | Aktion |
|-------|--------|
| **Ziel** | Remote Runner/Cursor nutzt Server-URL |
| **Aktionen** | Effektive API-Basis + `/mcp/sessions/<id>` + **Bearer**; `/mcp/` in Prod |
| **Prüfung** | MCP funktioniert bei getrennten Hosts für Cursor und Worker |

### M4 — Externe IDE-Skalierung

| Punkt | Aktion |
|-------|--------|
| **Ziel** | VS Code, Claude Desktop, ChatGPT-Connectoren (wenn unterstützt) |
| **Aktionen** | Standard-Templates; optional `annie mcp install` je Release |
| **Prüfung** | Nicht-Cursor-Client besteht §12 |

---

## 6. Operatives Rollout (P0–P4)

### P0 — Pilot (5–20 Nutzer)

| Thema | Detail |
|-------|--------|
| **Umfang** | Ein Haupt-Agent-Modus; eine IDE-Familie; MCP optional, Bearer Pflicht wenn aktiv |
| **Dauer** | Typisch 2–4 Wochen |
| **Metriken** | Session-Erfolgsrate, null Secret-Vorfälle, Support-Stunden/Nutzer |
| **Ausstieg** | Go/No-Go P1 |

### P1 — Standardisierung

| Thema | Detail |
|-------|--------|
| **Umfang** | Goldenes `NEST_API_URL`; Pflicht `annie auth login` oder MDM-Env |
| **MCP** | M1 org-weit |
| **Ausstieg** | Audit-Stichprobe: 95%+ Rechner `annie auth status` OK |

### P2 — Worker Produktion

| Thema | Detail |
|-------|--------|
| **Umfang** | Dedizierte Runner-Hosts; On-Call für `worker status` |
| **MCP** | M3 für Remote-Spawn validiert |
| **Ausstieg** | Remote-Session-Demo PWA mit Audit-Log |

### P3 — MCP-Skala

| Thema | Detail |
|-------|--------|
| **Umfang** | HTTP-MCP Cursor; Stdio-Brücke sonst; Runbooks |
| **MCP** | M4-Pilot zweiter Client (z. B. VS Code) |
| **Ausstieg** | Bekannte MTTR bei MCP-Auth-Vorfällen |

### P4 — Steady State

| Thema | Detail |
|-------|--------|
| **Umfang** | Quartals-Rotation; CLI-Version-Pinning-Policy |
| **Metriken** | RPC-Fehler, MCP-HTTP-Codes, Worker-Restarts |
| **Ausstieg** | Laufende Compliance-Nachweise |

---

## 7. Architekturüberblick

```
Rechner Mitarbeiter              NEST-Server                    Clients
─────────────────                ───────────                    ───────
annie <agent>  ── Socket.IO ──►  Rust-Server  ◄── SSE/REST ───  PWA / Telegram
     │                           Postgres-Audit
     │                           POST /mcp/sessions/:sessionId
     ▼                                     ▲
Cursor / VS Code MCP  ── Streamable HTTP ──┘
```

**Invarianten:** `CLI_API_TOKEN`; effektive Basis-URL; **`/mcp/sessions/<session_id>`** mit **Bearer**.

---

<a id="section-8-cli-de"></a>

## 8. CLI (`@contextzero/nest`) — Befehlsreferenz

Installation: **`npm install -g @contextzero/nest`** → Binary **`annie`**. Die **vollständige Referenz** (Computer-Modus, Remote-PTY-Terminals, Standardauflösung auf `cursor`, `hook-forwarder`, usw.) steht in der **englischen Fassung**: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) — ohne Links auf private Repositories.

**Computer-Wrapper (1. Juni 2026):** **OpenClaw**, **ZeroClaw** und **Hermes** in **`annie computer`** (gleiches Muster wie Claude, Cursor, …). **Projekte:** **Projektmanagement 1. Mai 2026** · **CRM 15. Mai 2026** — [ROADMAP.md](../../ROADMAP.md) · Details **englisch** §8.3: [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) · [zeroclaw.md](./zeroclaw.md).

| Bereich | Befehl | Zweck |
|---------|--------|-------|
| Claude | `annie claude [args…]` | Claude Code + NEST |
| Cursor | `annie cursor [args…]` | Cursor Agent |
| Codex | `annie codex [args…]` | Codex; `annie codex resume <id>` |
| Gemini | `annie gemini [args…]` | Gemini (ACP) |
| OpenCode | `annie opencode [args…]` | OpenCode |
| KiloCode | `annie kilocode [args…]` | KiloCode |
| **Computer (Management)** | `annie computer [args…]` | Multi-Tool-Agent am Hub (Shell, Browser, Dateien, Automatisierung) |
| Auth | `annie auth login` / `status` / `logout` | Credentials |
| Worker | `annie worker start` / `stop` / `status` / `list` / `stop-session <id>` / `logs` | Worker |
| MCP | `annie mcp [--url <url>] [--token \| --bearer <secret>]` | Stdio → HTTP MCP |
| Server | `annie server [--host …] [--port …]` | Gebündelter Hub (falls in Ihrer Installation enthalten) |
| Diagnose | `annie diagnose` / `annie diagnose clean` | Diagnose / Cleanup |
| Begrenzt | `hook-forwarder`; `connect`; `notify` | Siehe EN-Leitfaden |

---

## 9. Konfiguration & URL-Regeln

| Variable | Erforderlich | Beschreibung |
|----------|--------------|--------------|
| `CLI_API_TOKEN` | **Ja** | Muss zum Server passen |
| `NEST_API_URL` | Nein | Normalisierte Basis-URL |
| `NEST_HOME` | Nein | Standard `~/.nest` |
| `NEST_HTTP_MCP_URL` | Nein | Standardziel `annie mcp` |
| `NEST_MCP_BEARER_TOKEN` | Nein | Alternativer Bearer |

---

## 10. MCP — Protokoll, Sicherheit, Endpunkte

### 10.1 Endpunkt

- **POST** `/mcp/sessions/<session_id>`
- **Header:** `Authorization: Bearer <token>`
- **Body:** JSON-RPC 2.0 (MCP Streamable HTTP)

### 10.2 Cursor-Beispiel (`mcp.json`)

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/SESSION_ID",
      "headers": {
        "Authorization": "Bearer CLI_API_TOKEN"
      }
    }
  }
}
```

### 10.3 Stdio-Brücke

```bash
# In Produktion bevorzugt: Umgebungsvariablen
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

**URL und Token als Argumente** (für lokale Tests; Token kann in `ps` und Shell-History erscheinen):

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/SESSION_ID" --token "CLI_API_TOKEN"
```

`--bearer` ist Alias für `--token`. CLI-Argumente überschreiben die Umgebung für das Token.

### 10.4 Git

`.cursor/mcp.json` maschinenlokal; keine Tokens committen; Secrets aus Vault injizieren.

---

## 11. Integrationsmuster pro Client

| Client | Empfohlenes Muster |
|--------|-------------------|
| **Cursor** | HTTP `url` + `headers.Authorization` |
| **VS Code** | Native HTTP der Extension **oder** Stdio mit `annie mcp` |
| **Claude** | Stdio → `annie mcp` + Env oder Keychain-Wrapper |
| **ChatGPT** | Custom HTTP-MCP wenn Produkt erlaubt |

Unabhängig von der **Programmiersprache im Repository**.

---

## 12. Risiko, Validierung, Governance

| Risiko | Mitigation |
|--------|------------|
| Token-Exfiltration | Rotation; Namespaces; Vault |
| Stale MCP-URL in Git | `.gitignore`, CI-Grep, Schulung |
| Zu breite Tool-Fläche | Security-Review |
| „Localhost ist sicher“ | Bearer bleibt Pflicht |

**Checkliste:** `annie auth status`; `annie diagnose`; MCP ohne Auth → **401**; mit Auth → `initialize` / `tools/list`; PWA steuert Session.

---

## 13. Weitere Dokumente

| Dokument | Inhalt |
|----------|--------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | Business-Überblick |
| [INSTALL.md](../INSTALL.md) | Installation |
| [DEVOPS.md](../DEVOPS.md) | HTTPS, Proxy |
| [Methodology](../methodology/README.md) | NEST 0–6 |
| [Enterprise README](./README.md) | Enterprise-Features |
| [nest-server-Image](https://hub.docker.com/r/matiasbaglieri/nest-server) | Routen im veröffentlichten Image; Verträge in **nest_hub** dokumentiert |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Öffentliche Distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
