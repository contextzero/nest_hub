<div align="center">

<img src="../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

[English](./INSTALL.md) | [Español](./INSTALL-ES.md) | [中文](./INSTALL-ZH.md) | [Deutsch](./INSTALL-DE.md) | [Português](./INSTALL-PT.md) | **Français**

# NEST — Guide d’installation complet

**Par Context Zero.** Plateforme d’automatisation de la main-d’œuvre en self-hosting — niveau entreprise.

Ce guide met en route la pile NEST complète — serveur, base de données, application web et CLI — à partir d’images Docker publiques. Aucune connaissance Rust, pas de compilation depuis les sources, aucun compte cloud requis.

> **Pressé ?** → [QUICKSTART.md](../QUICKSTART.md) vous met en ligne en 5 minutes avec uniquement les étapes essentielles.
> Ce guide est la référence complète — chaque option, chaque flag, chaque piste de dépannage.

---

## Ce qui est installé

| Composant | Comment il arrive | Rôle |
|-----------|---------------|--------------|
| **NEST Server** | Docker tire `matiasbaglieri/nest-server:latest` | Rust API — Socket.IO, SSE, REST, JWT auth, audit log |
| **NEST Web App** | Docker tire `matiasbaglieri/nest-web:latest` | React PWA — session dashboard, approvals, terminal, chat |
| **PostgreSQL** | Docker tire `postgres:16-alpine` | Persiste toutes les sessions, messages et événements d’audit dans un volume nommé |
| **nginx** | Docker tire `nginx:alpine` | Point d’entrée unique sur le port 80 — route `/api/*`, `/ws/*`, SSE et PWA |
| **annie CLI** | `npm install -g @contextzero/nest` | Exécute les sessions d’agent sur les machines des collaborateurs ; se connecte à votre serveur |

**Zéro compilation.** Docker récupère l’image serveur précompilée. `npm` récupère la CLI précompilée. L’ensemble tourne en moins de 2 minutes sur toute machine disposant de Docker et de Node.

---

## Prérequis

Deux machines, deux exigences :

| Machine | Besoin |
|---------|-------|
| **Machine serveur** (héberge la pile) | Docker + Docker Compose |
| **Machines collaborateurs** (exécutent les agents) | Node.js 18+ et npm |

La machine serveur et une machine collaborateur peuvent être la même pendant la mise en place — c’est le flux habituel en développement local.

**Pas encore ces outils ?** → [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) couvre tous les systèmes d’exploitation.

---

## Partie 1 — Mise en place du serveur

### Étape 1.1 — Cloner et lancer le setup

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

Le script de setup génère un `CLI_API_TOKEN` sécurisé, crée votre `.env` et démarre la pile complète. Suivez les invites — l’ensemble prend moins de 2 minutes.

Une fois terminé, ouvrez **http://localhost** dans le navigateur. Vous devriez voir l’application web NEST. Si la page s’affiche — votre serveur est pleinement opérationnel.

### Étape 1.2 — Vérifier que le serveur tourne

```bash
docker compose ps
```

Les quatre conteneurs doivent afficher `Up` ou `healthy` :

```
NAME           STATUS          PORTS
nest-server    Up (healthy)    3000/tcp
nest-web       Up              80/tcp
postgres       Up              0.0.0.0:5433->5432/tcp
nginx          Up              0.0.0.0:80->80/tcp
```

Suivre les journaux de démarrage :

```bash
docker compose logs -f
```

C’est bon lorsque le health check de nest-server réussit. Cherchez une ligne du type :
```
nest-server  | Server listening on 0.0.0.0:3000
```

### Avancé : configuration manuelle

Si vous préférez configurer `.env` à la main plutôt que d’utiliser `./setup.sh` :

```bash
cp .env.example .env
```

Ouvrez `.env` dans un éditeur de texte. La seule valeur obligatoire est `CLI_API_TOKEN` :

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

**Le `.env` minimal viable pour un usage local :**
```env
CLI_API_TOKEN=paste-your-generated-token-here
```

Tout le reste a des valeurs par défaut adaptées au déploiement local.

> **Sécurité :** `CLI_API_TOKEN` est la seule clé qui relie les CLI de votre équipe au serveur. Générez-le avec `openssl rand -hex 32`. Ne commitez jamais `.env` dans le contrôle de version.

Puis démarrez la pile :

```bash
docker compose up -d
```

Docker téléchargera quatre images au premier lancement (1 à 2 minutes selon la connexion). Les lancements suivants sont instantanés.

---

## Partie 2 — Configuration de la CLI

À faire sur **chaque machine** où un collaborateur exécutera des sessions d’agent.

### Étape 2.1 — Installation

```bash
npm install -g @contextzero/nest
```

Vérification :

```bash
annie --help
```

