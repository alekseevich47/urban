import 'package:equatable/equatable.dart';

/// Типы маркеров на карте
enum MarkerType {
  activity, // Развлечение
  event,    // Событие
  other     // Прочее
}

/// Сущность маркера Urban на карте.
/// Содержит минимально необходимые данные для отображения.
class UrbanMarker extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String? snippet;
  final MarkerType type;
  final Map<String, dynamic>? extraData;

  const UrbanMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.snippet,
    required this.type,
    this.extraData,
  });

  @override
  List<Object?> get props => [id, latitude, longitude, title, snippet, type, extraData];
}
