import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Состояние темы приложения.
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
  });

  /// Начальное состояние — темная тема (согласно текущему дизайну).
  factory ThemeState.initial() {
    return const ThemeState(
      themeMode: ThemeMode.dark,
    );
  }

  @override
  List<Object?> get props => [themeMode];

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
