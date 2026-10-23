# Team C Demo — 15–20 minutes

## Demo safety
Use staging for failure injection. Never expose credentials, SSH private keys, webhook URLs, AWS account IDs, or secret environment variables on screen.

## Script
1. **Problem (2 min):** explain drift, slow manual release, and weak rollback visibility.
2. **Architecture (3 min):** PR gates → immutable image → staging → approval → production; Terraform state in S3; Prometheus/Grafana/Alertmanager.
3. **Live delivery (7 min):** make a small visible UI change, push a branch, open PR, show checks, merge, show SHA-tagged image and staging health check, then approve production promotion.
4. **Failure & rollback (3 min):** use a staging-only deliberately unhealthy revision, show failed health check/alert, redeploy last known-good SHA.
5. **Challenges/lessons (3 min):** secrets, least privilege, image tags, health checks, state locking, monitoring limits, AWS costs.
6. **Q&A (2 min).**

## Recruiter talking points
- Infrastructure is version-controlled and reproducible.
- Build artifacts are immutable and traceable to Git commits.
- Production has an explicit approval gate.
- Health checks verify deployment success rather than just SSH command completion.
- Monitoring and a written runbook support operational response.
