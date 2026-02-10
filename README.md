# n8n Docker Starter (Hostinger-ready)

This repository runs n8n in Docker, exposes port `5678`, and persists all n8n data in a Docker volume.
The default `docker-compose.yml` is aligned to Hostinger's image-based recommendation.

## Files

- `Dockerfile`: optional custom image (not required for Hostinger compose deployment).
- `docker-compose.yml`: service definition, port mapping, and persistent volume.
- `workflows/hello-world.json`: sample workflow to import and run.
- `scripts/test-container.sh`: simple health test script.

## 1) Build and start

```bash
cp .env.example .env
```

```bash
docker compose up -d
```

Open n8n at: `http://localhost:5678`

If you want to use your custom `Dockerfile` instead of `n8nio/n8n:latest`:

```bash
docker build -t n8n-hostinger .
docker volume create n8n_data
docker run -d --name n8n \
  -p 5678:5678 \
  --env-file .env \
  -v n8n_data:/home/node/.n8n \
  n8n-hostinger
```

## 2) Test container health

```bash
sh scripts/test-container.sh
```

Expected result: `n8n is healthy and reachable.`

## 3) Import and run test workflow

1. In n8n UI, click **Import from File**.
2. Select `workflows/hello-world.json`.
3. Click **Execute workflow**.
4. Confirm `Set Message` outputs:
   - `message: Hello from n8n running in Docker`

## 4) Stop

```bash
docker compose down
```

## Hostinger deployment notes

- Push this repo to GitHub.
- In Hostinger Docker deployment, use `docker-compose.yml` from repo root.
- Expose container port `5678`.
- Attach persistent storage to `/home/node/.n8n` (or keep using Docker named volume if supported).
- In `.env`, set:
  - `N8N_HOST=your-domain.com`
  - `N8N_PROTOCOL=https`
  - `WEBHOOK_URL=https://your-domain.com/`
- Set timezone if needed: `GENERIC_TIMEZONE=Asia/Kolkata` (example).
