# 🏙️ Urban — AI Coding Guidelines

**Версия:** 1.2.0 | **Обновлено:** 2026/04/12 | **Язык:** Dart/Flutter + Go | **Комментарии:** Русский

---

## 🤖 ИНСТРУКЦИЯ ДЛЯ ИИ-АССИСТЕНТОВ

**Прочти ЭТО ПЕРЕД генерацией любого кода для Urban.**

**В ПЕРВУЮ ОЧЕРЕДЬ СВЕРЯЕМСЯ С ВЕРСИЯМИ ПЛАГИНОВ И ЗАВИСИМОСТЕЙ в ФАЙЛАХ:** сначала в `pubspec.yaml` / `go.mod`, затем `DEPENDENCIES.md` — здесь актуальные версии!

### ТВОИ 10 ГЛАВНЫХ ПРАВИЛ:

| # | Правило | Приоритет |
|---|---------|-----------|
| 1 | НЕ хардкодь секреты (токены, ключи, пароли) | 🔴 Критично |
| 2 | НЕ нарушай модульные зависимости | 🔴 Критично |
| 3 | ВСЕГДА обрабатывай ошибки (нет пустых catch) | 🔴 Критично |
| 4 | НЕ логируй токены/пароли | 🔴 Критично |
| 5 | НЕ используй `print()` — только `logger` | 🔴 Критично |
| 6 | ВСЕГДА комментируй классы и методы (`///` на русском) | 🔴 Критично |
| 7 | ВСЕГДА используй `const` где возможно | 🔴 Критично |
| 8 | ВСЕГДА соблюдай Clean Architecture | 🔴 Критично |
| 9 | ВСЕГДА генерируй README при изменении модуля | 🔴 Критично |
| 10 | НЕ дублируй бизнес-логику на клиенте. Сервер (Go) — единственный источник истины | 🔴 Критично |

### АВТО-ОПРЕДЕЛЕНИЕ ЗАДАЧИ:

| Запрос пользователя | Применяй разделы |
|---------------------|------------------|
| «Создай модуль» | §13 + §14 + §3 + §5 |
| «Добавь экран» | §11 + §9 + §3 + §7 |
| «Напиши тест» | §8 + §3 + §6 |
| «Добавь API/эндпоинт» | §4 + §10 + §3 |
| «Обнови README» | §14 + §13 |
| «Исправь баг» | §9 + §3 + §6 |
| «Оптимизируй» | §7 + §3 |

### ПЕРЕД ГЕНЕРАЦИЕЙ:

1. Проверить 10 критических правил (§1)
2. Определить тип задачи (таблица выше)
3. Свериться с контрактом OpenAPI (`/docs/openapi.yaml`)
4. Проверить границу клиент/сервер (§4)

### ПОСЛЕ ГЕНЕРАЦИИ:

- [ ] Код компилируется (`flutter analyze` / `go vet`)
- [ ] Все импорты корректны, нет циклических зависимостей
- [ ] README обновлён (§14)
- [ ] Тесты добавлены (§8)
- [ ] Ошибки обрабатываются, логи безопасны (§9)
- [ ] Бизнес-логика только в Go, клиент только UI/состояние (§4)

---

## КОНТЕКСТ ПРОЕКТА:

| Параметр | Значение |
|----------|----------|
| **Название** | Urban |
| **Тип** | Платформа развлечений |
| **Клиент** | Flutter 3.24+, Dart 3.5+ (Clean + BLoC) |
| **Сервер** | Go 1.22+ (Clean: handlers → usecases → repos → entities) |
| **БД / Хранилище** | PocketBase (только persistence + storage) |
| **Прокси / Статика** | Nginx (SSL, роутинг, кэш тайлов) |
| **Карты** | maplibre_gl (OSM, оффлайн через векторные тайлы) |
| **Модули** | :app, :core-*, :feature-*, :shared |
| **Язык комментариев** | Русский |
| **Мин. Android** | 26 (8.0) |

---

## 📋 БЫСТРАЯ НАВИГАЦИЯ

