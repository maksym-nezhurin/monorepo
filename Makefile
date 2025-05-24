dev:
	docker compose -f docker-compose.dev.yml up --build

prod:
	docker compose -f docker-compose.yml up --build -d

down:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml down

logs:
	docker compose -f docker-compose.dev.yml logs -f --tail=100

ps:
	docker compose -f docker-compose.dev.yml ps
