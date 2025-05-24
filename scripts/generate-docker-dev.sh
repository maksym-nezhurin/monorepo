#!/bin/bash
set -e

NODE_DOCKERFILE_DEV_CONTENT='FROM node:18

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml* ./

RUN corepack enable && corepack prepare pnpm@9.15.2 --activate && pnpm install

COPY . .

CMD ["pnpm", "dev"]
'

NODE_DOCKERFILE_PROD_CONTENT='FROM node:18-alpine

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml* ./

RUN corepack enable && corepack prepare pnpm@9.15.2 --activate && pnpm install --prod

COPY . .

CMD ["node", "dist/main.js"]
'

DOCKERIGNORE_CONTENT='
nginx
node_modules
dist
.git
.gitignore
Dockerfile*
*.log
'

echo "🐳 Генерація Dockerfile.dev і Dockerfile файлів..."
for path in services/* apps/*; do
  if [ -d "$path" ]; then

    # Dockerfile.dev
    if [ ! -f "$path/Dockerfile.dev" ]; then
      echo "$NODE_DOCKERFILE_DEV_CONTENT" > "$path/Dockerfile.dev"
      echo "✅ Створено Dockerfile.dev у $path"
    else
      echo "⏭️  Dockerfile.dev вже існує у $path, пропущено"
    fi

    # Dockerfile (продакшн)
    if [ ! -f "$path/Dockerfile" ]; then
      echo "$NODE_DOCKERFILE_PROD_CONTENT" > "$path/Dockerfile"
      echo "✅ Створено Dockerfile (продакшн) у $path"
    else
      echo "⏭️  Dockerfile (продакшн) вже існує у $path, пропущено"
    fi


    # .dockerignore
    if [ ! -f "$path/.dockerignore" ]; then
      echo "$DOCKERIGNORE_CONTENT" > "$path/.dockerignore"
      echo "✅ Створено .dockerignore у $path"
    else
      echo "⏭️  Пропущено $path (.dockerignore вже існує)"
    fi
  else
    echo "⏭️  $path не є директорією, пропущено"
  fi
done
