import 'package:pocketbase/pocketbase.dart';
import '../../domain/entities/urban_marker.dart';
import '../models/urban_marker_model.dart';
import '../../../../core/network/pocketbase_service.dart';

/// Репозиторий для работы с картой и маркерами.
/// Реализует логику получения данных с сервера с фильтрацией.
class MapRepositoryImpl {
  final PocketBase _pb = PocketBaseService.client;
  final String _collectionName = 'activities';

  /// Получает список маркеров, попадающих в видимую область карты.
  /// Вся фильтрация происходит на стороне сервера PocketBase.
  Future<List<UrbanMarker>> getMarkersInBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    String? category,
  }) async {
    try {
      // Формируем фильтр для серверной выборки (Bounding Box)
      String filter = 'lat >= $minLat && lat <= $maxLat && lng >= $minLng && lng <= $maxLng';
      
      // Добавляем фильтрацию по категории, если она выбрана
      if (category != null && category.isNotEmpty) {
        filter += ' && category = "$category"';
      }

      // Делаем запрос к PocketBase
      final records = await _pb.collection(_collectionName).getList(
        filter: filter,
        sort: '-created',
      );

      // Маппим JSON-ответы в модели и возвращаем как сущности
      return records.items
          .map((record) => UrbanMarkerModel.fromJson(record.toJson()))
          .toList();
    } catch (e) {
      // Здесь можно добавить логирование через UrbanLogger
      rethrow;
    }
  }

  /// Создает новый маркер (событие/развлечение) в БД
  Future<UrbanMarker> createMarker(UrbanMarkerModel model) async {
    final record = await _pb.collection(_collectionName).create(
      body: model.toJson(),
    );
    return UrbanMarkerModel.fromJson(record.toJson());
  }
}
