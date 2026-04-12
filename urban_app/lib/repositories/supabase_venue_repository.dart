import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_models.dart';
import 'venue_repository.dart';

class SupabaseVenueRepository implements VenueRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<List<EntertainmentVenue>> getVenues() async {
    final response = await _client
        .from('venues')
        .select()
        .order('name');

    return (response as List).map((json) => EntertainmentVenue.fromJson(json)).toList();
  }

  @override
  Future<EntertainmentVenue?> getVenueById(String id) async {
    final response = await _client
        .from('venues')
        .select()
        .eq('id', id)
        .single();

    return EntertainmentVenue.fromJson(response);
  }

  @override
  Future<List<EntertainmentVenue>> getVenuesByCategory(VenueCategory category) async {
    final categoryString = category.toString().split('.').last;
    final response = await _client
        .from('venues')
        .select()
        .eq('category', categoryString);

    return (response as List).map((json) => EntertainmentVenue.fromJson(json)).toList();
  }
}
