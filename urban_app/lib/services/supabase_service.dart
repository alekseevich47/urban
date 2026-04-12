import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://ocvffjkbvsuqqlpudmbg.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_NFPwRSDrH9Rt0AuFEucSyw_u9ivjOTr';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  // Пример метода для получения заведений из БД
  static Future<List<Map<String, dynamic>>> getVenues() async {
    final response = await client
        .from('venues')
        .select()
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }
}
