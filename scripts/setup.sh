#!/bin/bash

set -e  # зупиняємось при помилках

# === Конфігурація репозиторіїв ===
GITHUB_BASE_URL="git@github.com:maksym-nezhurin"

# Репозиторії
declare -A REPOS=(
  [apps/client-app]="$GITHUB_BASE_URL/client-app.git"
  [apps/admin-panel]="$GITHUB_BASE_URL/admin-panel.git"
  [services/auth]="$GITHUB_BASE_URL/auth-service.git"
  [services/user]="$GITHUB_BASE_URL/user-service.git"
  [services/notification]="$GITHUB_BASE_URL/notification-service.git"
  [services/gateway]="$GITHUB_BASE_URL/gateway.git"
  [infrastructure/keycloak]="$GITHUB_BASE_URL/keycloak.git"
)

# === Клонування проектів ===
echo "🌀 Клонування репозиторіїв..."
for dir in "${!REPOS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "📦 Клоную ${REPOS[$dir]} → $dir"
    git clone "${REPOS[$dir]}" "$dir"
  else
    echo "✅ $dir вже існує, пропускаю"
  fi
done

# === Генерація .env для кожного сервісу ===
echo "🛠️ Генерація .env файлів..."
ENV_TEMPLATE="./config/env/.env.template"

if [ ! -f "$ENV_TEMPLATE" ]; then
  echo "❌ Не знайдено шаблон .env: $ENV_TEMPLATE"
  exit 1
fi

for path in services/* apps/* infrastructure/keycloak; do
  if [ -d "$path" ]; then
    cp "$ENV_TEMPLATE" "$path/.env"
    echo "✅ Скопійовано .env у $path"
  fi
done

echo "✅ Успішно завершено!"
