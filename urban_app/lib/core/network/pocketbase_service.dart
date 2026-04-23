import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:pocketbase/pocketbase.dart';
import '../utils/logger.dart';

/// Сервис для взаимодействия с PocketBase.
/// Инициализируется в main.dart и предоставляет доступ к клиенту.
@lazySingleton
class PocketBaseService {
  /// URL бекенда PocketBase из .env или дефолтный.
  static String baseUrl = dotenv.get('API_BASE_URL', fallback: 'https://urban42.online/api');

  static late PocketBase _client;

  /// Возвращает настроенный клиент PocketBase.
  static PocketBase get client => _client;

  /// Инициализация клиента.
  static void init({String? customUrl}) {
    if (customUrl != null) {
      baseUrl = customUrl;
    }
    _client = PocketBase(baseUrl);
    UrbanLogger.i('PocketBaseService initialized on $baseUrl');
  }
}
