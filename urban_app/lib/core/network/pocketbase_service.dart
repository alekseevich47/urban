import 'package:injectable/injectable.dart';
import 'package:pocketbase/pocketbase.dart';
import '../utils/logger.dart';

/// Сервис для взаимодействия с PocketBase.
/// Инициализируется в main.dart и предоставляет доступ к клиенту.
@lazySingleton
class PocketBaseService {
  /// URL бекенда PocketBase.
  static String baseUrl = 'http://127.0.0.1:8090';

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
