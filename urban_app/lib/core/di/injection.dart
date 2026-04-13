import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
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
void configureDependencies() => getIt.init();
