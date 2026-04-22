<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

[English](./INSTALL.md) | [Español](./INSTALL-ES.md) | [中文](./INSTALL-ZH.md) | **Deutsch** | [Português](./INSTALL-PT.md) | [Français](./INSTALL-FR.md)

# NEST — Vollständige Installationsanleitung

**Von Context Zero.** Self-Hosted Workforce Automation Platform — Enterprise Grade.

Diese Anleitung bringt den kompletten NEST-Stack zum Laufen — Server, Datenbank, Web-App und CLI — mit öffentlichen Docker-Images. Kein Rust-Wissen, kein Build aus dem Quellcode, kein Cloud-Konto nötig.

> **Eilig?** → [QUICKSTART.md](../QUICKSTART.md) bringt Sie in etwa 5 Minuten mit den wichtigsten Schritten online.  
> Diese Anleitung ist die vollständige Referenz — jede Option, jeder Schalter, jeder Troubleshooting-Pfad.

---

## Was installiert wird

| Komponente | Bereitstellung | Funktion |
|-----------|---------------|--------------|
| **NEST Server** | Docker zieht `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker zieht `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker zieht `postgres:16-alpine` | Speichert alle Sessions, Nachrichten und Audit-Events in einem benannten Volume |
| **nginx** | Docker zieht `nginx:alpine` | Ein Einstieg auf Port 80 — routet `/api/*`, `/ws/*`, SSE und PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | Führt Agent-Sessions auf Mitarbeiter-Rechnern aus; verbindet mit Ihrem Server |

**Keine Kompilierung.** Docker lädt das vorgebaute Server-Image. `npm` lädt die vorgebaute CLI. Der gesamte Stack läuft auf jeder Maschine mit Docker und Node in unter 2 Minuten.

---

## Voraussetzungen

Zwei Maschinen, zwei Anforderungen:

| Maschine | Benötigt |
|---------|-------|
| **Server-Maschine** (hostet den Stack) | Docker + Docker Compose |
| **Mitarbeiter-Maschinen** (führen Agents aus) | Node.js 18+ und npm |

Server und Mitarbeiter können während der Einrichtung dieselbe Maschine sein — das ist der übliche lokale Entwicklungsablauf.

**Noch nicht vorhanden?** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) deckt jedes Betriebssystem ab.

---

## Teil 1 — Server-Einrichtung

### Schritt 1.1 — Klonen und Setup ausführen

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

Das Setup-Skript erzeugt ein sicheres `CLI_API_TOKEN`, legt Ihre `.env` an und startet den vollständigen Stack. Den Anweisungen folgen — der gesamte Vorgang dauert unter 2 Minuten.

Anschließend **http://localhost** im Browser öffnen. Sie sollten die NEST Web-App sehen. Wenn sie lädt — ist Ihr Server voll einsatzbereit.

### Schritt 1.2 — Prüfen, ob der Server läuft

```bash
docker compose ps
```

Alle vier Container sollten `Up` oder `healthy` anzeigen:

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Start-Logs ansehen:

```bash
docker compose logs -f
```

Sobald der Health-Check von nest-server durch ist, sind Sie bereit. Eine Zeile wie:

```
nest-server  | Server listening on 0.0.0.0:3000
```

### Erweitert: Manuelle Konfiguration

Wenn Sie `.env` lieber manuell statt mit `./setup.sh` pflegen:

```bash
cp .env.example .env
```

`.env` in einem Editor öffnen. Einziger Pflichtwert ist `CLI_API_TOKEN`:

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

**Minimale `.env` für lokale Nutzung:**

```env
CLI_API_TOKEN=paste-your-generated-token-here
```

Alles andere hat sinnvolle Defaults für lokale Bereitstellung.

> **Sicherheit:** `CLI_API_TOKEN` ist der einzige Schlüssel, der die CLIs Ihres Teams mit dem Server verbindet. Erzeugen Sie ihn mit `openssl rand -hex 32`. Committen Sie `.env` niemals ins Versionskontrollsystem.

Dann den Stack starten:

```bash
docker compose up -d
```

Docker lädt beim ersten Lauf vier Images (je nach Verbindung 1–2 Minuten). Spätere Starts sind sofort.

---

## Teil 2 — CLI-Einrichtung

Auf **jeder Maschine**, auf der ein Mitarbeiter Agent-Sessions ausführen soll.

### Schritt 2.1 — Installation

```bash
npm install -g @contextzero/nest
```

Prüfen:

```bash
annie --help
```

