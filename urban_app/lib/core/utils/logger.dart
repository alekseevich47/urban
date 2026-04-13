import 'dart:developer' as dev;

/// Утилита для логирования согласно §1.5 и §9 AI_CODING_GUIDELINES.
/// Исключает использование print() и обеспечивает безопасное логирование.
class UrbanLogger {
  /// Логирование отладочной информации
  static void d(String message, {String? tag}) {
    _log('DEBUG', message, tag);
  }

  /// Логирование важной информации
  static void i(String message, {String? tag}) {
    _log('INFO', message, tag);
  }

  /// Логирование предупреждений
  static void w(String message, {String? tag}) {
    _log('WARNING', message, tag);
  }

  /// Логирование ошибок
  static void e(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    _log('ERROR', message, tag, error: error, stackTrace: stackTrace);
  }

  static void _log(String level, String message, String? tag, {Object? error, StackTrace? stackTrace}) {
    final time = DateTime.now().toIso8601String();
    final logTag = tag != null ? '[$tag]' : '';
    dev.log(
      '[$time] [$level] $logTag $message',
      name: 'Urban',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
