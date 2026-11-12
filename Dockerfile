# n8n is distributed as a ready-to-run image. We wrap it in a tiny Dockerfile so
# Kamal can tag/push per-version builds to GHCR and roll back by image tag.
FROM docker.n8n.io/n8nio/n8n:1.123.95
