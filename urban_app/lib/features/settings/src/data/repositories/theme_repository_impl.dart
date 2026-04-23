import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/theme_repository.dart';

/// Реализация репозитория тем с использованием SharedPreferences.
class ThemeRepositoryImpl implements ThemeRepository {
  static const String _themeKey = 'selected_theme_mode';

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey);
    
    if (themeName == null) {
      return ThemeMode.dark; // По умолчанию темная
    }

    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.dark,
    );
  }
}
