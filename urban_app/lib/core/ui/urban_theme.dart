import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Дизайн-система приложения Urban.
/// Поддерживает динамическую смену тем (Light/Dark).
class UrbanTheme {
  // Базовые константы цветов
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00D9FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Темная палитра (Cyberpunk)
  static const Color darkBackground = Color(0xFF0A0E17);
  static const Color darkSurface = Color(0xFF151A25);
  static const Color darkCard = Color(0xFF1E2532);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B8C4);
  static const Color textMuted = Color(0xFF6B7280);
  
  // Светлая палитра (Pleasant White)
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1C1E);
  static const Color lightTextSecondary = Color(0xFF42474E);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color accentColor = Color(0xFFFFD700);

  /// Получение фонового цвета в зависимости от темы
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBackground 
        : lightBackground;
  }

  /// Получение цвета поверхности (карточки, панели)
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSurface 
        : lightSurface;
  }

  /// Получение основного цвета текста
  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkTextPrimary 
        : lightTextPrimary;
  }

  /// Получение вторичного цвета текста
  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkTextSecondary 
        : lightTextSecondary;
  }

  /// Стиль заголовка (средний)
  static TextStyle headingLarge(BuildContext context) => GoogleFonts.exo2(
    fontSize: 32, 
    fontWeight: FontWeight.bold, 
    color: getTextPrimary(context),
  );

  /// Стиль заголовка (средний)
  static TextStyle headingMedium(BuildContext context) => GoogleFonts.exo2(
    fontSize: 24, 
    fontWeight: FontWeight.w600, 
    color: getTextPrimary(context),
  );

  /// Стиль заголовка (малый)
  static TextStyle headingSmall(BuildContext context) => GoogleFonts.exo2(
    fontSize: 18, 
    fontWeight: FontWeight.w600, 
    color: getTextPrimary(context),
  );

  /// Стиль основного текста
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 16, 
    color: getTextPrimary(context),
  );

  /// Стиль вторичного текста
  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 14, 
    color: Theme.of(context).brightness == Brightness.dark 
        ? darkTextSecondary 
        : lightTextSecondary,
  );

  /// Стиль мелкого текста
  static TextStyle bodySmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 12, 
    color: Theme.of(context).brightness == Brightness.dark 
        ? darkTextSecondary 
        : lightTextSecondary,
  );

  /// Декорация для карточек
  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark 
        ? darkCard 
        : lightCard,
    borderRadius: BorderRadius.circular(16),
    boxShadow: Theme.of(context).brightness == Brightness.light 
        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
        : null,
  );

  /// Инпут для поиска
  static InputDecoration searchInputDecoration = InputDecoration(
    filled: true,
    fillColor: darkSurface.withValues(alpha: 0.8),
    hintStyle: GoogleFonts.inter(color: darkTextSecondary, fontSize: 14),
    prefixIcon: const Icon(Icons.search, color: primaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor.withValues(alpha: 0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor.withValues(alpha: 0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