| Раздел | Ссылка | Приоритет |
|--------|--------|-----------|
| 🔴 Критические правила | §1 | Обязательно |
| 🤖 Инструкция для ИИ | §2 | Авто-применение |
| 🏗️ Архитектура | §3 | Clean + BLoC + Go |
| ⚖️ Клиент vs Сервер | §4 | Zero Trust, Contract-First |
| 🗄️ PocketBase | §5 | Persistence, Storage, Limits |
| 📝 Стиль кода | §6 | Именование, комментарии |
| 📦 Зависимости | §7 | См. DEPENDENCIES.md |
| 🔐 Безопасность | §8 | Auth, шифрование, OAuth |
| ⚡ Производительность | §9 | Кэш, карты, оптимизация |
| 🧪 Тестирование | §10 | Unit, Widget, Integration |
| 🔥 Ошибки и логи | §11 | Sentry, logger, safe logs |
| 🌐 Сеть и API | §12 | OpenAPI, Dio, оффлайн, WS |
| 🎨 UI/UX | §13 | Темы, локализация |
| 🔖 Git и версии | §14 | SemVer, Conventional Commits |
| 🧱 Модули | §15 | :core, :feature, :shared |
| 📄 README | §16 | Авто-генерация для модулей |

---

## 1. 🔴 КРИТИЧЕСКИЕ ПРАВИЛА

> ⚠️ **Нарушение любого правила = блокировка генерации.**

| # | Правило | Статус |
|---|---------|--------|
| 1.1 | ❌ НЕ хардкодить секреты — только `.env` + `flutter_secure_storage` / Go `os.Getenv` | 🔴 |
| 1.2 | ❌ НЕ нарушать модульные зависимости — `feature-*` → `feature-*` запрещено | 🔴 |
| 1.3 | ❌ НЕ игнорировать ошибки — пустые `catch {}` запрещены, всегда логировать | 🔴 |
| 1.4 | ❌ НЕ логировать токены/пароли — использовать `SafeLoggingInterceptor` / Go `slog` с маской | 🔴 |
| 1.5 | ❌ НЕ использовать `print()` — только `logger` из `:core-utils` | 🔴 |
| 1.6 | ❌ НЕ коммитить `.env` — добавить в `.gitignore` | 🔴 |
| 1.7 | ✅ ВСЕГДА комментировать классы и публичные методы (`///` на русском) | 🔴 |
| 1.8 | ✅ ВСЕГДА использовать `const` где возможно | 🔴 |
| 1.9 | ✅ ВСЕГДА проверять `flutter analyze` / `go vet` перед коммитом | 🔴 |
| 1.10 | ❌ НЕ изменять логику сплэш-экрана без учета синхронизации Native и Lottie (1.5с) | 🔴 |
| 1.11 | ❌ НЕ дублировать бизнес-правила на клиенте. Валидация ввода = UX. Валидация данных = Go | 🔴 |

---

## 2. 🤖 ИНСТРУКЦИЯ ДЛЯ ИИ-АССИСТЕНТОВ

### 2.1 Чек-лист ПЕРЕД генерацией

| # | Проверка | Раздел |
|---|----------|--------|
| 1 | Нет хардкода секретов | §1.1 |
| 2 | Нет нарушения модульных зависимостей | §1.2 |
| 3 | Нет пустых catch-блоков | §1.3 |
| 4 | Нет логирования токенов | §1.4 |
| 5 | Нет `print()` | §1.5 |
| 6 | Все классы закомментированы | §1.7 |
| 7 | Использован `const` | §1.8 |
| 8 | Именование по стандарту | §6.1 |
| 9 | Файлы в `snake_case` | §6.1 |
| 10 | Логика на правильной стороне (Go/Flutter) | §4 |

### 2.2 Чек-лист ПОСЛЕ генерации

- [ ] Код компилируется
- [ ] Импорты корректны, нет циклов
- [ ] README обновлён (§16)
- [ ] Тесты добавлены (§10)
- [ ] Ошибки обрабатываются (§11)
- [ ] Логи безопасны (§11.4)
- [ ] Виджеты имеют `const` (§6.4)
- [ ] Локализация использована (§13.3)
- [ ] Контракт OpenAPI соблюдён (§12.1)
- [ ] `pubspec.lock` / `go.sum` обновлены

---

## 3. 🏗️ АРХИТЕКТУРА

### 3.1 Клиент: Clean Architecture + BLoC

```
Presentation (BLoC + UI)
    ↓
Domain (Use Cases + Entities)
    ↓
Data (Repositories + Sources)
```

