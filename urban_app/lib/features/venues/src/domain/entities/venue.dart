import 'package:flutter/material.dart';

/// Категории заведений в Urban.
/// Используются для фильтрации и отображения иконок на карте.
enum VenueCategory {
  culture('Культура', Icons.museum_outlined),
  sport('Спорт', Icons.fitness_center_outlined),
  gaming('Игры', Icons.sports_esports_outlined),
  food('Еда', Icons.restaurant_outlined),
  nightlife('Ночь', Icons.nightlife_outlined),
  events('События', Icons.event_outlined),
  nature('Природа', Icons.terrain_outlined),
  hobbies('Хобби', Icons.palette_outlined),
  family('Семья', Icons.family_restroom_outlined),
  extreme('Экстрим', Icons.rocket_launch_outlined),
  active('Актив', Icons.bolt_outlined),
  education('Знания', Icons.school_outlined);

  final String label;
  final IconData icon;
  const VenueCategory(this.label, this.icon);
}

/// Теги заведения для умного поиска.
class VenueTags {
  final String price;
  final List<String> time;
  final bool isIndoor;
  final String age;
  final String company;
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

/// Модель координат для доменного слоя.
class UrbanLocation {
  final double latitude;
  final double longitude;

  const UrbanLocation(this.latitude, this.longitude);
}

/// Сущность заведения (Entertainment Venue) согласно Clean Architecture.
class EntertainmentVenue {
  final String id;
  final String name;
  final String description;
  final VenueCategory category;
  final String subCategory;
  final UrbanLocation location;
  final String imageUrl;
  final double rating;
  final double? priceFrom;
  final List<String> keywords;
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
