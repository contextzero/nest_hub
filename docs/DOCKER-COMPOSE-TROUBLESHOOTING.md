# Docker Compose Troubleshooting

This FAQ covers common local self-hosting problems when bringing up NEST with
Docker Compose.

## `docker compose` command not found

NEST expects Compose V2. Verify:

```bash
docker compose version
```

If this fails, update Docker Desktop or Docker Engine until the integrated
`docker compose` command is available.

## Port `80` already in use

Symptoms:

- `nginx` fails to start
- Compose reports a bind error

Fix options:

1. Stop the process already using port `80`.
2. Change the published web port in your local `.env` or Compose override.
3. Restart the stack:

```bash
docker compose up -d
```

If you remap the port, use the same host and port in `NEST_API_URL`.

## Stack never turns healthy

Check current state:

```bash
docker compose ps
docker compose logs nest-server --tail=100
docker compose logs postgres --tail=100
docker compose logs nginx --tail=100
```

Typical causes:

- stale or partially edited `.env`
- failed image pull
- local filesystem permission problem on mounted files
- PostgreSQL still warming up on the first start

## Browser works but CLI auth fails

Check:

```bash
grep CLI_API_TOKEN .env
annie auth status
```

Verify that:

- the stack is healthy
- the CLI token matches `.env`
- the CLI points at the same host and port exposed by nginx

## Need a clean restart

For a normal restart:

```bash
docker compose down
docker compose up -d
docker compose logs -f
```

After `.env` changes:

```bash
docker compose down
docker compose up -d --force-recreate
```

## What to include in a bug report

Open an issue with:

- host OS
- Docker version
- exact failing command
- redacted `docker compose ps`
- redacted logs from affected containers

Never post secrets, tokens, or full `.env` contents.