**Запрещено:** Domain → Data/Presentation, Data → Presentation, BLoC → API напрямую.

### 3.2 Сервер: Go Clean Architecture

```
Handlers (HTTP/WS)
    ↓
UseCases (Бизнес-логика)
    ↓
Repositories (Доступ к данным)
    ↓
Entities (Модели данных)
```

**Запрещено:** Бизнес-логика в handlers, прямой доступ к SQLite PocketBase, дублирование правил на клиенте.

### 3.3 Contract-First

Все API описываются в `/docs/openapi.yaml`. Генерация DTO строго по схеме. Клиент и сервер синхронизируются через контракт, а не через импровизацию.

---

## 4. ⚖️ РАЗДЕЛЕНИЕ ЛОГИКИ: КЛИЕНТ (FLUTTER) vs СЕРВЕР (GO)

> 🛡️ **Принцип Zero Trust Client:** Клиент никогда не принимает решений, влияющих на данные, безопасность или деньги.

| Функция | ✅ Go (VM_APP) | ✅ PocketBase (VM_DB) | ✅ Flutter (Клиент) | ⚠️ Почему так |
|---------|---------------|----------------------|---------------------|---------------|
| **Авторизация** | OAuth-прокси, обмен кода на токен, валидация, rate-limit, сессии | Хранение пользователей, refresh-токенов | UI входа, SecureStorage, редиректы | OAuth-флоу только на trusted proxy |
| **Лента новостей** | Пагинация, ранжирование, кэш, фильтрация по регионам/ролям | Хранение постов, медиа-ссылок, статусов | Pull-to-refresh, infinite scroll, кэш stale-while-revalidate | Агрегация на сервере, клиент только отображает |
| **Бизнес-аккаунты** | RBAC, валидация прав, аудит-лог, модерация изменений | Хранение профилей заведений, связей | UI-формы, оптимистичные обновления, drag-and-drop фото | Права и модерация → строго Go |
| **Профиль + фото** | Resize/оптимизация, водяные знаки, CDN-отдача, приватность | Хранение метаданных, связей | Кэш превью, виртуализация галереи, lazy-load | Обработка медиа на клиенте = перегрев |
| **Маркеры на карте** | Геозапросы (bbox/RTree), кластеризация, валидация координат | Хранение координат, описаний, категорий | maplibre_gl, дебаунс перемещения, кэш viewport, отрисовка | SQLite в PB не умеет PostGIS. Go вычисляет bbox |
| **Поиск & Фильтрация** | FTS5, фильтрация по категориям/цене/расстоянию, пагинация | Индексы, денормализация | Дебаунс ввода (300ms), CancelToken, фильтрация кэша (<500 записей) | Клиентская фильтрация больших массивов = фризы |
| **Отзывы & Фото** | Модерация, анти-спам, идемпотентность, валидация контента | Хранение отзывов, связей, статусов | Оптимистичная отправка, откат при ошибке, предпросмотр | Защита от дублей и спама → только сервер |
| **Чаты** | WebSocket/SSE хаб, доставка, статусы прочтения, очередь | Хранение истории, медиа, участников | Локальная БД (Isar/Hive), realtime-обновления, кеш непрочитанных | PB realtime не масштабируется. Go = шлюз, PB = архив |
| **Push & Геолокация** | FCM/APNs роутинг, триггеры (близость, статусы), лимиты | Хранение токенов устройств, подписок | Сбор координат (background), показ уведомлений, разрешение | Гео-логика на клиенте = слив батареи. Сервер считает proximity |

### Золотые правила:

- **Клиентская валидация = UX. Серверная валидация = безопасность.**
- Все конфигурации, флаги фич, лимиты, тексты → `/api/v1/config`. Клиент читает, не хардкодит.
- **Идемпотентность** для всех POST/PUT. `Idempotency-Key` заголовок обязателен.
- **Graceful degradation:** неизвестное поле → игнорировать, отсутствует обязательное → fallback UI.

---

## 5. 🗄️ POCKETBASE ИНТЕГРАЦИЯ

> ⚠️ **PocketBase используется только как слой хранения (persistence + storage).** Бизнес-логика, авторизация, валидация и realtime-хабы реализуются в Go.

