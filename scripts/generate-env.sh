#!/bin/bash
set -e

ENV_TEMPLATE="./config/env/.env.template"

if [ ! -f "$ENV_TEMPLATE" ]; then
  echo "❌ Не знайдено шаблон .env: $ENV_TEMPLATE"
  exit 1
fi

echo "🛠️ Генерація .env файлів..."
for path in services/* apps/* infrastructure/keycloak; do
  if [ -d "$path" ]; then
    cp "$ENV_TEMPLATE" "$path/.env"
    echo "✅ Скопійовано .env у $path"
  fi
done