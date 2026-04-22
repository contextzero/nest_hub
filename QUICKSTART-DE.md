<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Beitreten-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Beitreten-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Schnellstart

[English](./QUICKSTART.md) | [Español](./QUICKSTART-ES.md) | [中文](./QUICKSTART-ZH.md) | **Deutsch** | [Português](./QUICKSTART-PT.md) | [Français](./QUICKSTART-FR.md)

**Von Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise-Grade.
Von null zu einem live AI-Workforce-Hub in unter 5 Minuten.

---

## Bevor du startest — Was du am Ende hast

In den nächsten 5 Minuten wirst du:

1. ✅ Den NEST-Server (Rust + Postgres + nginx) lokal mit **einem Befehl** deployen
2. ✅ Die `annie`-CLI auf einer beliebigen Maschine installieren
3. ✅ Deine erste echte AI-Agent-Session starten (Claude Code, Codex, Cursor, Gemini, OpenCode oder KiloCode — ab **1. Juni 2026** ZeroClaw / OpenClaw **über `annie computer`**)
4. ✅ Sie **live im Browser** — und auf dem Handy — verfolgen

Keine Rust-Vorkenntnisse nötig. Kein Cloud-Konto. Keine Kreditkarte. Wenn Docker auf deiner Maschine läuft, läuft NEST auf deiner Maschine.

---

## Schritt 0 — Voraussetzungen (2 Minuten, falls noch nötig)

Du brauchst drei Dinge. Prüfe jedes:

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**Alle vier ok?** Weiter zu Schritt 1.

**Etwas fehlt?** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — installiert Node, npm und Docker in wenigen Minuten auf Mac, Linux oder Windows.

> **Warum das?** Node + npm treiben die `annie`-CLI an, die du auf Mitarbeiter-Maschinen installierst. Docker führt den Server aus, ohne dass du Rust, Postgres oder nginx selbst installieren musst.

---

## Schritt 1 — Den Hub deployen (60 Sekunden)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

Das war’s. `setup.sh` erzeugt automatisch alle Secrets, zieht Docker-Images, startet den Stack und wartet auf Health. Wenn du siehst:

```
=== NEST ready ===
  Web:  http://localhost
```

ist dein Hub live. Öffne ihn im Browser — und auf dem Handy.

> **Was ist passiert?** `setup.sh` hat eine `.env` mit automatisch generiertem `POSTGRES_PASSWORD`, `CLI_API_TOKEN` und `ENCRYPTION_KEY` angelegt. Anschließend wurden vier Container gestartet: `nest-server` (Rust), `nest-web` (React PWA), `postgres` und `nginx`.

---

## Schritt 2 — CLI auf beliebiger Maschine installieren (30 Sekunden)

Die `annie`-CLI installieren die Mitarbeiter (oder du) auf den Maschinen, auf denen die AI-Agenten laufen. Global installieren:

```bash
npm install -g @contextzero/nest
```

Prüfen, ob es funktioniert:

```bash
annie --help
```

Du solltest die vollständige Befehlsliste sehen. Die CLI ist auf dieser Maschine bereit.

> **Eine Installation pro Maschine.** Jede Person, die Agent-Sessions ausführen will, muss `annie` auf ihrer eigenen Maschine installieren und auf deinen Server zeigen.

---

## Schritt 3 — Mit deinem Server verbinden (30 Sekunden)

Zwei Optionen — eine wählen:

**Option A: Umgebungsvariablen (gut für Skripte und CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **Wo ist dein Token?** `setup.sh` hat es in `.env` gespeichiert. Ausführen: `grep CLI_API_TOKEN .env` zum Anzeigen.

**Option B: Interaktives Login (speichert Credentials dauerhaft)**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

Verbindung prüfen:

```bash
annie auth status
```

Du solltest deine Server-URL und ein bestätigtes Token sehen. **Du bist authentifiziert.**

---

## Schritt 4 — Deine erste Agent-Session starten

Agent wählen und einen Befehl ausführen (Paket **`@contextzero/nest`** → **`annie`**). **Enterprise-Referenz:** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md).

| Agent | Befehl | Was es tut |
|-------|--------|------------|
| **Claude Code** | `annie claude` | Flagship-Coding-Agent von Anthropic |
| **Codex** | `annie codex` | Code-Ausführungs-Agent von OpenAI |
| **Cursor** | `annie cursor` | Cursor-IDE-Agent-Modus |
| **Gemini** | `annie gemini` | Multimodaler Agent von Google |
| **OpenCode** | `annie opencode` | Open-Source-Coding-Agent |
| **KiloCode** | `annie kilocode` | Aufgabenausführung + Fernsteuerung |
| **Computer (Management)** | `annie computer` | Multi-Tool-Agent am Hub (Shell, Browser, Dateien) |

> **ZeroClaw / OpenClaw:** ab **1. Juni 2026** **in `annie computer`** als Wrapper (gleiches Muster wie Claude, Cursor, …). Keine eigenständigen `annie`-Subbefehle. Siehe [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) und [RELEASES.md](RELEASES.md).

