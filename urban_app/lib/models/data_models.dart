import 'package:flutter/material.dart';

/// Категории заведений в Urban.
/// Используются для фильтрации и отображения иконок на карте.
enum VenueCategory {
  /// Музеи, театры, выставки
  culture('Культура', Icons.museum_outlined),
  /// Спортзалы, площадки
  sport('Спорт', Icons.fitness_center_outlined),
  /// Компьютерные клубы, квесты
  gaming('Игры', Icons.sports_esports_outlined),
  /// Рестораны, бары, кофейни
  food('Еда', Icons.restaurant_outlined),
  /// Клубы, бары (ночной режим)
  nightlife('Ночь', Icons.nightlife_outlined),
  /// Фестивали, концерты
  events('События', Icons.event_outlined),
  /// Парки, загородный отдых
  nature('Природа', Icons.terrain_outlined),
  /// Творческие студии, мастер-классы
  hobbies('Хобби', Icons.palette_outlined),
  /// Детские площадки, семейные центры
  family('Семья', Icons.family_restroom_outlined),
  /// Прыжки с парашютом, картинг
  extreme('Экстрим', Icons.rocket_launch_outlined),
  /// Активный отдых в городе
  active('Актив', Icons.bolt_outlined),
  /// Курсы, лекции
  education('Знания', Icons.school_outlined);

  final String label;
  final IconData icon;
  const VenueCategory(this.label, this.icon);
}

/// Теги заведения для умного поиска.
/// Помогают в фильтрации по бюджету, времени и аудитории.
class VenueTags {
  /// Бюджет: "бесплатно", "бюджетно", "средне", "дорого"
  final String price;
  /// Список временных меток: ["утро", "день", "вечер", "ночь"]
  final List<String> time;
  /// В помещении или на улице
  final bool isIndoor;
  /// Возрастное ограничение: "0+", "18+" и т.д.
  final String age;
  /// Для кого: "любая", "пары", "семья", "одиночки"
  final String company;
  /// Активный или пассивный отдых
  final bool isActive;

  const VenueTags({
    required this.price,
    required this.time,
    this.isIndoor = true,
    this.age = '0+',
    this.company = 'любая',
    this.isActive = false,
  });
}

/// Модель координат.
/// Используется для развязки бизнес-логики и картографических плагинов.
class UrbanLocation {
  final double latitude;
  final double longitude;

  const UrbanLocation(this.latitude, this.longitude);
}

/// Основная модель заведения (Entertainment Venue).
/// Содержит полную информацию для отображения на карте и в ленте.
class EntertainmentVenue {
  final String id;
  final String name;
  final String description;
  final VenueCategory category;
  final String subCategory;
  /// Координаты для отображения на карте
  final UrbanLocation location;
  final String imageUrl;
  final double rating;
  final double? priceFrom;
  /// Теги для текстового поиска
  final List<String> keywords;
  /// Структурированные теги для фильтров
  final VenueTags tags;

  const EntertainmentVenue({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.location,
    required this.imageUrl,
    required this.rating,
    this.priceFrom,
    this.keywords = const [],
    required this.tags,
  });
}
