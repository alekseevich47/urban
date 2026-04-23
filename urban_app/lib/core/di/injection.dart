import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:urban_app/features/settings/src/domain/repositories/theme_repository.dart';
import 'package:urban_app/features/settings/src/data/repositories/theme_repository_impl.dart';
import 'package:urban_app/features/settings/src/presentation/bloc/theme_bloc.dart';
import 'injection.config.dart';

/// Глобальный экземпляр GetIt для доступа к зависимостям.
final GetIt getIt = GetIt.instance;

/// Инициализация конфигурации DI.
/// Генерируется автоматически при запуске build_runner.
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  // Вызов автоматически сгенерированной инициализации
  getIt.init();
  
  // РУЧНАЯ РЕГИСТРАЦИЯ (Временная мера из-за бага генератора injectable)
  // Это исправляет ошибку "ThemeBloc is not registered"
  if (!getIt.isRegistered<ThemeRepository>()) {
    getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
  }
  
  if (!getIt.isRegistered<ThemeBloc>()) {
    getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc(getIt<ThemeRepository>()));
  }
}
