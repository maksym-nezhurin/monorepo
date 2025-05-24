#!/bin/bash
set -e

NODE_DOCKERFILE_CONTENT='FROM node:18

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml* ./

RUN corepack enable && corepack prepare pnpm@9.15.2 --activate && pnpm install

COPY . .

CMD ["pnpm", "dev"]
'

echo "🐳 Генерація Dockerfile.dev файлів..."
for path in services/* apps/*; do
  if [ -d "$path" ] && [ ! -f "$path/Dockerfile.dev" ]; then
    echo "$NODE_DOCKERFILE_CONTENT" > "$path/Dockerfile.dev"
    echo "✅ Створено Dockerfile.dev у $path"
  else
    echo "⏭️  Пропущено $path (Dockerfile.dev вже існує)"
  fi
done
