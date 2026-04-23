import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;
  final Color? customPrimaryColor;

  const ChangeThemeEvent({
    required this.themeMode,
    this.customPrimaryColor,
  });

  @override
  List<Object?> get props => [themeMode, customPrimaryColor];
}
