import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_repository.dart';
import 'dart:developer' as dev;

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'http://localhost:50106/',
    );
  }

  @override
  Future<void> signInWithVK() async {
    // 1. Логируем все доступные провайдеры для отладки
    final allProviders = OAuthProvider.values.map((e) => e.name).toList();
    dev.log('SUPABASE: Доступные OAuth провайдеры: $allProviders');
    print('SUPABASE: Доступные OAuth провайдеры: $allProviders');

    try {
      // 2. Ищем VK или Kakao (иногда путают) или что-то похожее
      OAuthProvider? targetProvider;

      for (var p in OAuthProvider.values) {
        final name = p.name.toLowerCase();
        if (name == 'vk' || name.contains('kontakte')) {
          targetProvider = p;
          break;
        }
      }

      // 3. Если в Enum всё-таки нет VK, используем "секретный" способ Supabase
      // передать провайдера как строку (через поиск в values по имени, даже если IDE ругается)
      if (targetProvider == null) {
        dev.log('SUPABASE: VK не найден в Enum, пробуем принудительный вызов...');
        // Пытаемся вызвать через редирект напрямую, если SDK позволяет
        // Или кидаем ошибку с именами, чтобы мы могли поправить
        throw Exception('Провайдер VK не найден. Доступные: $allProviders');
      }

      await _client.auth.signInWithOAuth(
        targetProvider,
        redirectTo: 'http://localhost:50106/',
      );
    } catch (e) {
      dev.log('SUPABASE: Ошибка входа через VK: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
