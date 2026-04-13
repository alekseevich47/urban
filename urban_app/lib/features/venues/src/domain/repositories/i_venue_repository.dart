import '../entities/venue.dart';

/// Интерфейс репозитория для работы с заведениями.
abstract class IVenueRepository {
  /// Получает список всех заведений.
  Future<List<EntertainmentVenue>> getVenues();
}