| Правило | Описание |
|---------|----------|
| **Доступ** | Только через официальный Go SDK или REST API. Прямой доступ к `data.db` запрещён. |
| **Auth** | Go выступает как OAuth/SMS прокси. PB хранит пользователей и refresh-токены. Клиент получает JWT от Go. |
| **Realtime** | Не использовать PB realtime для чатов или высоких нагрузок. Go WebSocket hub → PB только для архивации. |
| **Storage** | Медиа загружаются через Go (валидация, resize, watermark) → сохраняются в PB storage → CDN отдаёт через Nginx. |
| **Rules** | PB Collection Rules = fallback защита. Основная авторизация и RBAC проверяются в Go usecases. |
| **Миграции** | Все изменения схем через Go-миграции или PB admin UI с версионированием. Не менять схему в рантайме. |
| **Бэкапы** | Ежедневный бэкап `data.db` + storage на внешний S3/Volume. Восстановление тестируется раз в месяц. |

---

## 6. 📝 СТИЛЬ КОДА

### 6.1 Именование

| Элемент | Стиль | Пример |
|---------|-------|--------|
| Переменные/Функции | `camelCase` | `userName`, `loadData()` |
| Классы | `PascalCase` | `UserProfile`, `PlaceListBloc` |
| Константы | `SCREAMING_SNAKE_CASE` | `API_TIMEOUT` |
| Файлы | `snake_case` | `place_list_screen.dart` |
| Go-пакеты | `lowercase` | `handler`, `usecase`, `repo` |

**Суффиксы:** `*Bloc`, `*Screen`, `*Widget`, `*Repository`, `*UseCase`, `*Handler`, `*Service`

### 6.2 Комментарии

```dart
/// Краткое описание класса.
/// 
/// Подробное описание с примерами использования.
class UserProfile {
  /// Возвращает имя пользователя.
  /// 
  /// [format] - формат вывода имени.
  String getName({String format = 'full'}) {
    // ...
  }
}
```

### 6.3 Импорты (порядок)

```dart
// Dart
import 'dart:async';
import 'dart:convert';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Внешние пакеты
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Внутренние (по уровням)
import 'package:urban/core_network/network_service.dart';
import 'package:urban/core_utils/logger.dart';
import 'package:urban/shared/models/user.dart';

// Текущий пакет
import 'user_repository.dart';
```

### 6.4 const

```dart
// ✅ Правильно
const TextStyle titleStyle = TextStyle(fontSize: 18);
const SizedBox gap = SizedBox(height: 16);

// ✅ Виджеты
const UserProfileCard();

// ❌ Неправильно
final TextStyle titleStyle = TextStyle(fontSize: 18);
```

---

## 7. 📦 ЗАВИСИМОСТИ

✅ **См. `DEPENDENCIES.md` — центральный источник версий**  
❌ **НЕ обновлять версии без тестирования и согласования**

| Категория | Пакет | Версия |
|-----------|-------|--------|
| **State** | `flutter_bloc` | `9.1.1` |
| **DI** | `get_it` | `^8.0.3` |
| **Network** | `dio` | `5.9.2` |
| **Storage** | `hive`, `flutter_secure_storage` | `2.2.3`, `10.0.0` |
| **Navigation** | `go_router` | `17.2.0` |
| **Maps** | `maplibre_gl`, `latlong2` | `^0.25.0`, `^0.9.1` |
| **Splash** | `flutter_native_splash` | `^2.4.3` |
| **Images** | `cached_network_image` | `^3.4.1` |
| **Go Server** | `chi`, `slog`, `validator`, `pocketbase-go` | `v5`, `std`, `v10`, `latest` |

📖 **Полный список:** `DEPENDENCIES.md`

---

## 8. 🔐 БЕЗОПАСНОСТЬ

### 8.1 Авторизация (v1.0)

| Метод | Статус |
|-------|--------|
| Телефон + SMS | ✅ Обязательно |
| Email + Пароль | ✅ Обязательно |
| VK ID | ✅ Обязательно |
| Yandex ID | ✅ Обязательно |
| Сбер/Apple/Google | ⏳ v2.0 |

### 8.2 Пароль

- ✅ Минимум 8 символов, 1 заглавная, 1 цифра
- ⚠️ Спецсимволы — рекомендация (не блокировать)

