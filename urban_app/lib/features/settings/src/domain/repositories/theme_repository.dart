import 'package:flutter/material.dart';

/// Репозиторий для управления настройками темы.
abstract class ThemeRepository {
  /// Сохраняет выбранный режим темы.
  Future<void> saveThemeMode(ThemeMode mode);

  /// Получает сохраненный режим темы.
  Future<ThemeMode> getThemeMode();
}
