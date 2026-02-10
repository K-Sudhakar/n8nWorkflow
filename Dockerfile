FROM docker.n8n.io/n8nio/n8n:stable

ENV N8N_PORT=5678 \
    NODE_ENV=production \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_RUNNERS_ENABLED=true \
    GENERIC_TIMEZONE=UTC \
    TZ=UTC \
    N8N_METRICS=true \
    QUEUE_HEALTH_CHECK_ACTIVE=true

EXPOSE 5678
VOLUME ["/home/node/.n8n"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=5 \
  CMD wget -qO- http://127.0.0.1:5678/healthz > /dev/null || exit 1
