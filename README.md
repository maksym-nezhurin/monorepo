# monorepo
# Monorepo Microservice Application

## Опис

Цей репозиторій — **монорепо** для мікросервісного застосунку з наступною структурою:

monorepo/
├── apps/ # Frontend додатки
│ ├── client/ # Next.js клієнт
│ └── admin/ # React адмін панель
├── config/
│ └── env/
│ └── .env.template # Шаблон для .env файлів
├── infrastructure/
│ └── keycloak/ # Keycloak сервер для аутентифікації
├── services/ # Backend мікросервіси
│ ├── auth/
│ ├── user/
│ ├── notification/
│ └── gateway/
├── scripts/ # Сценарії для автоматизації
│ ├── setup.sh # Основний скрипт для клонування та підготовки проекту
│ ├── import-realm.sh # Скрипт імпорту realm до Keycloak
│ └── (інші скрипти)
├── docker-compose.yml # Основний Docker Compose для запуску усіх сервісів
└── README.md # Цей файл

markdown
Copy
Edit

---

## Архітектура

- **Keycloak** — сервер аутентифікації, розташований в `infrastructure/keycloak`.
- **Frontend:**
  - `apps/client` — Next.js клієнт.
  - `apps/admin` — React адмінка.
- **Backend:**
  - Різні сервіси (`auth`, `user`, `notification`, `gateway`) знаходяться в `services`.
- **Конфігурація:**
  - Загальні `.env.template` зберігаються в `config/env`.
- **Сценарії:**
  - Скрипти для автоматизації клонування, генерації `.env` та налаштувань.

---

## Як працювати з проектом

### 1. Клонування та налаштування

Використовуємо `setup.sh` для клонування всіх репозиторіїв та створення `.env` файлів:

```bash
./scripts/setup.sh
Цей скрипт:

Клонує всі потрібні підпроекти у відповідні папки

Копіює шаблон .env.template в .env у кожному сервісі, фронтенді та інфраструктурі

2. Запуск середовища з Docker Compose
Запускаємо всі сервіси (Keycloak, backend, frontend):

bash
Copy
Edit
docker-compose up -d
3. Імпорт Realm в Keycloak
Keycloak підтримує імпорт realm автоматично через опцію --import-realm у Docker Compose.

Якщо потрібно імпортувати realm вручну (наприклад, після старту Keycloak), можна використати скрипт:

bash
Copy
Edit
./scripts/import-realm.sh
Цей скрипт:

Чекає поки Keycloak підніметься

Логіниться через Keycloak Admin CLI

Імпортує realm з файлу infrastructure/keycloak/realm-export.json

4. Розробка та продакшн
Для розробки можна запускати сервіси з додатковим docker-compose.override.yml, де налаштований hot-reload та локальні томи.

Для продакшн — базовий docker-compose.yml з оптимізованими образами.

Структура Docker Compose
Кожен сервіс — окремий контейнер

Keycloak як окремий сервіс

Frontend та backend підключені до спільної мережі myapp-network

Використання volume для збереження даних Keycloak (keycloak_data)

Корисні команди
Оновити код і налаштування .env:

bash
Copy
Edit
./scripts/setup.sh
Запустити всі сервіси:

bash
Copy
Edit
docker-compose up -d
Перевірити логи Keycloak:

bash
Copy
Edit
docker-compose logs -f keycloak
Імпортувати realm вручну:

bash
Copy
Edit
./scripts/import-realm.sh
Контакти та підтримка
Якщо виникнуть питання, звертайтесь до автора проекту — Максим Нежурін.

🔧 docker-compose.yml (Production) 

🔧 docker-compose.dev.yml (Development) з Хот хотрелоадами

### Після створення підняття Кейклока можна створити Реалм за допомогою скрипта

Як користуватися
Збережи скрипт, наприклад, у файл create-realm.sh

Дай права на виконання:

chmod +x create-realm.sh

Запусти:

./create-realm.sh my-new-realm

Що потрібно:
jq має бути встановлений (sudo apt install jq або через brew для macOS)

Keycloak має бути доступний на http://localhost:8080

admin і пароль admin — або свої відповідні креденшіали в скрипті

Скрипт для створення нового користувача в реалмі
chmod +x create-realm-user.sh
./create-realm-user.sh application john_doe john@example.com test