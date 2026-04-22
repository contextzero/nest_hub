<div align="center">

<img src="./public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Rejoindre-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Rejoindre-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# NEST — Démarrage rapide

[English](./QUICKSTART.md) | [Español](./QUICKSTART-ES.md) | [中文](./QUICKSTART-ZH.md) | [Deutsch](./QUICKSTART-DE.md) | [Português](./QUICKSTART-PT.md) | **Français**

**Par Context Zero.** Plateforme d’automatisation de la force de travail en self-hosted — niveau entreprise.
De zéro à un hub de force de travail IA en direct en moins de 5 minutes.

---

## Avant de commencer — Ce que vous aurez une fois terminé

Dans les 5 prochaines minutes vous allez :

1. ✅ Déployer le serveur NEST (Rust + Postgres + nginx) en local avec **une seule commande**
2. ✅ Installer le CLI `annie` sur n’importe quelle machine
3. ✅ Lancer votre première vraie session d’agent IA (Claude Code, Codex, Cursor, Gemini, OpenCode ou KiloCode — et à partir du **1er juin 2026**, ZeroClaw / OpenClaw **via `annie computer`**)
4. ✅ La suivre **en direct depuis le navigateur** — et depuis le téléphone

Aucune connaissance Rust préalable requise. Pas de compte cloud nécessaire. Pas de carte bancaire. Si Docker tourne sur votre machine, NEST tourne sur votre machine.

---

## Étape 0 — Prérequis (2 minutes si besoin)

Il vous faut trois choses. Vérifiez chacune :

```bash
node -v             # Must be v18 or higher
npm -v              # Any recent version
docker -v           # Any recent version
docker compose version  # V2 syntax (not docker-compose)
```

**Les quatre passent ?** Passez à l’étape 1.

**Il manque quelque chose ?** → [docs/INSTALL-FRAMEWORKS.md](docs/INSTALL-FRAMEWORKS.md) — installe Node, npm et Docker en quelques minutes sur Mac, Linux ou Windows.

> **Pourquoi cela ?** Node + npm alimentent le CLI `annie` que vous installerez sur les machines des collaborateurs. Docker exécute le serveur sans que vous ayez à installer Rust, Postgres ou nginx vous-même.

---

## Étape 1 — Déployer le Hub (60 secondes)

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

C’est tout. `setup.sh` génère automatiquement tous les secrets, tire les images Docker, démarre la stack et attend le health check. Lorsque vous voyez :

```
=== NEST ready ===
  Web:  http://localhost
```

Votre hub est en ligne. Ouvrez-le dans le navigateur — et sur le téléphone.

> **Que s’est-il passé ?** `setup.sh` a créé un `.env` avec `POSTGRES_PASSWORD`, `CLI_API_TOKEN` et `ENCRYPTION_KEY` générés automatiquement. Il a ensuite tiré et démarré quatre conteneurs : `nest-server` (Rust), `nest-web` (React PWA), `postgres` et `nginx`.

---

## Étape 2 — Installer le CLI sur n’importe quelle machine (30 secondes)

Le CLI `annie` est ce que vos collaborateurs (ou vous) installent sur les machines où tournent les agents IA. Installez-le globalement :

```bash
npm install -g @contextzero/nest
```

Vérifiez que tout fonctionne :

```bash
annie --help
```

Vous devriez voir la liste complète des commandes. Le CLI est prêt sur cette machine.

> **Une installation par machine.** Chaque personne qui lancera des sessions d’agent doit installer `annie` sur sa propre machine et le pointer vers votre serveur.

---

## Étape 3 — Se connecter à votre serveur (30 secondes)

Deux options — choisissez-en une :

**Option A : Variables d’environnement (idéal pour les scripts et la CI)**

```bash
export CLI_API_TOKEN="same-token-from-your-env-file"
export NEST_API_URL="http://localhost"
```

> **Où est votre token ?** `setup.sh` l’a enregistré dans `.env`. Exécutez : `grep CLI_API_TOKEN .env` pour le voir.

**Option B : Connexion interactive (enregistre les identifiants de façon permanente)**

```bash
annie auth login
# Enter your NEST_API_URL when prompted: http://localhost
# Enter your CLI_API_TOKEN when prompted
```

Vérifiez la connexion :

```bash
annie auth status
```

Vous devriez voir l’URL du serveur et un token confirmé. **Vous êtes authentifié.**

---

## Étape 4 — Lancer votre première session d’agent

Choisissez votre agent et exécutez une commande (paquet **`@contextzero/nest`** → **`annie`**). **Référence enterprise :** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md).

| Agent | Commande | Rôle |
|-------|----------|------|
| **Claude Code** | `annie claude` | Agent de code phare d’Anthropic |
| **Codex** | `annie codex` | Agent d’exécution de code OpenAI |
| **Cursor** | `annie cursor` | Mode agent de l’IDE Cursor |
| **Gemini** | `annie gemini` | Agent multimodal Google |
| **OpenCode** | `annie opencode` | Agent de code open source |
| **KiloCode** | `annie kilocode` | Exécution de tâches + contrôle à distance |
| **Computer (gestion)** | `annie computer` | Agent multi-outils sur le hub (shell, navigateur, fichiers) |

> **ZeroClaw / OpenClaw :** à partir du **1er juin 2026**, intégrés **dans `annie computer`** comme enveloppes (même schéma que Claude, Cursor, …). Pas de sous-commandes `annie` séparées. Voir [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) et [RELEASES.md](RELEASES.md).

