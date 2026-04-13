import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:urban_app/features/auth/src/domain/entities/user.dart';
import 'package:urban_app/features/auth/src/domain/repositories/i_auth_repository.dart';

/// Реализация репозитория аутентификации.
/// В данной версии использует Mock-данные и локальный контроллер потока.
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final _userController = StreamController<User?>();

  @override
  Stream<User?> get user => _userController.stream;

  @override
  Future<void> loginWithEmail(String email, String password) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    if (password == 'password123') {
      final user = User(
        id: 'mock_user_123',
        email: email,
        username: 'Urban Explorer',
      );
      _userController.add(user);
    } else {
      throw Exception('Неверный пароль');
    }
  }

  @override
  Future<void> logout() async {
    _userController.add(null);
  }
}
