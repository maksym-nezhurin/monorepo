#!/bin/bash
set -e

echo "=== Запуск клонування репозиторіїв ==="
./clone-repos.sh

echo "=== Генерація .env файлів ==="
./scripts/generate-env.sh

echo "=== Генерація Dockerfile.dev ==="
./scripts/generate-docker-dev.sh

echo "✅ Успішно завершено setup"
