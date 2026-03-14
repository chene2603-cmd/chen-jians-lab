#!/bin/bash
set -e

if [ ! -f .env ]; then
  TOKEN=$(openssl rand -hex 32)
  echo "API_TOKEN=$TOKEN" > .env
  echo "[INFO] 已生成新的 API_TOKEN"
fi

export MAX_TIMESTEPS=${MAX_TIMESTEPS:-1000000}
export HEALTH_PORT=${HEALTH_PORT:-8080}

echo "[INFO] 启动 $PROJECT_NAME ..."
docker-compose up --build