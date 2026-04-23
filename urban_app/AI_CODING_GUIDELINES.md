# 🏙️ Urban — AI Coding Guidelines

**Версия:** 1.0.0 | **Обновлено:** 2026/04/11 | **Язык:** Dart/Flutter | **Комментарии:** Русский

---
# 🤖 ИНСТРУКЦИЯ ДЛЯ ИИ-АССИСТЕНТОВ

**Прочти ЭТО ПЕРЕД генерацией любого кода для Urban.**

В ПЕРВУЮ ОЧЕРЕДЬ СВЕРЯЕМСЯ С ВЕРСИЯМИ ПЛАГИНОВ И ЗАВИСИМОСТЕЙ в ФАЙЛАХ: сначала в pubspec.yaml, затем DEPENDENCIES.md - здесь актуальные версии!

## ТВОИ 10 ГЛАВНЫХ ПРАВИЛ:

| # | Правило | Приоритет |
|:--| :--- | :--- |
| 1 | НЕ хардкодь секреты (токены, ключи, пароли) | 🔴 Критично |
| 2 | НЕ нарушай модульные зависимости | 🔴 Критично |
| 3 | ВСЕГДА обрабатывай ошибки (нет пустых catch) | 🔴 Критично |
| 4 | НЕ логируй токены/пароли | 🔴 Критично |
| 5 | НЕ используй print() — только logger | 🔴 Критично |
| 6 | ВСЕГДА комментируй классы и методы (/// на русском) | 🔴 Критично |
| 7 | ВСЕГДА используй const где возможно | 🔴 Критично |
| 8 | ВСЕГДА соблюдай Clean Architecture | 🔴 Критично |
| 9 | ВСЕГДА генерируй README при изменении модуля | 🔴 Критично |

## АВТО-ОПРЕДЕЛЕНИЕ ЗАДАЧИ:

| Запрос пользователя   | Применяй раздел ы    |
|:----------------------|:---------------------|
| «Создай модуль»       | §11 + §12 + §2 + §4  |
| «Добавь экран»        | §11.3 + §9 + §3 + §7 |
| «Напиши тест»         | §7 + §3 + §6         |
| «Добавь API»          | §8 + §5 + §3         |
| «Обнови README»       | §12 + §11            |
| «Исправь баг»         | §7 + §3 + §6         |
| «Оптимизируй»         | §6 + §3              |

## ПЕРЕД ГЕНЕРАЦИЕЙ:

- [ ] Проверить 10 критических правил (§13.4)
- [ ] Определить тип задачи (§13.1)
- [ ] Выбрать соответствующие разделы

## ПОСЛЕ ГЕНЕРАЦИИ:

- [ ] Проверить код на ошибки (§13.5)
- [ ] Обновить README если нужно (§12)
- [ ] Добавить тесты если новая логика (§7)

## КОНТЕКСТ ПРОЕКТА:

- **Название:** Urban
- **Стек:** Flutter 3.24+, Dart 3.5+
- **Архитектура:** Clean Architecture + BLoC
- **Модули:** :app, :core-*, :feature-*, :shared
- **Язык комментариев:** Русский
- **Мин. Android:** 26 | **Мин. iOS:** 12.0

---
## 📋 БЫСТРАЯ НАВИГАЦИЯ

| Раздел | Ссылка | Приоритет |
| :--- | :--- | :--- |
| 🔴 **Критические правила** | [§1](#1-критические-правила) | Обязательно для всех |
| 🤖 **Инструкция для ИИ** | [§2](#2-инструкция-для-ии-ассистентов) | Авто-применение |
| 🏗️ Архитектура | [§3](#3-архитектура) | Clean + BLoC + Модули |
| 📝 Стиль кода | [§4](#4-стиль-кода) | Именование, комментарии |
| 📦 Зависимости | [§5](#5-зависимости) | См. DEPENDENCIES.md |
| 🔐 Безопасность | [§6](#6-безопасность) | Авторизация, шифрование |
| ⚡ Производительность | [§7](#7-производительность) | Кэш, оптимизация |
| 🧪 Тестирование | [§8](#8-тестирование) | Unit, Widget, Integration |
| 🔥 Ошибки и логи | [§9](#9-обработка-ошибок-и-логирование) | Crashlytics, logger |
| 🌐 Сеть и API | [§10](#10-сеть-и-api) | Dio, оффлайн, WebSocket |
| 🎨 UI/UX | [§11](#11-uiux-стандарты) | Темы, локализация |
| 🔖 Git и версии | [§12](#12-версионирование-и-git) | SemVer, Conventional Commits |
| 🧱 Модули | [§13](#13-модульная-структура) | :core, :feature, :shared |
| 📄 README | [§14](#14-генерация-readme) | Авто-генерация для модулей |

---

## 1. 🔴 КРИТИЧЕСКИЕ ПРАВИЛА

> ⚠️ **Эти 10 правил обязательны для ЛЮБОЙ генерации кода. Нарушение = блокировка.**

| #       | Правило                                                                                    | Статус   |
|:--------|:-------------------------------------------------------------------------------------------|:---------|
| **1.1** | ❌ НЕ хардкодить секреты (токены, ключи, пароли) — только `.env` + `flutter_secure_storage` | 🔴       |
| **1.2** | ❌ НЕ нарушать модульные зависимости — `feature-*` → `feature-*` запрещено                  | 🔴       |
| **1.3** | ❌ НЕ игнорировать ошибки — пустые `catch {}` запрещены, всегда логировать                  | 🔴       |
| **1.4** | ❌ НЕ логировать токены/пароли — использовать `SafeLoggingInterceptor`                      | 🔴       |
| **1.5** | ❌ НЕ использовать `print()` — только `logger` из `:core-utils`                             | 🔴       |
| **1.6** | ❌ НЕ коммитить `.env` — добавить в `.gitignore`                                            | 🔴       |
| **1.7** | ✅ ВСЕГДА комментировать классы и публичные методы (`///` на русском)                       | 🔴       |
| **1.8** | ✅ ВСЕГДА использовать `const` где возможно                                                 | 🔴       |
| **1.9** | ✅ ВСЕГДА проверять `flutter analyze` перед коммитом                                        | 🔴       |

---

## 2. 🤖 ИНСТРУКЦИЯ ДЛЯ ИИ-АССИСТЕНТОВ

> ⚠️ **Прочти этот раздел ПЕРЕД генерацией любого кода.**

### 2.1 Авто-определение задачи

| Запрос пользовател я | Тип задачи | Применяй разделы     |
|:---------------------|:-----------|:---------------------|
| «Создай модуль X»    | 📦 Модуль  | §13 + §14 + §3 + §5  |
| «Добавь экран X»     | 🖼️ Экран  | §13.3 + §11 + §4 + §8|
| «Напиши тест для X»  | 🧪 Тест    | §8 + §4 + §7         |
| «Добавь API метод»   | 🌐 API     | §10 + §6 + §4        |
| «Обнови README»      | 📄 Docs    | §14 + §13            |
| «Исправь баг в X»    | 🐛 Fix     | §9 + §4 + §7         |
| «Оптимизируй X»      | ⚡ Perf     | §7 + §4              |

### 2.2 Чек-лист ПЕРЕД генерацией
| #  | Тип задачи                           | Применяй разделы  |
|:---|:-------------------------------------|:------------------|
| #1 | Нет хардкода секретов                | §1.1              |
| #2 | Нет нарушения модульных зависимостей | §1.3              |
| #3 | Нет пустых catch-блоков              | §1.4              |
| #4 | Нет логирования токенов              | §1.5              |
| #5 | Нет print()                          | §1.6              |
| #6 | Все классы закомментированы          | §1.8              |
| #7 | Использован const                    | §1.9              |
| #8 | Именование по стандарту              | §4.1              |
| #9 | Файлы в snake_case                   | §4.1              |

### 2.3 Чек-лист ПОСЛЕ генерации

□ 1. Код компилируется (нет синтаксических ошибок)

□ 2. Все импорты корректны

□ 3. README обновлён (если изменилась структура) (§14)

□ 4. Тесты добавлены (если новая бизнес-логика) (§8)

□ 5. Ошибки обрабатываются (§9)

□ 6. Логи безопасны (§9.4)

□ 7. Виджеты имеют const где возможно (§4.4)

□ 8. Локализация использована (§11.3)

□ 9. Доступность соблюдена (§11.5)

□ 10. pubspec.lock обновлён (§12.4)

### 2.4 Контекст проекта

| Параметр              | Значение                           |
|:----------------------|:-----------------------------------|
| **Название**          | Urban                              |
| **Тип**               | Платформа развлечений              |
| **Стек**              | Flutter 3.24+, Dart 3.5+           |
| **Архитектура**       | Clean Architecture + BLoC          |
| **Модули**            | :app, :core-*, :feature-*, :shared |
| **Язык комментариев** | Русский                            |
| **Мин. Android**      | 26 (8.0)                           |
| **Мин. iOS**          | 12.0                               |
| **Авторизация**       | Телефон, Email, VK ID, Yandex ID   |
| **Карты**             | OpenStreetMap (flutter_map)        |

---

## 3. 🏗️ АРХИТЕКТУРА

### 3.1 Паттерн: Clean Architecture + BLoC
Domain (Entity, Repository Interface, UseCase)

↓

Data (Repository Impl, API Service, Local DataSource)

↓

Presentation (BLoC, Screen, Widget)

**Запрещено:**
- Domain → Data/Presentation
- Data → Presentation
- BLoC → API напрямую (только через Repository)

### 3.2 Модульность
:app → :feature-* → :shared → :core-* → (никого)

**Запрещено:**
- `feature-chat` → `feature-map`
- Циклические зависимости

📖 **Подробно:** [§13 Модульная структура](#13-модульная-структура)

---

## 4. 📝 СТИЛЬ КОДА

### 4.1 Именование

| Элемент            | Стиль                  | Пример                         |
|:-------------------|:-----------------------|:-------------------------------|
| Переменные/Функции | `camelCase`            | `userName`, `loadData()`       |
| Классы             | `PascalCase`           | `UserProfile`, `PlaceListBloc` |
| Константы          | `SCREAMING_SNAKE_CASE` | `API_TIMEOUT`                  |
| Файлы              | `snake_case`           | `place_list_screen.dart`       |

**Суффиксы:** `*Bloc`, `*Screen`, `*Widget`, `*Repository`, `*UseCase`

### 4.2 Комментарии

```dart
/// Блок управления списком заведений
/// Отвечает за загрузку, фильтрацию и кэширование
class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  /// Загружает данные с сервера
  Future<void> loadPlaces() async {
    // Почему здесь retry 3 раза: лимит сервера 10 запросов/мин
    ...
  }
}
```

### 4.3 Импорты (порядок)
```dart 
// 1. Dart
import 'dart:async';
// 2. Flutter
import 'package:flutter/material.dart';
// 3. Сторонние
import 'package:dio/dio.dart';
// 4. Внутренние (core)
import 'package:core/core.dart';
// 5. Внутренние (feature)
import 'package:feature_auth/auth_bloc.dart';
// 6. Относительные (внутри модуля)
import 'bloc/place_list_bloc.dart';
```

### 4.4 const
```dart
// ✅ ХОРОШО
const Container(child: Text('Hello'))

// ❌ ПЛОХО
Container(child: Text('Hello'))
```

## 5. 📦 ЗАВИСИМОСТИ
   ### 5.1 Главное

   ✅ См. DEPENDENCIES.md — центральный источник версий

   ❌ НЕ обновлять версии без тестирования

   ### 5.2 Ключевые пакеты
| Категория    | Пакет                                   | Версия            |
|:-------------|:----------------------------------------|:------------------|
| State        | `flutter_bloc`                          | `9.1.1`           |
| DI           | `get_it`,`get_it`                       | `9.2.1`, `2.7.1`  |
| Network      | `dio`                                   | `5.9.2`           |
| Storage      | `hive`, `flutter_secure_storage`        | `2.2.3`, `10.0.0` |
| Navigation   | `go_router`                             | `17.2.0`          |
| Firebase     | `firebase_core`, `firebase_crashlytics` | `2.31.0`, `3.5.0` |
| Maps         | `yandex_maps_flutter`                   | `2.2.0`           |
| Maps Cluster | `yandex_mapkit`                         | `3.1.0`           |
| Images       | `cached_network_image`                  | `3.3.1`           |

📖 Полный список: DEPENDENCIES.md

## 6. 🔐 БЕЗОПАСНОСТЬ
   ### 6.1 Авторизация (v1.0)
  
| Метод              | Статус        |
|--------------------|---------------|
| Телефон + SMS      | ✅ Обязательно |
| Email + Пароль     | ✅ Обязательно |
| VK ID              | ✅ Обязательно |
| Yandex ID          | ✅ Обязательно |
| Сбер/Apple/Google  | ⏳ v2.0        |

   ### 6.2 Пароль
   ✅ Минимум 8 символов

   ✅ 1 заглавная буква (A-Z)

   ✅ 1 цифра (0-9)

   ⚠️ Спецсимволы — рекомендация (не блокировать)

   ### 6.3 Хранение секретов
```bash
# .env (НЕ коммитить!)
VK_CLIENT_ID=your_id
VK_CLIENT_SECRET=your_secret
YANDEX_MAPS_API_KEY=your_yandex_maps_key
```

### 6.4 Связывание аккаунтов
✅ Все методы → один user_id

✅ Новый метод → подтверждение (SMS/email)

❌ Нельзя удалить последний метод

### 6.5 Биометрия
✅ local_auth: 2.1.6

✅ Как опция (не замена пароля)

✅ Обработка ошибки (нет биометрии на устройстве)

### 6.6 Обфускация
```kotlin
// Android release
buildTypes {
    release {
        isMinifyEnabled = true
        proguardFiles(...)
    }
}
```

## 7. ⚡ ПРОИЗВОДИТЕЛЬНОСТЬ
   ### 7.1 Уровни кэширования

| Уровень | Что                  | Где                  | TTL         |
|---------|----------------------|----------------------|-------------|
| L1      | Текущий экран, BLoC  | RAM                  | До закрытия |
| L2      | Профиль, заведения   | Hive                 | 24 часа     |
| L3      | Избранное, настройки | Hive + Secure        | Постоянно   |
| L4      | Изображения          | cached_network_image | 7 дней      |

### 7.2 Лимиты по устройствам

| Параметр         | Слабое (<2GB)   | Среднее (2-4GB)  | Мощное (>4GB) |
|------------------|-----------------|------------------|---------------|
| Маркеры на карте | 100             | 300              | 500           |
| Анимации         | Выкл            | Вкл              | Вкл + эффекты |
| Кластеризация    | Обязательна     | Обязательна      | Рекомендуется |

### 7.3 Пагинация

✅ Списки: 50 элементов за запрос

✅ Чаты: 50 сообщений за запрос

✅ Использовать ListView.builder

### 7.4 Изображения
```dart
CachedNetworkImage(
  imageUrl: url,
  maxWidth: 400,
  maxHeight: 400,
  placeholder: (context, url) => ShimmerPlaceholder(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### 7.5 Очистка кэша

✅ v1.0: Ручная в настройках

✅ v2.0: Предложение при >500 МБ

❌ v1.0: Без авто-очистки

### 7.6 Геолокация и уведомления

✅ Системный Geofencing (не непрерывная)

✅ In-app уведомления при открытом приложении

✅ Server Regional Push (на основе последней локации)

✅ Opt-in от пользователя (настройки приватности)

❌ Фоновая геолокация (только геофенсинг)

### 7.7 Карты (Яндекс)

✅ Использовать yandex_maps_flutter: совместимую 

✅ Кластеризация через yandex_mapkit: 4.2.1

✅ API-ключ хранить в .env (НЕ в коде)

✅ Кэшировать область карты в Hive

✅ Загружать маркеры только в видимой области

## 8. 🧪 ТЕСТИРОВАНИЕ
   ### 8.1 Обязательные тесты

| Компонент         | Тип         | Покрытие     |
|-------------------|-------------|--------------|
| UseCase           | Unit        | 90%+         |
| Repository        | Unit        | 80%+         |
| BLoC              | Unit        | 70%+         |
| Критичные виджеты | Widget      | 50%+         |
| Ключевые сценарии | Integration | 5-10 потоков |

### 8.2 Минимальное покрытие

Общее: 70%+

Domain слой: 90%+

### 8.3 Пакеты
```yaml
dev_dependencies:
  bloc_test: 9.1.5
  mocktail: 1.0.3
  integration_test: sdk: flutter
  ```
### 8.4 CI/CD
✅ GitHub Actions при каждом push/PR

✅ Блокировка мерджа при failed тестах

✅ Проверка покрытия (мин. 70%)

## 9. 🔥 ОБРАБОТКА ОШИБОК И ЛОГИРОВАНИЕ
   ### 9.1 Уровни логирования

| Уровень   | Когда                          |
|-----------|--------------------------------|
| DEBUG     | Разработка                     |
| INFO      | Важные события (вход, покупка) |
| WARNING   | Предупреждения (кэш устарел)   |
| ERROR     | Ошибки (не загрузилось)        |
| CRITICAL  | Падения приложения             |

В продакшене: WARNING, ERROR, CRITICAL

### 9.2 Классы ошибок
```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;
}

class NetworkException extends AppException {}
class AuthException extends AppException {}
class ValidationException extends AppException {}
class ServerException extends AppException {}
```
### 9.3 Отображение пользователю
✅ SnackBar — обычные ошибки

✅ Dialog — критичные ошибки

❌ Не показывать стектрейс

### 9.4 Crashlytics
```dart
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
PlatformDispatcher.instance.onError = (error, stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  return true;
};
```
### 9.5 Логирование сети
```dart
// ✅ Безопасный интерсептор (не логирует токены/пароли)
class SafeLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('login')) {
      logger.i('REQUEST => ${options.path}');
      // Не логируем тело
    } else {
      logger.i('REQUEST => ${options.path}');
      logger.d('Data: ${_sanitizeData(options.data)}');
    }
    handler.next(options);
  }
}
```

## 10. 🌐 СЕТЬ И API
### 10.1 Dio конфигурация
```dart
BaseOptions(
  baseUrl: env['API_BASE_URL'],
  connectTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
  headers: {'Accept': 'application/json'},
)
```

### 10.2 Интерсепторы

| Интерсептор              | Назначение            |
|--------------------------|-----------------------|
| AuthInterceptor          | Добавляет токен       |
| SafeLoggingInterceptor   | Логи (без секретов)   |
| RetryInterceptor         | 3 попытки при ошибках |
| ConnectivityInterceptor  | Проверка интернета    |

### 10.3 Оффлайн-режим
✅ Кэш в Hive при отсутствии сети

✅ Очередь действий (отправить при подключении)

✅ Проверка connectivity_plus перед запросом

### 10.4 WebSocket (чаты)
✅ web_socket_channel: 2.4.0

✅ Переподключение при обрыве

✅ Отключать при неактивности > 5 мин

### 10.5 Модели данных
✅ freezed: 2.4.6 + json_serializable: 6.7.1

✅ Генерация через build_runner

## 11. 🎨 UI/UX СТАНДАРТЫ
### 11.1 Темы
✅ Светлая + Тёмная + Системная

✅ Переключение в настройках

### 11.2 Цветовая палитра
```dart
static const Color primary = Color(0xFF6C63FF);
static const Color secondary = Color(0xFFFF6B6B);
static const Color accent = Color(0xFF00D9A5);
static const Color error = Color(0xFFEF5350);
static const Color success = Color(0xFF66BB6A);
```

### 11.3 Локализация
✅ Русский (основной)

✅ Английский (дополнительный)

❌ Не хардкодить текст — использовать .arb

### 11.4 Отступы (8px grid)
```dart
static const double xs = 4.0;
static const double sm = 8.0;
static const double md = 16.0;
static const double lg = 24.0;
static const double xl = 32.0;
```

### 11.5 Доступность
✅ Мин. размер тапа: 48x48dp

✅ Мин. шрифт: 14sp (основной), 12sp (мин)

✅ Контрастность: WCAG 2.1 AA (4.5:1)

✅ Semantics для интерактивных элементов

### 11.6 Анимации

| Тип               | Длительность   |
|-------------------|----------------|
| Микро (кнопки)    | 150-200ms      |
| Переходы экранов  | 300-350ms      |
| Загрузка контента | 200-250ms      |

Для слабых устройств: отключать сложные анимации

## 12. 🔖 ВЕРСИОНИРОВАНИЕ И GIT
### 12.1 SemVer
```
MAJOR.MINOR.PATCH (1.0.0)
├─ MAJOR: ломающие изменения
├─ MINOR: новые функции
└─ PATCH: исправления багов
```
### 12.2 Conventional Commits
```
<type>(<scope>): <description>

Типы: feat, fix, docs, style, refactor, perf, test, chore, ci
```
Примеры:
```bash
✅ feat(auth): добавить вход через VK
✅ fix(chat): исправить дублирование сообщений
❌ исправил баг
```
### 12.3 Ветвление
```
main (продакшен)
  ↑
develop (разработка)
  ↑
feature/* → develop
hotfix/* → main + develop
```
### 12.4 pubspec.lock
✅ Коммитить (воспроизводимость сборок)

### 12.5 CHANGELOG
✅ Формат: Keep a Changelog

✅ Группировать: Добавлено, Изменено, Исправлено, Удалено

## 13. 🧱 МОДУЛЬНАЯ СТРУКТУРА
### 13.1 Типы модулей

| Модуль     | Назначение       | Зависимости        |
|------------|------------------|--------------------|
| :app       | Точка входа      | Все feature-*      |
| :core-*    | Инфраструктура   | Никаких внутренних |
| :feature-* | Бизнес-фичи      | :core-*, :shared   |
| :shared    | Общие компоненты | :core-*            |

### 13.2 Граф зависимостей
``` 
:app → :feature-* → :shared → :core-* → (никого)
 ```
#### Запрещено:
feature-chat → feature-map

shared → feature-*

core-* → feature-*

### 13.3 Структура feature-модуля
```
feature-name/
├── lib/
│   ├── feature_name.dart (public API)
│   └── src/
│       ├── data/ (datasource, model, repository)
│       ├── domain/ (entity, repository, usecase)
│       └── presentation/ (bloc, screen, widget)
├── build.gradle.kts
├── pubspec.yaml
└── README.md
```
### 13.4 Public API модуля
```dart
// feature_auth.dart — экспортирует только нужное
export 'src/presentation/screen/login_screen.dart';
export 'src/presentation/bloc/auth_bloc.dart';
export 'src/domain/entity/user.dart';

// НЕ экспортировать: data/, repository/, приватные виджеты
```
### 13.5 Навигация
✅ Централизованная в :app через go_router

❌ Прямые импорты между feature-* запрещены

### 13.6 Core-модули

| Модуль        | Назначение                                |
|---------------|-------------------------------------------|
| :core-network | Dio, интерсепторы, API Service            |
| :core-storage | Hive, Secure Storage, SharedPreferences   |
| :core-ui      | Темы, компоненты, дизайн-система          |
| :core-utils   | Extensions, validators, logger, constants |

### 13.7 Feature-модули

| Модуль            | Назначение                           |
|-------------------|--------------------------------------|
| :feature-auth     | Авторизация, профиль                 |
| :feature-map      | Яндекс.Карты, маркеры, кластеризация |
| :feature-chat     | Чаты, сообщения                      |
| :feature-events   | Ивенты, мероприятия                  |
| :feature-places   | Заведения, отзывы, бронь             |
| :feature-business | Кабинет предпринимателя              |
| :feature-social   | Лента, друзья                        |
| :feature-dating   | Свидания                             |
| :feature-payment  | Оплата                               |

## 14. 📄 ГЕНЕРАЦИЯ README
### 14.1 Обязательный шаблон
```markdown
# 📦 :{module_name}

## 📝 Описание
{Назначение модуля}

## 🔗 Зависимости
| Модуль    | Назначение    |
| :---      | :---          |

## 📂 Структура
{Дерево папок lib/}

## 🚀 Public API
| Экспорт   | Тип   | Назначение    |
| :---      | :---  | :---          |

## ⚙️ Интеграция
{Шаги для подключения}

## 🧪 Тесты
{Команды и покрытие}

## 📝 История изменений
| Версия    | Дата  | Изменения     |
| :---      | :---  | :---          |
```

### 14.2 Авто-генерация
ИИ должен автоматически:

Создавать README при создании модуля

Обновлять Public API при изменении экспортов

Обновлять Структуру при изменении папок

Обновлять Зависимости при добавлении пакетов

### 14.3 Шаблон модуля
```
📁 MODULE_TEMPLATE/
├── README.md
├── pubspec.yaml
├── build.gradle.kts
├── lib/
│   └── {module_name}.dart
└── test/
```

## 📎 ПРИЛОЖЕНИЯ
### A. Чек-лист перед коммитом
□ Код соответствует стилю (flutter analyze)

□ Все классы и методы закомментированы

□ Нет print() в коде

□ Нет хардкода секретов

□ Тесты проходят

□ README обновлён (если новый модуль)

□ Conventional Commits формат

□ pubspec.lock обновлён

### B. Ссылки на файлы

| Файл                      | Назначение                  |
|---------------------------|-----------------------------|
| DEPENDENCIES.md           | Все версии пакетов          |
| FUTURE_IMPLEMENTATIONS.md | План будущих функций        |
| MODULE_TEMPLATE/README.md | Шаблон для модулей          |
| .env.example              | Пример переменных окружения |
| .gitignore                | Исключения Git              |

### C. Проверка на противоречия

| Область        | Решение                            |
|----------------|------------------------------------|
| Пароли         | Спецсимвол — рекомендация          |
| Геолокация     | Только системный Geofencing        |
| Соц. логины    | VK + Yandex (остальное v2.0)       |
| Модульность    | Полная с начала                    |
| Очистка кэша   | Ручная v1.0, Авто-предложение v2.0 |
| Моки           | mocktail (не mockito)              |
| Логирование    | logger (не print)                  |
| Навигация      | Централизованная в :app            |
| pubspec.lock   | Коммитить                          |
| Карты          | Яндекс.Карты API (РФ)              |

## 🗺️ ПРИЛОЖЕНИЕ D: ЯНДЕКС.КАРТЫ — ИНТЕГРАЦИЯ
### D.1 Настройка API-ключа

```bash
# .env (НЕ коммитить!)
YANDEX_MAPS_API_KEY=your_api_key_from_developer.tech.yandex.ru
```
### D.2 Android настройка
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<application>
    <meta-data
        android:name="com.yandex.maps.api_key"
        android:value="${YANDEX_MAPS_API_KEY}" />
</application>
```
### D.3 iOS настройка
```plist
<!-- ios/Runner/Info.plist -->
<key>YandexMapsAPIKey</key>
<string>${YANDEX_MAPS_API_KEY}</string>
```
### D.4 Базовое использование
```dart
import 'package:yandex_maps_flutter/yandex_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _controller;
  
  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: (controller) => _controller = controller,
      onCameraPositionChanged: (position, _) {
        _loadPlacesInBounds(position.bounds);
      },
    );
  }
}
```
### D.5 Кластеризация маркеров
```dart
import 'package:yandex_mapkit/yandex_mapkit.dart';

final clusterizer = MapClusterizer(
  onClusterTap: (cluster) {
    _controller.moveCamera(
      CameraPosition(target: cluster.coordinates, zoom: 15),
    );
  },
);

// Добавление маркеров
clusterizer.addPlacemark(
  coordinates: LatLng(55.75, 37.61),
  icon: PlacemarkIcon.single(PlacemarkIconStyle(...)),
);
```

Документ готов к использованию. 

Ответственный: Urban Developer
