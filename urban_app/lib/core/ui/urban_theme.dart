import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Дизайн-система приложения Urban.
/// Содержит цветовую палитру, стили текста и декорации согласно §11 AI_CODING_GUIDELINES.
class UrbanTheme {
  // Цветовая палитра (§11.2)
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00D9FF);
  static const Color accentColor = Color(0xFF00D9A5); // Обновлено согласно §11.2
  static const Color successColor = Color(0xFF66BB6A); // Обновлено согласно §11.2
  static const Color warningColor = Color(0xFFFFAB00);
  static const Color errorColor = Color(0xFFEF5350); // Обновлено согласно §11.2
  
  static const Color backgroundColor = Color(0xFF0A0E17);
  static const Color surfaceColor = Color(0xFF151A25);
  static const Color cardColor = Color(0xFF1E2532);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C4);
  static const Color textMuted = Color(0xFF6B7785);
  
  /// Основной градиент приложения
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Отступы (§11.4 - 8px grid)
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Текстовые стили (§11.5)
  static TextStyle get headingLarge => GoogleFonts.exo2(
    fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary,
  );
  
  static TextStyle get headingMedium => GoogleFonts.exo2(
    fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary,
  );
  
  static TextStyle get headingSmall => GoogleFonts.exo2(
    fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16, color: textPrimary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14, color: textSecondary,
  );
  
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12, color: textMuted,
  );
  
  /// Декорация для карточек
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(16),
  );
  
  /// Декорация для неоновых кнопок
  static BoxDecoration get neonButtonDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(12),
  );
  
  /// Оформление полей поиска
  static InputDecoration get searchInputDecoration => InputDecoration(
    hintStyle: bodyMedium.copyWith(color: textMuted),
    prefixIcon: const Icon(Icons.search, color: textMuted),
    filled: true,
    fillColor: surfaceColor,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
  );
}
