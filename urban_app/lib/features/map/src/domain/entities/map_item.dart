/// Сущность объекта на карте для модуля Map.
/// Описывает базовые координаты и метаданные для отображения маркера.
class MapItem {
  /// Уникальный идентификатор объекта.
  final String id;

  /// Широта.
  final double latitude;

  /// Долгота.
  final double longitude;

  /// Заголовок (опционально).
  final String? title;

  /// Иконка маркера (путь к ассету).
  final String? iconAsset;

  /// Оригинальный объект данных (например, Venue или Event).
  final Object? data;

  const MapItem({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.title,
    this.iconAsset,
    this.data,
  });
}
