#!/bin/bash
set -e

GITHUB_BASE_URL="git@github.com:maksym-nezhurin"

declare -A REPOS=(
  [apps/client]="$GITHUB_BASE_URL/client-app.git"
  [apps/admin]="$GITHUB_BASE_URL/admin.git"
  [services/auth]="$GITHUB_BASE_URL/auth-service.git"
  [services/user]="$GITHUB_BASE_URL/user-service.git"
  [services/notification]="$GITHUB_BASE_URL/notification-service.git"
  [services/gateway]="$GITHUB_BASE_URL/gateway.git"
  [infrastructure/keycloak]="$GITHUB_BASE_URL/keycloak.git"
)

echo "🌀 Клонування репозиторіїв..."
for dir in "${!REPOS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "📦 Клоную ${REPOS[$dir]} → $dir"
    git clone "${REPOS[$dir]}" "$dir"
  else
    echo "✅ $dir вже існує, пропускаю"
  fi
done
