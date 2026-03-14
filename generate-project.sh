#!/bin/bash
set -e

source config.sh

if [ -z "$1" ]; then
  echo "用法: ./generate-project.sh <项目名称>"
  exit 1
fi

PROJECT_NAME=$1
TARGET_DIR="projects/$PROJECT_NAME"

mkdir -p "$TARGET_DIR/src/middleware"
cp template/* "$TARGET_DIR/"
cp -r template/src/* "$TARGET_DIR/src/"

# 替换占位符
sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET_DIR/start.sh"
sed -i "s/{{MAX_TIMESTEPS}}/$MAX_TIMESTEPS/g" "$TARGET_DIR/src/middleware/security.js"
sed -i "s/{{NODE_VERSION}}/$NODE_VERSION/g" "$TARGET_DIR/Dockerfile"

chmod +x "$TARGET_DIR/start.sh"

echo "[✅] 项目 $PROJECT_NAME 已生成在 $TARGET_DIR"