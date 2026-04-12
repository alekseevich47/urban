import '../../../../models/data_models.dart';

/// Интерфейс репозитория для работы с заведениями.
abstract class IVenueRepository {
  /// Получает список всех заведений.
  Future<List<EntertainmentVenue>> getVenues();
}
