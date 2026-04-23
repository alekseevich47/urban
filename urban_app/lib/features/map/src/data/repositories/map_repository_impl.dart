import '../../domain/entities/urban_marker.dart';
import '../models/urban_marker_model.dart';
import 'package:urban_app/core/network/pocketbase_service.dart';

/// Тонкий репозиторий. 
/// Вся логика фильтрации и расчетов вынесена на сервер (VM_APP).
class MapRepositoryImpl {
  final _client = PocketBaseService.client;

  /// Просто запрашиваем маркеры для области.
  /// Сервер сам решит, какие маркеры и в каком количестве отдать.
  Future<List<UrbanMarker>> getMarkersInBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    String? category,
  }) async {
    try {
      // Мы не строим сложные SQL-like фильтры здесь.
      // Мы просто передаем параметры в наш серверный эндпоинт.
      final response = await _client.send('/api/urban/map/markers', method: 'GET', query: {
        'minLat': minLat,
        'maxLat': maxLat,
        'minLng': minLng,
        'maxLng': maxLng,
        if (category != null) 'category': category,
      });

      // Ответ от VM_APP уже содержит только нужные нам данные
      final List<dynamic> items = response['items'] ?? [];
      return items.map((item) => UrbanMarkerModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Запрос на создание также уходит на сервер для валидации и обработки
  Future<void> requestCreateMarker(UrbanMarkerModel model) async {
    await _client.send('/api/urban/map/markers', method: 'POST', body: model.toJson());
  }
}
