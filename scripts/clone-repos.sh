#!/bin/bash
echo "🌀 Клонування репозиторіїв..."
set -ex

REPOS=(
  "apps/client|git@github.com:maksym-nezhurin/client-app.git"
  "apps/admin|git@github.com:maksym-nezhurin/admin.git"
  "services/auth|git@github.com:maksym-nezhurin/auth-service.git"
  "services/user|git@github.com:maksym-nezhurin/user-service.git"
  "services/notification|git@github.com:maksym-nezhurin/notification-service.git"
  "services/car|git@github.com:maksym-nezhurin/car-service.git"
  "services/gateway|git@github.com:maksym-nezhurin/gateway.git"
  "infrastructure/keycloak|git@github.com:maksym-nezhurin/keycloak.git"
)

for entry in "${REPOS[@]}"; do
  dir="${entry%%|*}"
  url="${entry##*|}"
  if [ ! -d "$dir" ]; then
    echo "📦 Клоную $url → $dir"
    git clone "$url" "$dir"
  else
    echo "✅ $dir вже існує, пропускаю"
  fi
done