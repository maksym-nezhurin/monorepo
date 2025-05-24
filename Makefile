dev:
	docker compose up --build

prod:
	docker compose -f docker-compose.yml up --build -d

down:
	docker compose down

logs:
	docker compose logs -f --tail=100

ps:
	docker compose ps
