# Runbook — Deployment failure and recovery

## First five minutes

1. Open the failed GitHub Actions run and identify the failing step: tests, image build/push, SSH, Compose, or health check.
2. Confirm whether the problem affects staging or production. Do not run failure experiments against production.
3. Check host reachability and disk pressure:
   ```bash
   ssh deploy@HOST 'uptime; df -h; free -m; docker ps -a'
   ```
4. Inspect service logs:
   ```bash
   cd /opt/team-c-app
   docker compose -f compose/server.yml logs --tail=150 frontend api db
   ```
5. Check the configured health endpoint and Prometheus targets. A failing app health check is not the same as a failed SSH connection.

## Common cases

### Image pull fails
- Confirm the SHA tag exists in Docker Hub and the host can authenticate.
- Check Docker Hub token scope/rate limits.
- Do not silently fall back to `latest`.

### Containers start but health check fails
- Check API logs and database connectivity.
- Confirm the API's actual health endpoint and the frontend's proxy configuration.
- Inspect environment variables without printing secrets into CI logs.
- Check `docker compose ps` and `docker inspect` health status.

### Database unavailable
- Confirm the DB container is healthy and `DATABASE_URL` host is `db` inside the Compose network.
- Check disk space and PostgreSQL logs.
- Never delete the database volume as a troubleshooting shortcut.
- Take/verify a backup before any destructive database action.

### Roll back
1. Identify the last known-good SHA from the successful deployment history.
2. Trigger the deploy workflow with that SHA or set `IMAGE_TAG` to it in the server `.env`.
3. Run:
   ```bash
   docker compose -f compose/server.yml pull
   docker compose -f compose/server.yml up -d
   docker compose -f compose/server.yml ps
   ```
4. Verify the health endpoint, logs, and dashboards.
5. Record the incident, root cause, and corrective action.

## Incident notes

Record timestamp, environment, deployed SHA, user impact, detection signal, root cause, recovery SHA, and follow-up action.