**Automatisation :** si le premier argument n’est pas un sous-commande connu, l’appel est traité comme **`annie cursor`**. En CI, utilisez toujours `annie claude`, `annie computer`, etc.

Exemple — lancer Claude Code :

```bash
annie claude
```

Le terminal affichera la session en cours de connexion et de flux. **Ne fermez pas ce terminal.** L’agent est actif.

---

## Étape 5 — Votre moment eureka 🎯

Passez au navigateur (ou au téléphone) et ouvrez :

```
http://localhost
```

**Vous devriez maintenant voir la session en direct dans le tableau de bord.**

Depuis là vous pouvez :
- 💬 **Discuter** avec l’agent en cours d’exécution en temps réel
- ✅ **Approuver ou refuser** les demandes d’autorisation de l’agent
- 🖥️ **Suivre la sortie du terminal** pendant l’exécution
- 📱 **Tout faire depuis le téléphone** — la PWA fonctionne sur tout navigateur mobile

C’est le moment. Vous venez de transformer une session CLI sur le portable de quelqu’un en **session IA visible à distance, approuvable et auditable** que vous pouvez superviser de n’importe où.

---

## Référence rapide — Commandes les plus utiles

```bash
annie claude            # Session Claude Code
annie codex             # Session Codex
annie cursor            # Agent Cursor
annie gemini            # Session Gemini
annie opencode          # Session OpenCode
annie kilocode          # Session KiloCode
annie computer          # Agent multi-outils (gestion)
annie worker start      # Worker en arrière-plan
annie worker list       # Sessions worker actives
annie auth login        # Enregistrer les identifiants
annie auth status       # État d’authentification
annie diagnose          # Diagnostic
```

**Gestion du serveur (depuis le dossier `nest_hub/`) :**

```bash
docker compose up -d        # Start the stack
docker compose down         # Stop the stack
docker compose logs -f      # Stream all logs
docker compose ps           # Check container status
docker compose restart      # Restart after .env changes
```

---

## Ce qui vient de se passer — Et pourquoi c’est important

Vous disposez maintenant de :

| Quoi | Où | Pourquoi c’est important |
|------|-----|---------------------------|
| Tableau de bord des sessions en direct | Navigateur / téléphone | Voir chaque session d’agent lancée par l’équipe, en temps réel |
| Workflow d’approbation | PWA mobile | Les agents attendent votre validation avant les actions à fort enjeu |
| Journal d’audit complet | Votre PostgreSQL | Chaque message, chaque action, persisté sur votre serveur |
| Support multi-agents | Toute machine collaborateur | Claude Code, Codex, Cursor, Gemini, OpenCode, KiloCode, plus **Computer** (enveloppes ZeroClaw / OpenClaw à partir du **1er juin 2026**) — le tout dans un hub |
| Coût mensuel nul | Votre infrastructure | Vous possédez le serveur, les données et les clés |

> **Prêt à aller plus loin ?** Parcourez cette documentation :
> - [Business Overview](docs/business/README.md) — Valeur stratégique pour les fondateurs
> - [Value Proposition](docs/business/value-proposition.md) — Avantages détaillés
> - [Methodology](docs/methodology/README.md) — Guide de mise en œuvre
> - [Enterprise Features](docs/enterprise/README.md) — Pour les organisations à l’échelle

---

## Étapes suivantes

| Ce que vous voulez faire | Où aller |
|--------------------------|----------|
| Déployer sur un vrai serveur avec HTTPS | [docs/DEVOPS.md](docs/DEVOPS.md) |
| Configurer les clés LLM (Vertex, OpenRouter, DeepInfra, ElevenLabs...) | [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md) |
| Ajouter d’autres machines collaborateurs | Partagez ce doc + votre `NEST_API_URL` + le token |
| Comprendre les modes d’agent OpenClaw / ZeroClaw | [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md) |
| Valeur business pour les fondateurs | [docs/business/README.md](docs/business/README.md) |
| Méthodologie de mise en œuvre | [docs/methodology/README.md](docs/methodology/README.md) |
| Référence complète des variables d’environnement | [README.md](README.md) |
| Voir la suite | [ROADMAP.md](ROADMAP.md) |
| Consulter le changelog | [RELEASES.md](RELEASES.md) |

---

## Dépannage — Correctifs rapides

| Problème | Solution |
|----------|----------|
| `annie` introuvable après installation | Relancez `npm install -g @contextzero/nest` ; vérifiez votre `$PATH` |
| Application web vide / ne charge pas | Attendez 30 s pour l’init de la BD ; exécutez `docker compose logs nest-server` |
| `401 Unauthorized` dans le CLI | Token incorrect — `setup.sh` le génère automatiquement. Exécutez `grep CLI_API_TOKEN .env` pour voir votre token. |
| Port 80 déjà utilisé | Définissez `WEB_PORT=8080` dans `.env`, puis `docker compose restart` |
| Session absente du tableau de bord | Vérifiez que `NEST_API_URL` dans le CLI pointe vers la bonne adresse serveur |
| Autre problème | Exécutez `annie diagnose` — il affiche un rapport de diagnostic complet |

---

> **Vous faites tourner un hub de force de travail IA de niveau entreprise. Gratuitement. Sur votre propre infrastructure.**
> 
> Quand vous voudrez aller plus loin — HTTPS, plusieurs équipes, routage LLM personnalisé — tout est dans [docs/DEVOPS.md](docs/DEVOPS.md) et [docs/CLI-BUSINESS.md](docs/CLI-BUSINESS.md).

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribution publique : [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI : [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