**Automatisierung:** Ist das erste Argument kein bekannter Subbefehl, wird **`annie cursor`** angenommen. In CI immer `annie claude`, `annie computer`, usw. angeben.

Beispiel — Claude Code starten:

```bash
annie claude
```

Das Terminal zeigt Verbindung und Streaming. **Dieses Terminal nicht schließen.** Der Agent läuft.

---

## Schritt 5 — Dein AHA-Moment 🎯

Wechsle zum Browser (oder Handy) und öffne:

```
http://localhost
```

**Du solltest jetzt die Live-Session im Dashboard sehen.**

Von hier aus kannst du:
- 💬 in **Echtzeit** mit dem laufenden Agent **chatten**
- ✅ Berechtigungsanfragen des Agents **genehmigen oder ablehnen**
- 🖥️ die **Terminal-Ausgabe** beim Laufen **mitverfolgen**
- 📱 **alles vom Handy** — die PWA funktioniert in jedem mobilen Browser

Das ist der Moment. Du hast eine CLI-Session auf einem Laptop in eine **remote sichtbare, freigabefähige, auditierbare AI-Session** verwandelt, die du überall beobachten kannst.

---

## Kurzreferenz — die nützlichsten Befehle

```bash
annie claude            # Claude-Code-Session
annie codex             # Codex-Session
annie cursor            # Cursor-Agent
annie gemini            # Gemini-Session
annie opencode          # OpenCode-Session
annie kilocode          # KiloCode-Session
annie computer          # Multi-Tool-Management
annie worker start      # Hintergrund-Worker
annie worker list       # Aktive Worker-Sessions
annie auth login        # Credentials speichern
annie auth status       # Auth-Status
annie diagnose          # Diagnose
```

**Server-Verwaltung (im Ordner `nest_hub/`):**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## Was passiert ist — und warum es zählt

Du hast jetzt:

| Was | Wo | Warum es wichtig ist |
|-----|-----|----------------------|
| Live-Session-Dashboard | Browser / Handy | Jede Agent-Session deines Teams in Echtzeit sehen |
| Freigabe-Workflow | Mobile PWA | Agenten warten vor riskanten Aktionen auf dein OK |
| Vollständiges Audit-Log | Dein PostgreSQL | Jede Nachricht, jede Aktion, persistent auf deinem Server |
| Multi-Agent-Support | Jede Mitarbeiter-Maschine | Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode plus **Computer** (ZeroClaw-/OpenClaw-Wrapper ab **1. Juni 2026**) — alles in einem Hub |
| Keine monatlichen Kosten | Deine Infrastruktur | Du besitzt Server, Daten und Keys |

> **Mehr entdecken?** Diese Docs:
> - [Business Overview](docs/business/README.md) — strategischer Wert für Gründer
> - [Value Proposition](docs/business/value-proposition.md) — detaillierte Vorteile
> - [Methodology](docs/methodology/README.md) — Implementierungsleitfaden
> - [Enterprise Features](docs/enterprise/README.md) — für skalierende Organisationen

---

## Nächste Schritte

| Was du tun willst | Wohin |
|-------------------|-------|
| Auf echtem Server mit HTTPS deployen | [docs/DEVOPS.md](docs/DEVOPS.md) |
| LLM-Keys konfigurieren (Vertex, OpenRouter, DeepInfra, ElevenLabs …) | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Weitere Mitarbeiter-Maschinen hinzufügen | Dieses Doc + deine `NEST_API_URL` + das Token teilen |
| OpenClaw / ZeroClaw Agent-Modi verstehen | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Business-Value für Gründer | [docs/business/README.md](docs/business/README.md) |
| Implementierungsmethodik | [docs/methodology/README.md](docs/methodology/README.md) |
| Vollständige Umgebungsvariablen-Referenz | [README.md](README.md) |
| Was kommt | [ROADMAP.md](ROADMAP.md) |
| Changelog | [RELEASES.md](RELEASES.md) |

---

## Fehlerbehebung — schnelle Fixes

| Problem | Lösung |
|---------|--------|
| `annie` nach Install nicht gefunden | `npm install -g @contextzero/nest` erneut; `$PATH` prüfen |
| Web-App leer / lädt nicht | 30 s auf DB-Init warten; `docker compose logs nest-server` |
| `401 Unauthorized` in der CLI | Token passt nicht — `setup.sh` erzeugt es automatisch. `grep CLI_API_TOKEN .env` ausführen. |
| Port 80 schon belegt | `WEB_PORT=8080` in `.env`, dann `docker compose restart` |
| Session erscheint nicht im Dashboard | Prüfen, ob `NEST_API_URL` in der CLI die richtige Server-Adresse hat |
| Sonst etwas stimmt nicht | `annie diagnose` ausführen — vollständiger Diagnosebericht |

---

> **Du betreibst einen Enterprise-Grade AI-Workforce-Hub. Kostenlos. Auf deiner eigenen Infrastruktur.**
> 
> Wenn du bereit für mehr bist — HTTPS, mehrere Teams, eigenes LLM-Routing — steht alles in [docs/DEVOPS.md](docs/DEVOPS.md) und [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Öffentliche Distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
