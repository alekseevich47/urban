import '../../domain/entities/urban_marker.dart';

/// Модель маркера для работы с данными (PocketBase JSON)
class UrbanMarkerModel extends UrbanMarker {
  const UrbanMarkerModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.title,
    super.snippet,
    required super.type,
    super.extraData,
  });

  /// Создает модель из JSON от PocketBase
  factory UrbanMarkerModel.fromJson(Map<String, dynamic> json) {
    return UrbanMarkerModel(
      id: json['id'] as String,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      title: json['title'] as String,
      snippet: json['description'] as String?,
      type: _parseType(json['category'] as String?),
      extraData: json, // Сохраняем весь JSON как доп. данные
    );
  }

  /// Преобразует строку категории в Enum
  static MarkerType _parseType(String? category) {
    switch (category) {
      case 'activity':
        return MarkerType.activity;
      case 'event':
        return MarkerType.event;
      default:
        return MarkerType.other;
    }
  }

  /// Для отправки данных на сервер (создание/обновление)
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lng': longitude,
      'title': title,
      'description': snippet,
      'category': type.name,
    };
  }
}