Vous devez voir la liste complète des commandes. Si `annie` est introuvable, voir [Problèmes courants](#common-issues) ci-dessous.

### Étape 2.2 — Se connecter au serveur

Deux options :

**Option A — Connexion interactive (enregistrée de façon permanente, recommandé)**

```bash
annie auth login
# Prompt: Enter NEST_API_URL → http://localhost  (or your server's address)
# Prompt: Enter CLI_API_TOKEN → the value from your .env file
```

Les identifiants sont enregistrés dans `~/.nest/config`. Chaque commande `annie` ultérieure les utilise automatiquement — pas de variables d’environnement par session.

**Option B — Variables d’environnement (utile pour CI/CD ou scripts)**

```bash
export CLI_API_TOKEN="your-token-from-env"
export NEST_API_URL="http://localhost"
annie auth status
```

**Vérifier la connexion :**

```bash
annie auth status
```

Doit afficher l’URL du serveur et confirmer que le token est défini. En cas d’erreur, voir [Problèmes courants](#common-issues).

### Étape 2.3 — Démarrer votre première session d’agent

Paquet : **`npm install -g @contextzero/nest`** → **`annie`**. Référence des commandes : [enterprise/annie-cli-mcp-enterprise.md](enterprise/annie-cli-mcp-enterprise.md).

```bash
annie claude     # Claude Code — agent de code Anthropic
annie codex      # OpenAI Codex
annie cursor     # Cursor Agent
annie gemini     # Google Gemini (via ACP)
annie opencode   # OpenCode — agent open source
annie kilocode   # KiloCode — exécution de tâches avec contrôle d’approbation
annie computer   # Computer — agent multi-outils sur le hub (shell, navigateur, fichiers)
```

**Automatisation :** si le premier argument n’est pas un sous-commande connu, la CLI se comporte comme **`annie cursor`**. Dans les scripts et la CI, utilisez toujours un sous-commande explicite (`annie claude`, `annie computer`, …).

**ZeroClaw / OpenClaw** seront exposés **dans `annie computer`** sous forme d’enveloppes (même schéma que Claude, Cursor, …) à partir du **1er juin 2026**—pas comme sous-commandes `annie` séparées. Voir [enterprise/zeroclaw.md](enterprise/zeroclaw.md) et [RELEASES.md](../RELEASES.md).

Une fois la session démarrée, ouvrez **http://localhost** dans le navigateur (ou sur le téléphone). La session apparaît sur le tableau de bord en temps réel.

---

## Référence des ports

| Port hôte | Service | Remarques |
|-----------|---------|-------|
| `80` | nginx → Web app + API (single entry point) | Modifiez avec `WEB_PORT` dans `.env` |
| `5433` | PostgreSQL (optional host exposure) | Mettez `PGPORT=` (vide) pour le garder uniquement interne |

Tout le trafic API, Socket.IO et SSE transite par nginx sur le port 80. Aucun port supplémentaire n’est nécessaire pour le fonctionnement de base.

---

## Commandes d’administration du serveur

À lancer depuis le répertoire `nest_hub/` :

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

<h2 id="common-issues">Problèmes courants</h2>

| Symptôme | Cause | Correctif |
|---------|-------|-----|
| `annie: command not found` | Le binaire global npm n’est pas dans le PATH | Exécutez `npm bin -g` pour trouver le chemin et ajoutez-le à `$PATH`. Ou passez à nvm — voir [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| `401 Unauthorized` from CLI | Le jeton ne correspond pas | Vérifiez que `CLI_API_TOKEN` dans `.env` correspond exactement à `~/.nest/config` ou à votre `export`. Pas de guillemets ni d’espaces |
| Web app blank / 502 Bad Gateway | Le serveur démarre encore | Attendez 30 s, puis exécutez `docker compose logs nest-server`. Repérez la ligne où le health check réussit |
| Port 80 already in use | Un autre service utilise le port 80 | Mettez `WEB_PORT=8080` dans `.env`, puis `docker compose restart` |
| `docker compose` not found | Docker Compose V1 installé | Mettez à jour Docker Desktop ou installez `docker-compose-plugin`. NEST utilise la V2 (`docker compose`, pas `docker-compose`) |
| Postgres connection errors | La base s’initialise | L’initialisation au premier lancement prend ~10 s. Attendez et réessayez. Consultez les journaux avec `docker compose logs postgres` |
| Session not appearing in dashboard | Mauvaise `NEST_API_URL` | L’URL affichée par `annie auth status` doit correspondre à l’adresse réelle du serveur (pas `localhost` si vous vous connectez depuis une autre machine) |

**Toujours bloqué ?** Exécutez `annie diagnose` sur la machine où la CLI est installée. Un rapport complet de diagnostic connectivité et authentification s’affiche.

---

## Déploiement en production

Pour une instance NEST exposée sur Internet (équipe distante, HTTPS, domaine personnalisé) :

1. Définissez `NEST_PUBLIC_URL=https://nest.yourdomain.com` dans `.env`
2. Configurez la terminaison TLS sur nginx (ou un équilibreur de charge devant)
3. Utilisez un `POSTGRES_PASSWORD` fort et laissez `PGPORT` vide (n’exposez pas Postgres vers l’extérieur)
4. Effectuez une rotation du `CLI_API_TOKEN` avec `openssl rand -hex 32` — puis mettez à jour toutes les CLI des collaborateurs avec `annie auth login`

Référence production complète : [DEVOPS.md](DEVOPS.md)

---

## Étapes suivantes

| Objectif | Où aller |
|---------------------|-------------|
| Résumé d’installation en 5 minutes | [QUICKSTART.md](../QUICKSTART.md) |
| Installer Node, Docker, Rust | [INSTALL-FRAMEWORKS.md](INSTALL-FRAMEWORKS.md) |
| Configurer les clés LLM (Vertex, OpenRouter, DeepInfra...) | [CLI-BUSINESS.md](CLI-BUSINESS.md) |
| Production, HTTPS, URL publique | [DEVOPS.md](DEVOPS.md) |
| Valeur business pour les fondateurs | [business/README.md](business/README.md) |
| Méthodologie de mise en œuvre | [methodology/README.md](methodology/README.md) |
| Fonctionnalités entreprise | [enterprise/README.md](enterprise/README.md) |
| Référence de toutes les commandes et de la configuration | [README.md](../README.md) |
| Prochaines évolutions | [ROADMAP.md](../ROADMAP.md) |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribution publique : [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI : [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
