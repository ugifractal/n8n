# n8n

Self-hosted [n8n](https://n8n.io) workflow automation, deployed with [Kamal 2](https://kamal-deploy.org) to `drx.catfish-algol.ts.net`.

- URL: <https://n8n.duruxignition.com>
- Image: `ghcr.io/ugifractal/n8n` (wrapper around `docker.io/n8nio/n8n:1.123.95`)
- Database: PostgreSQL 16 accessory (`n8n-db`), data at `n8n-db/data/postgres-16-n8n` on the host
- n8n data volume: `n8n_data` → `/home/node/.n8n`
- TLS: terminated at Cloudflare, so `proxy.ssl` is `false` (same pattern as the other apps on this host)

## Prerequisites

`.kamal/secrets` (gitignored) must contain:

```
GHCR_TOKEN=<GitHub PAT with write:packages>
POSTGRES_PASSWORD=<openssl rand -hex 24>
DB_POSTGRESDB_PASSWORD=<same value as POSTGRES_PASSWORD>
N8N_ENCRYPTION_KEY=<openssl rand -hex 32>
```

> Keep `N8N_ENCRYPTION_KEY` and the DB password somewhere safe. Without the
> encryption key, every credential stored in n8n becomes unrecoverable.

## Deploy

```bash
kamal accessory boot db   # first time only (or after the host is rebuilt)
kamal deploy
```

## Operations

```bash
kamal logs                 # tail app logs
kamal shell                # shell inside the n8n container
kamal db                   # psql into n8n_production
kamal rollback <version>   # roll back to a previous image tag (git sha)
kamal details              # container status on the server
```

## Updating n8n

Bump the tag in `Dockerfile`, then `kamal deploy`.
