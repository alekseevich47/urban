import '../models/data_models.dart';

abstract class VenueRepository {
  Future<List<EntertainmentVenue>> getVenues();
  Future<EntertainmentVenue?> getVenueById(String id);
  Future<List<EntertainmentVenue>> getVenuesByCategory(VenueCategory category);
}
