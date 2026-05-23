# Contributing to NEST

Great that you are here and you want to contribute to NEST — the self-hosted AI hub built by Context Zero (CTX0).

## Contents

- [Code of conduct](#code-of-conduct)
- [How the project is organized](#how-the-project-is-organized)
- [Contributing to this repository (public)](#contributing-to-this-repository-public)
- [Contributing to the product source (private)](#contributing-to-the-product-source-private)
- [Pull request guidelines](#pull-request-guidelines)
- [Contributor License Agreement](#contributor-license-agreement)

## Code of conduct

This project and everyone participating in it are governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to caro@ctx0.io.

## How the project is organized

NEST ships as prebuilt artifacts. Its code lives in two repositories:

- **`contextzero/nest_hub`** (this repository, public) — the **self-hosted distribution layer**: the Docker Compose stack, reverse-proxy configuration, `setup.sh`, public assets, and the documentation set. **There is no application source code here.**
- **`contextzero/nest`** (private) — the **product source**: the Rust server, the React/Vite PWA, and the `@contextzero/nest` (`annie`) CLI.

## Contributing to this repository (public)

For the deployment stack and docs in this repo:

1. Fork `contextzero/nest_hub`.
2. Create a branch from `main`.
3. Make your change (`docker-compose.yml`, `nginx/`, `setup.sh`, `docs/`, README / QUICKSTART, …).
4. If you changed `docker-compose.yml` or `setup.sh`, verify the stack still comes up: run `./setup.sh`, then `docker compose ps`.
5. Open a pull request against `main`.

## Contributing to the product source (private)

The Rust server, the PWA, and the CLI live in the **private** repository **`contextzero/nest`**. To contribute there you first need access:

> **Request access** by contacting **Matías Baglieri** at **matias@ctx0.io**. Include your GitHub username and a short note describing what you'd like to work on. Once you are granted access to **`contextzero/nest`**, the full development setup, build instructions, and architecture docs live inside that repository.

Do not open issues or PRs in this public repository for product source code — they belong in `contextzero/nest` once you have access.

## Pull request guidelines

- **Small PRs only** — focus on a single feature or fix per PR.
- **Conventional titles** — follow [NEST's PR Title Conventions](https://github.com/contextzero/nest_hub/blob/main/.github/pull_request_title_conventions.md).
- **Respond within 14 days** — if a change request goes unanswered, the PR may be closed; it can be reopened once addressed.
- **No secrets** — never commit generated secrets (`.env`, `CLI_API_TOKEN`, `ENCRYPTION_KEY`, database passwords).
- **Enterprise Edition files** — files containing `.ee.` in the filename or `.ee` in the dirname are under the [NEST Enterprise License](LICENSE_EE.md). Contact matias@ctx0.io before opening a PR that touches them.

## Contributor License Agreement

So that we do not have any potential problems later, it is necessary to sign a [Contributor License Agreement](CONTRIBUTOR_LICENSE_AGREEMENT.md). We use the simplest one that exists — it is from [Indie Open Source](https://indieopensource.com/forms/cla), uses plain English, and is only a few lines long.

Once a pull request is opened, an automated bot will request the signature. The pull request can only be merged once the signature is obtained.