### 8.3 Хранение секретов

```bash
# .env (не коммитить!)
API_KEY=your_api_key
JWT_SECRET=your_jwt_secret
POCKETBASE_URL=https://db.urban.app
```

### 8.4 Связывание аккаунтов

- ✅ Все методы → один `user_id`
- ✅ Новый метод → подтверждение (SMS/email)
- ❌ Нельзя удалить последний метод привязки

### 8.5 Биометрия

- ✅ `local_auth: ^2.1.6` как опция
- ✅ Обработка ошибки отсутствия датчика

### 8.6 Обфускация

```kotlin
buildTypes {
    release {
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

---

## 9. ⚡ ПРОИЗВОДИТЕЛЬНОСТЬ

### 9.1 Уровни кэширования

| Уровень | Что | Где | TTL |
|---------|-----|-----|-----|
| L1 | Текущий экран, BLoC | RAM | До закрытия |
| L2 | Профиль, заведения | Hive | 24 часа |
| L3 | Избранное, настройки | Hive + Secure | Постоянно |
| L4 | Изображения | cached_network_image | 7 дней |

### 9.2 Карты и маркеры

- ✅ Кластеризация всегда включена
- ✅ Макс. 300 маркеров в viewport. При зуме <10 → серверная агрегация
- ✅ Загружать маркеры только в видимой области (bbox)
- ✅ Использовать `maplibre_gl` + векторные тайлы для оффлайн-режима

### 9.3 Пагинация

- ✅ Списки: 30–50 элементов за запрос
- ✅ Чаты: 50 сообщений за запрос
- ✅ Использовать `ListView.builder` / `CustomScrollView`

### 9.4 Изображения

```dart
CachedNetworkImage(
  imageUrl: url,
  cacheKey: uniqueKey,
  memCacheWidth: 400, // Оптимизация памяти
  placeholder: (context, url) => ShimmerPlaceholder(),
  errorWidget: (context, url, error) => ErrorIcon(),
);
```

### 9.5 Геолокация и уведомления

- ✅ Системный Geofencing (не непрерывная трекинг)
- ✅ In-app уведомления при открытом приложении
- ✅ Server Regional Push (на основе последней локации)
- ✅ Opt-in от пользователя. Фоновая геолокация только для геофенсинга.

---

## 10. 🧪 ТЕСТИРОВАНИЕ

| Компонент | Тип | Покрытие |
|-----------|-----|----------|
| UseCase (Go/Dart) | Unit | 90%+ |
| Repository | Unit | 80%+ |
| BLoC / Handler | Unit | 70%+ |
| Критичные виджеты | Widget | 50%+ |
| Ключевые сценарии | Integration | 5-10 потоков |

**Пакеты:** `bloc_test`, `mocktail`, `testify` (Go), `integration_test`

**CI/CD:** GitHub Actions при push/PR. Блокировка мерджа при failed тестах. Мин. покрытие 70%.

---

## 11. 🔥 ОБРАБОТКА ОШИБОК И ЛОГИРОВАНИЕ

### 11.1 Уровни логирования

| Уровень | Когда |
|---------|-------|
| DEBUG | Разработка |
| INFO | Важные события (вход, покупка) |
| WARNING | Предупреждения (кэш устарел) |
| ERROR | Ошибки (не загрузилось) |
| CRITICAL | Падения приложения |

**В продакшене:** WARNING, ERROR, CRITICAL

### 11.2 Классы ошибок

```dart
sealed class AppException implements Exception {
  final String message;
  final int? code;
  
  const AppException(this.message, {this.code});
}

