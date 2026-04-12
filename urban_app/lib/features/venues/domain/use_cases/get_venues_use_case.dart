import '../../../../models/data_models.dart';
import '../repositories/i_venue_repository.dart';

/// UseCase для получения списка заведений.
class GetVenuesUseCase {
  final IVenueRepository _repository;

  GetVenuesUseCase(this._repository);

  /// Выполняет получение списка заведений через репозиторий.
  Future<List<EntertainmentVenue>> call() async {
    return await _repository.getVenues();
  }
}
