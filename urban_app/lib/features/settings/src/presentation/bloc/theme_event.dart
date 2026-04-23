import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// События для управления темой приложения.
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Загрузка сохраненной темы.
class LoadThemeEvent extends ThemeEvent {}

/// Событие смены темы.
class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent({
    required this.themeMode,
  });

  @override
  List<Object?> get props => [themeMode];
}
