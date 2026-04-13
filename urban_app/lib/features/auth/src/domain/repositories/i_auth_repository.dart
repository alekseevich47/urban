import 'package:urban_app/features/auth/src/domain/entities/user.dart';

/// Интерфейс репозитория для работы с аутентификацией.
abstract class IAuthRepository {
  /// Текущий авторизованный пользователь.
  Stream<User?> get user;

  /// Вход по Email и паролю.
  Future<void> loginWithEmail(String email, String password);

  /// Выход из аккаунта.
  Future<void> logout();
}