class NetworkException extends AppException { /* ... */ }
class ValidationException extends AppException { /* ... */ }
class AuthException extends AppException { /* ... */ }
```

### 11.3 Отображение пользователю

- ✅ SnackBar — обычные ошибки
- ✅ Dialog — критичные ошибки
- ❌ Не показывать стектрейс

### 11.4 Crash Reporting

```dart
await SentryFlutter.init(
  (options) {
    options.dsn = dotenv.env['SENTRY_DSN'];
    options.tracesSampleRate = 0.1;
  },
);
```

### 11.5 Логирование сети

```dart
class SafeLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Маскируем заголовки авторизации
    final safeHeaders = Map<String, dynamic>.from(options.headers);
    safeHeaders['Authorization'] = 'Bearer ***';
    
    logger.d('Request: ${options.uri}\nHeaders: $safeHeaders');
    handler.next(options);
  }
}
```

---

## 12. 🌐 СЕТЬ И API

### 12.1 Contract-First

Все эндпоинты описываются в `/docs/openapi.yaml`. Генерация DTO через `openapi-generator`. Никаких "магических" маппингов.

### 12.2 Dio конфигурация

```dart
final dio = Dio(BaseOptions(
  baseUrl: ApiConfig.baseUrl,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  headers: {'Content-Type': 'application/json'},
));
```

### 12.3 Интерсепторы

| Интерсептор | Назначение |
|-------------|------------|
| `AuthInterceptor` | Добавляет JWT токен |
| `SafeLoggingInterceptor` | Логи (без секретов) |
| `RetryInterceptor` | 3 попытки при 5xx |
| `ConnectivityInterceptor` | Проверка интернета |

### 12.4 Оффлайн-режим

- ✅ Кэш в Hive при отсутствии сети
- ✅ Очередь действий (sync-queue при подключении)
- ✅ Проверка `connectivity_plus` перед запросом
- ✅ Стратегия: `stale-while-revalidate`

### 12.5 WebSocket (чаты)

- ✅ `web_socket_channel: ^2.4.0`
- ✅ Переподключение при обрыве (exponential backoff)
- ✅ Отключать при неактивности > 5 мин
- ✅ Go hub управляет доставкой, PB хранит историю

### 12.6 Модели данных

- ✅ `freezed: ^2.4.6` + `json_serializable: ^6.7.1`
- ✅ Генерация через `dart run build_runner build`

---

## 13. 🎨 UI/UX СТАНДАРТЫ

### 13.1 Темы

- ✅ Светлая + Тёмная + Системная
- ✅ Переключение в настройках

### 13.2 Цветовая палитра

```dart
static const primaryColor = Color(0xFF6C63FF);
static const secondaryColor = Color(0xFF3F3D56);
static const backgroundColor = Color(0xFFFFFFFF);
static const errorColor = Color(0xFFCF6679);
```

### 13.3 Локализация

- ✅ Русский (основной), Английский (дополнительный)
- ❌ Не хардкодить текст — использовать `.arb`

### 13.4 Отступы (8px grid)

```dart
SizedBox(height: 8),   // 1x
SizedBox(height: 16),  // 2x
SizedBox(height: 24),  // 3x
```

### 13.5 Доступность

- ✅ Мин. размер тапа: 48x48dp
- ✅ Мин. шрифт: 14sp (основной), 12sp (мин)
- ✅ Контрастность: WCAG 2.1 AA (4.5:1)
- ✅ Semantics для интерактивных элементов

### 13.6 Анимации

- ✅ Использовать `Curves.easeInOut` и durations из `ThemeData`
- ✅ Отключать сложные анимации через `MediaQuery.accessibility`
- ✅ Микро: 150-200ms, Переходы: 300-350ms

---

## 14. 🔖 ВЕРСИОНИРОВАНИЕ И GIT

### 14.1 SemVer

`MAJOR.MINOR.PATCH` (1.0.0)

### 14.2 Conventional Commits

```
feat(auth): добавить вход через VK
fix(map): исправить кластеризацию маркеров
docs: обновить README
```

✅ `feat(auth): добавить вход через VK`  
❌ `исправил баг`

### 14.3 Ветвление

```
main ← develop ← feature/*
```

### 14.4 Lock-файлы

- ✅ Коммитить `pubspec.lock` и `go.sum` (воспроизводимость сборок)

### 14.5 CHANGELOG

- ✅ Формат: Keep a Changelog. Группировать: Добавлено, Изменено, Исправлено, Удалено.

---

## 15. 🧱 МОДУЛЬНАЯ СТРУКТУРА

### 15.1 Типы модулей

| Модуль | Назначение | Зависимости |
|--------|------------|-------------|
| `:app` | Точка входа | Все `feature-*` |
| `:core-*` | Инфраструктура | Никаких внутренних |
| `:feature-*` | Бизнес-фичи | `:core-*`, `:shared` |
| `:shared` | Общие компоненты | `:core-*` |

### 15.2 Граф зависимостей

```
:app → :feature-* → :shared → :core-* → (никого)
```

**Запрещено:** `feature-chat` → `feature-map`, циклические зависимости, `core` → `feature`

### 15.3 Структура feature-модуля

```
lib/
├── src/
│   ├── data/
│   ├── domain/
│   ├── presentation/
│   └── di/
├── feature_module.dart (Public API)
└── README.md
```

### 15.4 Public API модуля

```dart
// feature_auth.dart
export 'src/presentation/screens/login_screen.dart';
export 'src/presentation/blocs/auth_bloc.dart';
export 'src/domain/use_cases/login_use_case.dart';
```

### 15.5 Навигация

- ✅ Централизованная в `:app` через `go_router`
- ❌ Прямые импорты между `feature-*` запрещены

### 15.6 Core-модули

| Модуль | Назначение |
|--------|------------|
| `:core-network` | Dio, интерсепторы, API Service |
| `:core-storage` | Hive, Secure Storage, SharedPreferences |
| `:core-ui` | Темы, компоненты, дизайн-система |
| `:core-utils` | Extensions, validators, logger, constants |

### 15.7 Feature-модули

| Модуль | Назначение |
|--------|------------|
| `:feature-auth` | Авторизация, профиль |
| `:feature-map` | Карты, маркеры, кластеризация, bbox |
| `:feature-chat` | Чаты, сообщения |
| `:feature-events` | Ивенты, мероприятия |
| `:feature-places` | Заведения, отзывы, бронь |
| `:feature-business` | Кабинет предпринимателя |
| `:feature-social` | Лента, друзья |
| `:feature-payment` | Оплата |

---

## 16. 📄 ГЕНЕРАЦИЯ README

### 16.1 Обязательный шаблон

```markdown
# Название модуля

## Описание
Краткое описание назначения модуля.

## Структура
```
lib/
├── src/
│   ├── data/
│   ├── domain/
│   └── presentation/
└── module.dart
```

## Public API
- `ExportedClass1` — описание
- `ExportedClass2` — описание

## Зависимости
- `:core-network`
- `:core-storage`

## Тесты
- Unit: XX%
- Integration: XX сценариев
```

### 16.2 Авто-генерация

ИИ должен автоматически: создавать README при создании модуля, обновлять Public API, Структуру, Зависимости.

---

## 📎 ПРИЛОЖЕНИЯ

### A. Чек-лист перед коммитом

- [ ] `flutter analyze` / `go vet` без ошибок
- [ ] Все классы и методы закомментированы
- [ ] Нет `print()` в коде
- [ ] Нет хардкода секретов
- [ ] Тесты проходят
- [ ] README обновлён (если новый модуль)
- [ ] Conventional Commits формат
- [ ] `pubspec.lock` / `go.sum` обновлены
- [ ] Бизнес-логика только в Go, клиент только UI/состояние
- [ ] Контракт OpenAPI соблюдён

### B. Ссылки на файлы

| Файл | Назначение |
|------|------------|
| `DEPENDENCIES.md` | Все версии пакетов |
| `FUTURE_IMPLEMENTATIONS.md` | План будущих функций |
| `docs/openapi.yaml` | Контракт API (источник истины) |
| `.env.example` | Пример переменных окружения |
| `.gitignore` | Исключения Git |

### C. Проверка на противоречия

| Область | Решение |
|---------|---------|
| Карты | `maplibre_gl` + векторные тайлы (OSM, оффлайн) |
| Бэкенд | Go (бизнес-логика) + PocketBase (хранение) |
| Геолокация | Только системный Geofencing |
| Соц. логины | VK + Yandex ID + SMS/Email (остальное v2.0) |
| Модульность | Полная с начала |
| Очистка кэша | Ручная v1.0, Авто-предложение v2.0 |
| Моки | `mocktail` (Dart), `testify/mock` (Go) |
| Логирование | `logger` / `slog` (не `print`) |
| Навигация | Централизованная в `:app` |
| Lock-файлы | Коммитить |
| Crash Reporting | Sentry или аналог (не Firebase по умолчанию) |

---

**Документ готов к использованию.**

**Ответственный:** Urban Developer

**AI-оптимизация:** Contract-First, Zero Trust Client, Clean Architecture, PocketBase as Persistence Only.
