<div align="center">

<img src="./public/nest_logo.png" alt="NEST Logo" width="280"/>

<br/>

**Plateforme d'Automatisation de la Main-d'Œuvre — Auto-hébergée — Enterprise Grade**
<br/>
<em>Le système d'exploitation de la façon dont votre entreprise travaille avec l'IA.</em>
<br/>
<em>Votre hub. Vos données. Votre main-d'œuvre IA. Au creux de votre main.</em>

<br/>

[![Telegram](https://img.shields.io/badge/Telegram-Rejoindre-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Rejoindre-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)
[![GitHub Stars](https://img.shields.io/github/stars/contextzero/nest_hub?style=flat-square&color=DAA520)](https://github.com/contextzero/nest_hub/stargazers)
[![Docker](https://img.shields.io/badge/Docker-Prêt-2496ED?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/u/matiasbaglieri)
[![npm](https://img.shields.io/npm/v/@contextzero/nest?style=flat-square&logo=npm&label=CLI)](https://www.npmjs.com/package/@contextzero/nest)

[English](./README.md) | [Español](./README-ES.md) | [中文](./README-ZH.md) | [Deutsch](./README-DE.md) | [Português](./README-PT.md) | [Français](./README-FR.md)

</div>

---

## Qu'est-ce que NEST ?

> **Oui, vous avez encore 15+ applications**—et cette fragmentation faisait déjà mal en 2018. Aujourd'hui s'ajoute l'**IA d'entreprise dans l'ombre** : les équipes utilisent déjà ChatGPT, Claude, Cursor, Copilot, des outils d'image et des clés API éparses—vous ne savez souvent **où**, **quel modèle** ni **ce que ça coûte**. Les prompts repartent de zéro dans chaque onglet ; quand quelqu'un part, le **jugement affiné avec l'IA** sort avec lui. Vous avez des tableaux de bord pour le chiffre d'affaires et les serveurs, pas pour **comment le travail se fait réellement avec l'IA**.

**NEST** est la **couche auto-hébergée que votre entreprise exécute** : **projets**, **rôles**, **mémoire** et **gouvernance** pour que les agents et le chat tournent **sous vos URL, vos jetons et votre journal d'audit**—pas comme une TI invisible.

**NEST** est aussi une **plateforme complète d'automatisation de la main-d'œuvre** : code, chat et usage ordinateur dans un seul hub—téléphone, tablette et bureau.

> Vous déployez : une commande Docker sur votre serveur.
> Votre équipe obtient : un hub de main-d'œuvre IA en temps réel, accessible depuis n'importe quel appareil.

### Trois surfaces — au sein des projets que vos administrateurs possèdent

Le travail est regroupé dans des **projets** créés par vos administrateurs. Cela donne un **suivi par projet** (qui a fait quoi, dans quelle session), une **banque de mémoire** qui accumule le contexte par utilisateur et par équipe (l'« âme » de la façon dont chacun travaille avec l'IA) et des **approbations** avant les actions à haut risque—au lieu d'onglets de navigateur isolés.

| Surface | Ce que les employés obtiennent aujourd'hui | Notes |
|--------|----------------------------|--------|
| **Développement** | **Claude Code**, **Cursor**, **Codex**, **OpenCode** et **KiloCode** via la CLI **`annie`** (`npm install -g @contextzero/nest`), avec **MCP** pour **Cursor** et **Visual Studio Code** | [Référence complète CLI + MCP](docs/enterprise/annie-cli-mcp-enterprise.md) |
| **Chat** | Un chat hub sur **web, bureau et PWA mobile** alimenté par **OpenRouter**, **Fal.ai**, **Google Vertex AI** et **DeepInfra** — **plus de 700** modèles **texte, image, audio et vidéo** | Les clés fournisseur restent sur le **serveur** ; les employés s'authentifient sur **votre** hub |
| **Computer** | **`annie computer`** — usage ordinateur synchronisé au hub depuis la CLI et la PWA (shell, navigateur si activé, fichiers, runbooks). À partir du **1er juin 2026**, **OpenClaw**, **ZeroClaw** et **Hermes** sont livrés comme **enveloppes dans Computer** (même schéma que Claude, Cursor, …)—pas comme sous-commandes `annie` isolées ([détail](docs/enterprise/zeroclaw.md)) | Même posture **examiner → approuver → exécuter** que pour les sessions de développement |

### Feuille de route produit (2026)

| Date | Jalon |
|------|-----------|
| **1er mai 2026** | **Gestion de projet** dans les projets — backlogs, états de flux et visibilité entre les tâches |
| **15 mai 2026** | **CRM** — contacts et cycle de vie (ex. avant-vente → vente → après-vente) partagés **entre projets** |
| **1er juin 2026** | **Enveloppes `annie computer`** — **OpenClaw**, **ZeroClaw** et **Hermes** intégrés **dans Computer** (même schéma d'attachement que les autres agents soutenus par le hub) |

Le routage conscient des rôles (l'employé **examine → approuve →** exécution sur **Computer**, **Claude**, **Cursor**, etc.) relie ces modules—voir [ROADMAP.md](ROADMAP.md) pour le périmètre et les notes de livraison.

### Vidéo produit


https://github.com/user-attachments/assets/abfe0d75-8808-45a6-a671-8b84dd21fd2f


Également dans le dépôt : [`public/nest_hub_v0.2.73.mp4`](./public/nest_hub_v0.2.73.mp4)

### Les Quatre Piliers

| Pilier | Signification |
|--------|--------------|
| **Hub pour l'Entreprise** | Une app remplace Slack + Notion + Trello + WhatsApp. Projets → Employés → Sessions. |
| **Mobile pour l'Employé** | PWA fonctionne sur tout téléphone. Approuvez des déploiements dans le bus. Sans ordinateur portable. |
| **Banque de Mémoire (Souls)** | Le hub apprend chaque employé. Plus besoin de ré-expliquer le contexte à chaque session. |
| **Essaim d'Agents** | Plusieurs agents IA spécialisés travaillant en parallèle. |

---

## Démarrage Rapide — En ligne en 5 minutes

```bash
git clone https://github.com/contextzero/nest_hub.git
cd nest_hub
./setup.sh
```

> **Guide détaillé :** [QUICKSTART.md](QUICKSTART.md)

---

## Agents pris en charge

| Agent | Commande | Description |
|-------|----------|-------------|
| **Claude Code** | `annie claude` | Agent de code phare d'Anthropic |
| **Cursor** | `annie cursor` | Mode agent IDE Cursor |
| **Codex** | `annie codex` | Agent d'exécution de code OpenAI |
| **Gemini** | `annie gemini` | Agent multimodal Google |
| **OpenCode** | `annie opencode` | Agent de code open source |
| **KiloCode** | `annie kilocode` | Exécution de tâches + contrôle à distance |
| **Computer (gestion)** | `annie computer` | Agent multi-outils synchronisé au hub : shell, navigateur, fichiers, git, processus, planification—au-delà d'un seul IDE |
| **ZeroClaw** | *via `annie computer` (à partir du 1 juin 2026)* | Enveloppe d'automatisation headless — tâches autonomes auto-correctrices ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **OpenClaw** | *via `annie computer` (à partir du 1 juin 2026)* | Enveloppe d'orchestration — workflows multi-étapes + contrôle navigateur ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |
| **Hermes** | *via `annie computer` (à partir du 1 juin 2026)* | Enveloppe d'usage ordinateur aux côtés d'OpenClaw / ZeroClaw ([zeroclaw.md](docs/enterprise/zeroclaw.md)) |

```bash
npm install -g @contextzero/nest
annie --help
```

> **Computer vs `annie` nu :** À partir du **1er juin 2026**, **OpenClaw**, **ZeroClaw** et **Hermes** s'exécutent comme **enveloppes dans `annie computer`** (même schéma que Claude, Cursor, Codex, …)—voir [docs/enterprise/zeroclaw.md](docs/enterprise/zeroclaw.md). **Pas** de commandes autonomes `annie openclaw` / `annie zeroclaw` / `annie hermes`. Dans les scripts et la CI, utilisez toujours une sous-commande explicite (`annie claude`, `annie computer`, …). Si le premier jeton n’est pas une sous-commande connue, la CLI se comporte comme **`annie cursor`**.

### Déploiement enterprise — CLI (`@contextzero/nest`)

Séquence pour **macOS, Windows et Linux** où les employés utilisent Cursor, Claude Code, Codex, OpenCode ou KiloCode. Après **`npm install -g @contextzero/nest`** (paquet npm officiel de la CLI, binaire **`annie`**) chaque poste peut être relié à **votre** instance NEST ; Context Zero n'héberge pas votre hub auto-hébergé et ne rejoint pas votre réseau.

**1. Installer la CLI (IT ou employé, Node.js LTS + npm) :**

```bash
npm install -g @contextzero/nest
annie --version
```

**2. Authentifier la machine contre votre hub**

À exécuter une fois par profil (ou automatiser via MDM / coffre de secrets avec les mêmes variables que `annie auth login` enregistre) :

```bash
annie auth login
```

Vous serez invité à saisir l'**URL de base de votre déploiement** (par ex. `https://nest.votreentreprise.com`, fournie par votre organisation) et un **jeton d'API CLI** généré par vos administrateurs sur le serveur. Vérifier la connectivité :

```bash
annie auth status
```

**3. Points d'entrée courants (après connexion)**

| Surface | Commande | Rôle |
|---------|----------|------|
| **Claude Code** | `annie claude` | Sessions Claude Code |
| **Cursor** | `annie cursor` | Mode agent Cursor |
| **Codex** | `annie codex` | Sessions Codex (`annie codex resume <id>` le cas échéant) |
| **Gemini** | `annie gemini` | Sessions Gemini |
| **OpenCode** | `annie opencode` | Sessions OpenCode |
| **KiloCode** | `annie kilocode` | Exécution KiloCode |
| **Computer** | `annie computer` | Agent de gestion multi-outils (shell, navigateur, fichiers, processus) |
| **Pont MCP** | `annie mcp` | MCP stdio vers votre hub (cible HTTP + jeton) |
| **Worker** | `annie worker start` · `list` · `stop-session <id>` | Travail en arrière-plan lié au hub |
| **Terminaux hub** | *(PWA ↔ serveur ↔ PTY dans la CLI)* | Shells distants pour opérateurs (surface privilégiée) |

Distribuez **uniquement** des URL et jetons émis par **votre** domaine d'entreprise et vos systèmes d'identité. Les employés doivent installer la **PWA ou les clients** via des liens que vous contrôlez (intranet, MDM, pages de téléchargement de marque), puis utiliser mobile, tablette ou bureau pour approuver le travail, superviser les sessions et auditer l'activité—sans partager d'identifiants hors de votre tenant.

**Pour aller plus loin :** [docs/enterprise/annie-cli-mcp-enterprise.md](docs/enterprise/annie-cli-mcp-enterprise.md) — surface complète : agents IDE, **`annie computer`**, **terminaux distants (PTY)**, worker, MCP, diagnostic ; sans lien vers des dépôts sources privés.

**Automatisation :** si le premier argument n’est pas un sous-commande connue, l’invocation est traitée comme **`annie cursor`**. En CI, utilisez toujours un sous-commande explicite (`annie claude`, `annie computer`, etc.).

---

## Communauté

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Rejoindre-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

---

## Avis important — déploiements auto-hébergés, responsabilité et accès

Ce qui suit est un **avis d'information général** à l'intention des clients et opérateurs. Ce **n'est pas** un conseil juridique personnalisé ; votre conseil doit l'examiner au regard de vos contrats, juridictions et obligations réglementaires.

**Usage et conformité.** Votre organisation—**et non** Context Zero Inc. (y compris sociétés affiliées, sous-traitants ou personnel, ensemble « **Context Zero** »)—est **seule responsable** de la manière dont vous déployez, configurez, sécurisez et utilisez NEST Hub, y compris toutes les sorties des agents IA, intégrations, traitement des données, pratiques d'emploi, contrôles à l'export, confidentialité, réglementations sectorielles et politiques internes. Context Zero ne supervise pas votre environnement d'exécution et n'assume aucune responsabilité pour les décisions de vos employés, agents ou systèmes sur votre infrastructure.

**Connectivité auto-hébergée.** Lorsque vous exploitez NEST en logiciel **auto-hébergé** sur une infrastructure que vous maîtrisez, **Context Zero n'exploite pas ce serveur**, ne reçoit pas de connexion administrative automatique vers celui-ci et **ne peut pas accéder** à votre installation du seul fait que vous avez téléchargé ou sous-licencié des éléments chez nous. Votre hub est joint par vos utilisateurs et outils (par ex. la CLI `annie` fournie par `@contextzero/nest`) en **sortant** vers les points de terminaison **que vous** configurez (votre DNS, vos certificats TLS, vos jetons). Sauf contrat distinct de services managés prévoyant explicitement l'administration à distance et son périmètre d'accès, **aucun membre de l'équipe Context Zero ne dispose d'un accès entrant** à vos serveurs dans le cadre du modèle produit auto-hébergé décrit dans ce dépôt.

**Absence de mandat.** Rien dans ce README ne crée de partenariat, coentreprise ou mandat. Context Zero est un fournisseur de logiciels ; **votre société reste exclusivement responsable** de l'usage licite, de la gouvernance des équipes et de la sécurité de votre déploiement.

---

**© 2025–2026 Context Zero** — Plateforme d'Automatisation de la Main-d'Œuvre Auto-hébergée

<div align="center">

*Distribution publique : [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI : [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
