<div align="center">

<img src="../../public/nest_logo.png" alt="NEST" width="200"/>

[![Telegram](https://img.shields.io/badge/Telegram-Join-26A5E4?style=flat-square&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

</div>

# Guide Enterprise — CLI Annie, MCP et intégration multi-clients

[Français](./annie-cli-mcp-enterprise-FR.md) | [English](./annie-cli-mcp-enterprise.md) | [Español](./annie-cli-mcp-enterprise-ES.md) | [Deutsch](./annie-cli-mcp-enterprise-DE.md) | [Português](./annie-cli-mcp-enterprise-PT.md) | [中文](./annie-cli-mcp-enterprise-ZH.md)

Ce document est la référence **niveau enterprise** pour déployer **Annie** (CLI `@contextzero/nest`), utiliser **toutes les surfaces de commande supportées** et intégrer **NEST MCP** avec ChatGPT, Claude, Cursor et VS Code.

**Langages de programmation :** NEST est **agnostique** vis-à-vis des langages de vos dépôts (Python, TypeScript, Rust, Go, Java, .NET, etc.). Les sessions sont liées à un **chemin de workspace** et à un **identifiant de session serveur**, pas à un seul runtime.

**Langues du document :** ce guide existe en **six langues naturelles** (EN, ES, DE, FR, PT, ZH) avec la **même structure par phases** dans chaque fichier.

---

## Sommaire

1. [Synthèse exécutive](#1-synthèse-exécutive)
2. [Modèle de phases — vue d’ensemble](#2-modèle-de-phases--vue-densemble)
3. [Phases du workflow d’ingénierie CTO](#3-phases-du-workflow-dingénierie-cto)
4. [Phases d’implémentation NEST 0–6](#4-phases-dimplémentation-nest-06)
5. [Phases de maturité technique MCP (M1–M4)](#5-phases-de-maturité-technique-mcp-m1m4)
6. [Phases de déploiement opérationnel (P0–P4)](#6-phases-de-déploiement-opérationnel-p0p4)
7. [Architecture](#7-architecture)
8. [CLI (`@contextzero/nest`) — référence des commandes](#section-8-cli-fr)
9. [Configuration et règles d’URL](#9-configuration-et-règles-durl)
10. [MCP — protocole, sécurité, points de terminaison](#10-mcp--protocole-sécurité-points-de-terminaison)
11. [Patterns par client](#11-patterns-par-client)
12. [Risques, validation, gouvernance](#12-risques-validation-gouvernance)
13. [Documents liés](#13-documents-liés)

---

## 1. Synthèse exécutive

| Couche | Question répondue |
|--------|-------------------|
| **Workflow CTO** | *Comment* raisonner avant livraison (analyse → conception → risque → implémentation) |
| **NEST 0–6** | *Quand* l’infrastructure, les agents et la gouvernance arrivent dans l’organisation |
| **MCP M1–M4** | *Comment* MCP évolue des fichiers locaux sûrs vers proxy serveur authentifié + IDE externes |
| **Ops P0–P4** | *Comment* passer du pilote à l’exploitation production |

**Exigences non négociables MCP enterprise**

1. **URL + Bearer** sur `POST /mcp/sessions/<session_id>` — jamais « URL seule ».
2. **Hygiène Git** pour `.cursor/mcp.json` et sauvegardes — surface de secrets locaux.
3. **Sous-commandes CLI explicites** en automatisation (`annie claude`, pas de défauts ambigus).

---

## 2. Modèle de phases — vue d’ensemble

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Workflow CTO    Analyse → Conception → Risque → Implémentation          │
│       │                      (continu ; gate à chaque phase NEST)          │
├─────────────────────────────────────────────────────────────────────────┤
│  NEST 0–6        Discovery → … → Operate   (cycle de vie plateforme)    │
├─────────────────────────────────────────────────────────────────────────┤
│  MCP M1–M4       Git sûr → Stale → Proxy serveur → IDE externe            │
├─────────────────────────────────────────────────────────────────────────┤
│  Ops P0–P4       Pilote → Standard → Worker → Échelle MCP → Exploitation   │
└─────────────────────────────────────────────────────────────────────────┘
```

**Lecture :** exécuter les **phases NEST** dans l’ordre. En **phases 2–4**, intégrer au minimum **MCP M1–M3** avant déploiement IDE massif. **P0–P4** pour le séquençage humain et la charge support. **Workflow CTO** à chaque portail.

---

## 3. Phases du workflow d’ingénierie CTO

### Phase A — Analyse

| Élément | Pratique |
|---------|----------|
| **Objectif** | Séparer symptômes et exigences ; rendre les hypothèses visibles |
| **Questions** | Qui exécute le CLI ? Qui possède le serveur ? MCP sur la surface d’attaque ? Données quittant le poste ? |
| **Livrables** | Carte parties prenantes, hypothèses de menace, inventaire transports MCP |
| **Sortie** | « Threat model MCP » une page validé sécurité / tech lead |

### Phase B — Conception

| Élément | Pratique |
|---------|----------|
| **Objectif** | Options réelles avec arbitrages explicites |
| **Options** | (1) MCP local seul, (2) MCP serveur avec Bearer, (3) Pont stdio (`annie mcp`) |
| **Arbitrages** | Sécurité vs confort ; audit central vs latence ; stdio vs HTTP natif |
| **Sortie** | Pattern choisi par persona (poste / runner / IDE externe) |

### Phase C — Risque

| Élément | Pratique |
|---------|----------|
| **Objectif** | Modes de défaillance et retour arrière |
| **Exemples** | Fuite token via `mcp.json` commité ; URLs localhost orphelines ; surface d’outils trop large |
| **Livrables** | Runbook rollback |
| **Sortie** | Exercice rollback documenté et propriétaire |

### Phase D — Implémentation

| Élément | Pratique |
|---------|----------|
| **Objectif** | Défauts défensifs, observabilité |
| **Pratiques** | Bearer obligatoire sur MCP serveur ; pas de secrets dans le repo ; logs stdio sur stderr |
| **Sortie** | Contrôles §12 OK sur l’environnement cible |

---

## 4. Phases d’implémentation NEST 0–6

Aligné sur la **[méthodologie NEST](../methodology/README.md)**.

### Phase 0 — Discovery

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Cartographier équipes, agents, IDEs ; métriques de succès |
| **Annie** | Besoins `annie claude` / `annie cursor` / `annie codex` ; OS et chemins |
| **MCP** | Cursor HTTP vs VS Code vs Claude stdio |
| **Livrables** | Liste pilote ; inventaire IDE ; brouillon politique « pas de MCP sans auth » |
| **Sortie** | Sponsor valide le périmètre pilote |

### Phase 1 — Strategy

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Modèle de jetons, routes proxy, récit conformité |
| **Annie** | Délivrance `CLI_API_TOKEN` (namespace équipe) ; coffre vs `annie auth login` |
| **MCP** | Nginx / edge doit proxifier **`/mcp/`** vers Rust ; TLS documenté |
| **Livrables** | Schéma d’architecture ; RACI rotation tokens |
| **Sortie** | Revue sécurité exposition URL MCP |

### Phase 2 — Foundation

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Serveur prêt prod ; secrets distribués |
| **Annie** | `NEST_API_URL` par env ; `annie auth status` sur images de référence |
| **MCP** | **M1** (gitignore) avant adoption Cursor large |
| **Livrables** | Runbook onboarding poste |
| **Sortie** | Health OK ; session exemple PWA |

### Phase 3 — Build

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Workers, configs IDE, ponts |
| **Annie** | `annie worker start` sur hôtes dédiés ; formation `list` / `stop-session` |
| **MCP** | **M2–M3** (détection stale + MCP proxifié runner) |
| **Livrables** | Modèle `mcp.json` `url` + `headers` (masqué) ; wrappers stdio |
| **Sortie** | E2E : action PWA → RPC → résultat outil |

### Phase 4 — Hardening

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Durcissement auth, scan secrets, formation |
| **Annie** | Image CI avec CLI épinglé ; `annie diagnose` dans docs support |
| **MCP** | **401** sans Bearer ; pre-commit `mcp.json` |
| **Livrables** | Preuves tests sécurité ; macros support |
| **Sortie** | Checklist §12 staging 100 % |

### Phase 5 — Launch

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Pilote → département → entreprise |
| **Annie** | Mesurer échecs session, déconnexions worker |
| **MCP** | Versions clients IDE ; tickets MCP |
| **Livrables** | Rétro lancement ; tableau KPI |
| **Sortie** | Revue sponsor vs métriques |

### Phase 6 — Operate

| Dimension | Détail |
|-----------|--------|
| **Objectifs** | Exploitation type SRE |
| **Annie** | Communication upgrade CLI trimestrielle ; échantillons logs |
| **MCP** | Calendrier rotation tokens ; revue surface outils |
| **Livrables** | Métriques op : MCP 4xx/5xx, latence RPC |
| **Sortie** | Backlog amélioration financé |

**RACI (exemple)**

| Activité | Engineering | Security | IT / Desktop | Support |
|----------|-------------|----------|--------------|---------|
| Émission token | C | A | I | I |
| Route nginx `/mcp/` | R | C | A | I |
| Runbooks MCP | R | C | I | A |
| Utilisateurs pilotes | A | I | C | R |

---

## 5. Phases de maturité technique MCP (M1–M4)

### M1 — Git et dépôt

| Élément | Action |
|---------|--------|
| **But** | Éviter commit accidentel config MCP injectée |
| **Actions** | `.gitignore` `**/.cursor/mcp.json`, `**/.cursor/mcp.json.nest-backup` ; formation |
| **Vérification** | CI grep échoue si `mcp.json` tracké |

### M2 — Entrées obsolètes

| Élément | Action |
|---------|--------|
| **But** | Moins d’URLs localhost mortes après crash |
| **Actions** | Logique injection Annie ; doc nettoyage manuel |
| **Vérification** | Crash simulé → prochain démarrage répare ou écrase |

### M3 — MCP proxifié serveur

| Élément | Action |
|---------|--------|
| **But** | Runner / Cursor distant utilise URL serveur |
| **Actions** | Base API effective + `/mcp/sessions/<id>` + **Bearer** ; `/mcp/` prod |
| **Vérification** | MCP OK si Cursor et worker sur hôtes différents |

### M4 — IDE externes

| Élément | Action |
|---------|--------|
| **But** | VS Code, Claude Desktop, connecteurs ChatGPT si supportés |
| **Actions** | Templates standard ; automatisation future type `annie mcp install` |
| **Vérification** | Client non-Cursor passe §12 |

---

## 6. Phases de déploiement opérationnel (P0–P4)

### P0 — Pilote (5–20 utilisateurs)

| Sujet | Détail |
|-------|--------|
| **Périmètre** | Un mode agent principal ; une famille IDE ; MCP optionnel mais Bearer si actif |
| **Durée** | Typiquement 2–4 semaines |
| **Métriques** | Taux succès session, zéro incident secret, heures support / user |
| **Sortie** | Go / no-go P1 |

### P1 — Standardiser

| Sujet | Détail |
|-------|--------|
| **Périmètre** | `NEST_API_URL` de référence ; `annie auth login` obligatoire ou env MDM |
| **MCP** | M1 org-wide |
| **Sortie** | Audit : 95 %+ machines `annie auth status` OK |

### P2 — Worker production

| Sujet | Détail |
|-------|--------|
| **Périmètre** | Hôtes runner dédiés ; astreinte `worker status` |
| **MCP** | M3 validé spawn distant |
| **Sortie** | Démo session distante PWA + entrée audit |

### P3 — Échelle MCP

| Sujet | Détail |
|-------|--------|
| **Périmètre** | MCP HTTP Cursor ; pont stdio ailleurs ; runbooks |
| **MCP** | Pilote M4 second client (ex. VS Code) |
| **Sortie** | MTTR connu incidents auth MCP |

### P4 — Régime de croisière

| Sujet | Détail |
|-------|--------|
| **Périmètre** | Rotation trimestrielle ; politique version CLI |
| **Métriques** | Erreurs RPC, codes HTTP MCP, redémarrages worker |
| **Sortie** | Preuves conformité continues |

---

## 7. Architecture

```
Poste employé                    Serveur NEST                   Clients
─────────────                    ────────────                   ───────
annie <agent>  ── Socket.IO ──►  Serveur Rust  ◄── SSE/REST ─  PWA / Telegram
     │                           Audit Postgres
     │                           POST /mcp/sessions/:sessionId
     ▼                                     ▲
Cursor / VS Code MCP  ── Streamable HTTP ──┘
```

**Invariantes :** `CLI_API_TOKEN` ; URL de base effective ; **`/mcp/sessions/<session_id>`** avec **Bearer**.

---

<a id="section-8-cli-fr"></a>

## 8. CLI (`@contextzero/nest`) — référence des commandes

Installation : **`npm install -g @contextzero/nest`** → binaire **`annie`**. La **référence complète** (mode Computer, terminaux PTY distants, résolution par défaut vers `cursor`, `hook-forwarder`, etc.) est dans la **version anglaise** : [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) — sans liens vers des dépôts privés.

**Enveloppes Computer (1er juin 2026) :** **OpenClaw**, **ZeroClaw** et **Hermes** dans **`annie computer`**. **Projets :** **gestion de projet — 1er mai 2026** · **CRM — 15 mai 2026** — [ROADMAP.md](../../ROADMAP.md) · détail en **anglais** §8.3 : [annie-cli-mcp-enterprise.md](./annie-cli-mcp-enterprise.md#section-8-cli-reference) · [zeroclaw.md](./zeroclaw.md).

| Domaine | Commande | Rôle |
|---------|----------|------|
| Claude | `annie claude [args…]` | Claude Code + NEST |
| Cursor | `annie cursor [args…]` | Cursor Agent |
| Codex | `annie codex [args…]` | Codex ; `annie codex resume <id>` |
| Gemini | `annie gemini [args…]` | Gemini (ACP) |
| OpenCode | `annie opencode [args…]` | OpenCode |
| KiloCode | `annie kilocode [args…]` | KiloCode |
| **Computer (gestion)** | `annie computer [args…]` | Agent multi-outils hub (shell, navigateur, fichiers, automatisation) |
| Auth | `annie auth login` / `status` / `logout` | Identifiants |
| Worker | `annie worker start` / `stop` / `status` / `list` / `stop-session <id>` / `logs` | Worker |
| MCP | `annie mcp [--url <url>] [--token \| --bearer <secret>]` | Stdio → MCP HTTP |
| Serveur | `annie server [--host …] [--port …]` | Hub empaqueté (si inclus dans votre installation) |
| Diagnostic | `annie diagnose` / `annie diagnose clean` | Diagnostic / nettoyage |
| Limité | `hook-forwarder` ; `connect` ; `notify` | Voir guide EN |

---

## 9. Configuration et règles d’URL

| Variable | Obligatoire | Description |
|----------|-------------|-------------|
| `CLI_API_TOKEN` | **Oui** | Doit correspondre au serveur |
| `NEST_API_URL` | Non | URL de base normalisée |
| `NEST_HOME` | Non | Défaut `~/.nest` |
| `NEST_HTTP_MCP_URL` | Non | Cible par défaut `annie mcp` |
| `NEST_MCP_BEARER_TOKEN` | Non | Bearer alternatif |

---

## 10. MCP — protocole, sécurité, points de terminaison

### 10.1 Point de terminaison

- **POST** `/mcp/sessions/<session_id>`
- **En-tête :** `Authorization: Bearer <token>`
- **Corps :** JSON-RPC 2.0 (MCP Streamable HTTP)

### 10.2 Exemple Cursor (`mcp.json`)

```json
{
  "mcpServers": {
    "nest": {
      "url": "https://nest.example.com/mcp/sessions/SESSION_ID",
      "headers": {
        "Authorization": "Bearer VOTRE_TOKEN"
      }
    }
  }
}
```

### 10.3 Pont stdio

```bash
# En production : variables d'environnement
export NEST_HTTP_MCP_URL="https://nest.example.com/mcp/sessions/SESSION_ID"
export CLI_API_TOKEN="…"
annie mcp
```

**URL et jeton en arguments** (tests locaux ; le jeton peut apparaître dans `ps` et l'historique) :

```bash
annie mcp --url "https://nest.example.com/mcp/sessions/SESSION_ID" --token "VOTRE_TOKEN"
```

`--bearer` est un alias de `--token`. Les arguments CLI priment sur l'environnement pour le jeton.

### 10.4 Git

`.cursor/mcp.json` local ; ne pas committer les jetons ; préférer injection depuis coffre.

---

## 11. Patterns par client

| Client | Pattern recommandé |
|--------|-------------------|
| **Cursor** | HTTP `url` + `headers.Authorization` |
| **VS Code** | HTTP natif extension **ou** stdio avec `annie mcp` |
| **Claude** | Stdio → `annie mcp` + env ou trousseau |
| **ChatGPT** | MCP HTTP custom si produit l’autorise |

Indépendant du **langage du dépôt**.

---

## 12. Risques, validation, gouvernance

| Risque | Atténuation |
|--------|-------------|
| Exfiltration token | Rotation ; namespaces ; coffre |
| URL MCP obsolète dans Git | `.gitignore`, CI, formation |
| Surface d’outils trop large | Revue sécurité |
| « Localhost sûr » | Bearer toujours requis |

**Checklist :** `annie auth status` ; `annie diagnose` ; MCP sans auth → **401** ; avec auth → `initialize` / `tools/list` ; PWA pilote la session.

---

## 13. Documents liés

| Document | Contenu |
|----------|---------|
| [CLI-BUSINESS.md](../CLI-BUSINESS.md) | Vue métier |
| [INSTALL.md](../INSTALL.md) | Installation |
| [DEVOPS.md](../DEVOPS.md) | HTTPS, proxy |
| [Methodology](../methodology/README.md) | NEST 0–6 |
| [Enterprise README](./README.md) | Enterprise |
| [Image nest-server](https://hub.docker.com/r/matiasbaglieri/nest-server) | Routes dans l’image publiée ; contrats documentés dans **nest_hub** |

---

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-ctx0__io-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ctx0_io)
[![Discord](https://img.shields.io/badge/Discord-Join_Server-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/ygjuuDAw)

*Distribution publique : [contextzero/nest_hub](https://github.com/contextzero/nest_hub) · CLI : [@contextzero/nest](https://www.npmjs.com/package/@contextzero/nest).*

</div>
