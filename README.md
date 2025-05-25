# Monorepo Microservice Application

## Опис

Цей репозиторій — **монорепо** для мікросервісного застосунку з наступною структурою:


---

## 🛠️ Основні компоненти

| Каталог         | Опис                                                                 |
|-----------------|----------------------------------------------------------------------|
| `apps/`         | Клієнтські додатки (Next.js та React)                                |
| `config/env/`   | Шаблони конфігурацій `.env`                                           |
| `infrastructure/keycloak/` | Сервіс Keycloak для централізованої автентифікації та авторизації |
| `services/`     | Мікросервіси: авторизація, користувачі, повідомлення, шлюз           |
| `scripts/`      | Bash-скрипти для налаштування, запуску та автоматизації              |

---

## 📦 Швидкий старт

```bash
git clone https://your.repo.url.git
cd monorepo
bash scripts/setup.sh
```
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

## 📋 Як працювати з проектом

<details>
 <summary>

 ### 🔧 Клонування та налаштування
 </summary>

 ```markdown
./scripts/setup.sh
```

- Клонує всі потрібні підпроєкти у відповідні папки

- Копіює шаблон .env.template у .env для кожного сервісу, фронтенду та інфраструктури
 
</details>

<details>
 <summary>

 ### 🐳 Запуск середовища з Docker Compose
 </summary>

Запуск усіх сервісів (Keycloak, backend, frontend):
 ```markdown
make dev
```
 
</details>

<details>
 <summary>

 ### 🛡️ Імпорт Realm у Keycloak
 </summary>

Keycloak підтримує автоматичний імпорт realm через опцію --import-realm у Docker Compose.

Якщо потрібно імпортувати вручну (наприклад, після старту Keycloak), використайте скрипт:
 ```markdown
./scripts/import-realm.sh
```
Скрипт:

- Чекає запуску Keycloak

- Авторизується через Keycloak Admin CLI

- Імпортує realm із файлу:
infrastructure/keycloak/realm-export.json
 
</details>

<details>
 <summary>

 ### ⚙️ Розробка та продакшн
 </summary>

Keycloak підтримує автоматичний імпорт realm через опцію --import-realm у Docker Compose.

Якщо потрібно імпортувати вручну (наприклад, після старту Keycloak), використайте скрипт:
 ```markdown
./scripts/import-realm.sh
```
Скрипт:

- Для розробки:
Використовуйте ```docker-compose.override.yml```, де налаштований <b>hot-reload</b> та локальні томи.

- Для продакшну:
Використовуйте базовий ```docker-compose.yml``` з оптимізованими образами.
 
</details>

### 🐋 Структура Docker Compose
- Кожен мікросервіс — окремий контейнер

- Keycloak — окремий сервіс

- Frontend і backend підключені до спільної мережі myapp-network

- Використання volume для збереження даних Keycloak (keycloak_data)

### 🧙‍♂️ Створення Realm після підняття Keycloak

```bash
create-realm.sh

chmod +x create-realm.sh

./create-realm.sh my-new-realm

```

Креденшіали: admin / admin (або змініть у скрипті)

### 👤 Скрипт для створення користувача в Realm

```
chmod +x create-realm-user.sh
./create-realm-user.sh application john_doe john@example.com test
```

### 📬 Контакти та підтримка
Якщо виникнуть питання — звертайтесь до автора проєкту: Максим Нежурін