import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  // Когда развернете сервер в Yandex Cloud, просто вставьте сюда его IP или домен
  // Например: 'https://urban-backend.yandexcloud.net'
  static String baseUrl = 'http://127.0.0.1:8090';

  static late PocketBase _client;

  static PocketBase get client => _client;

  static void init({String? customUrl}) {
    if (customUrl != null) {
      baseUrl = customUrl;
    }
    _client = PocketBase(baseUrl);
  }
}