Sie sollten die vollständige Befehlsliste sehen. Wenn `annie` nicht gefunden wird, siehe [Häufige Probleme](#common-issues).

### Schritt 2.2 — Mit Ihrem Server verbinden

Zwei Möglichkeiten:

**Option A — Interaktives Login (dauerhaft gespeichert, empfohlen)**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

Die Zugangsdaten landen in `~/.nest/config`. Jeder weitere `annie`-Befehl nutzt sie automatisch — keine Umgebungsvariablen pro Session nötig.

**Option B — Umgebungsvariablen (sinnvoll für CI/CD oder Skripte)**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**Verbindung prüfen:**

```bash
annie auth status
```

Sollte Ihre Server-URL ausgeben und bestätigen, dass das Token gesetzt ist. Bei Fehlern siehe [Häufige Probleme](#common-issues).

### Schritt 2.3 — Erste Agent-Session starten

Paket: **`npm install -g @contextzero/nest`** → **`annie`**. Befehlsreferenz: [enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md).

```bash
annie claude     # Claude Code — Anthropic-Coding-Agent
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini (via ACP)
annie opencode   # OpenCode — Open-Source-Agent
annie kilocode   # KiloCode — Taskausführung mit strenger Freigabe
annie computer   # Computer — Multi-Tool-Management-Agent am Hub (Shell, Browser, Dateien)
```

**Automatisierung:** Ist das erste Argument kein bekannter Unterbefehl, verhält sich die CLI wie **`annie cursor`**. In Skripten und CI immer einen expliziten Unterbefehl verwenden (`annie claude`, `annie computer`, …).

**ZeroClaw / OpenClaw** werden ab **1. Juni 2026** **in `annie computer`** als Wrapper bereitgestellt (gleiches Integrationsmuster wie Claude, Cursor, …)—nicht als eigene `annie`-Unterbefehle. Siehe [enterprise/zeroclaw.md](enterprise/zeroclaw.md) und [RELEASES.md](../RELEASES.md).

Sobald eine Session läuft, **http://localhost** im Browser (oder auf dem Telefon) öffnen. Die Session erscheint live im Dashboard.

---

## Port-Referenz

| Host-Port | Dienst | Hinweise |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | Über `WEB_PORT` in `.env` ändern |
| `5433` | PostgreSQL (optional host exposure) | `PGPORT=` (leer) setzen, um nur intern zu halten |

Der gesamte API-Verkehr, Socket.IO und SSE laufen über nginx auf Port 80. Für den Basisbetrieb müssen keine weiteren Ports geöffnet werden.

---

## Befehle zur Server-Verwaltung

Im Verzeichnis `nest_hub/` ausführen:

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

<h2 id="common-issues">Häufige Probleme</h2>

| Symptom | Ursache | Lösung |
|---------|-------|-----|
| `annie: command not found` | npm-Global-Bin nicht im PATH | `npm bin -g` ausführen, Pfad zu `$PATH` hinzufügen. Oder nvm nutzen — siehe [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| `401 Unauthorized` von der CLI | Token stimmt nicht | Sicherstellen, dass `CLI_API_TOKEN` in `.env` exakt mit `~/.nest/config` oder dem `export` übereinstimmt. Keine Anführungszeichen, keine Leerzeichen |
| Web-App leer / 502 Bad Gateway | Server startet noch | 30 s warten, dann `docker compose logs nest-server`. Nach der Zeile mit bestandenem Health-Check suchen |
| Port 80 bereits belegt | Anderer Dienst auf Port 80 | `WEB_PORT=8080` in `.env` setzen, dann `docker compose restart` |
| `docker compose` nicht gefunden | Docker Compose V1 installiert | Docker Desktop aktualisieren oder `docker-compose-plugin` installieren. NEST nutzt V2 (`docker compose`, nicht `docker-compose`) |
| Postgres-Verbindungsfehler | DB initialisiert noch | Erstinitialisierung dauert ca. 10 s. Warten und erneut versuchen. Logs mit `docker compose logs postgres` prüfen |
| Session erscheint nicht im Dashboard | Falsche `NEST_API_URL` | Die URL in `annie auth status` muss der tatsächlichen Serveradresse entsprechen (nicht `localhost`, wenn von einem anderen Rechner verbunden wird) |

**Immer noch hängen?** Auf der Maschine mit installierter CLI `annie diagnose` ausführen. Es liefert einen vollständigen Konnektivitäts- und Auth-Diagnosebericht.

---

## Produktions-Deployment

Für ein öffentlich erreichbares NEST (Remote-Team, HTTPS, eigene Domain):

1. `NEST_PUBLIC_URL=https://nest.yourdomain.com` in `.env` setzen
2. TLS-Terminierung auf nginx (oder einem Load Balancer davor) konfigurieren
3. Starkes `POSTGRES_PASSWORD` setzen und `PGPORT` leer lassen (Postgres nicht extern exponieren)
4. `CLI_API_TOKEN` mit `openssl rand -hex 32` rotieren — dann alle Mitarbeiter-CLIs mit `annie auth login` aktualisieren

Vollständige Produktions-Referenz: [DEVOPS.md](DEVOPS.md)

---

## Nächste Schritte

| Was Sie tun möchten | Wohin |
|---------------------|-------------|
| 5-Minuten-Setup-Überblick | [QUICKSTART.md](../QUICKSTART.md) |
| Node, Docker, Rust installieren | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| LLM-Keys konfigurieren (Vertex, OpenRouter, DeepInfra …) | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| Produktion, HTTPS, öffentliche URL | [DEVOPS.md](DEVOPS.md) |
| Geschäftlicher Nutzen für Gründer | [business/README.md](business/README.md) |
| Implementierungsmethodik | [methodology/README.md](methodology/README.md) |
| Enterprise-Funktionen | [enterprise/README.md](enterprise/README.md) |
| Alle Befehle und Konfiguration | [README.md](../README.md) |
| Was als Nächstes geplant ist | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Öffentliche Distribution: [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI: [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
