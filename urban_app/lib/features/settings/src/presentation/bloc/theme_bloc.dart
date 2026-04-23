import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:urban_app/features/settings/src/domain/repositories/theme_repository.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_event.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_state.dart';

/// BLoC для управления темой приложения с поддержкой сохранения.
@lazySingleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository _repository;

  ThemeBloc(this._repository) 
      : super(ThemeState.initial()) {
    on<ChangeThemeEvent>(_onChangeTheme);
    on<LoadThemeEvent>(_onLoadTheme);
  }

  /// Загрузка сохраненной темы при старте.
  Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final mode = await _repository.getThemeMode();
    emit(state.copyWith(themeMode: mode));
  }

  /// Смена темы и её сохранение.
  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    await _repository.saveThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
