import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrbanTheme {
  // Основная палитра - неоновый киберпанк стиль
  static const Color primaryColor = Color(0xFF6C63FF); // Фиолетовый неон
  static const Color secondaryColor = Color(0xFF00D9FF); // Голубой неон
  static const Color accentColor = Color(0xFFFF2E6D); // Розовый неон
  static const Color successColor = Color(0xFF00E676); // Зеленый неон
  static const Color warningColor = Color(0xFFFFAB00); // Оранжевый неон
  
  // Фоновые цвета
  static const Color backgroundColor = Color(0xFF0A0E17); // Очень темный синий
  static const Color surfaceColor = Color(0xFF151A25); // Темный серый для карточек
  static const Color cardColor = Color(0xFF1E2532); // Чуть светлее для карточек
  
  // Текст
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C4);
  static const Color textMuted = Color(0xFF6B7785);
  
  // Градиенты
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient neonGradient = LinearGradient(
    colors: [primaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [backgroundColor, surfaceColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Текстовые стили
  static TextStyle get headingLarge => GoogleFonts.exo2(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.5,
  );
  
  static TextStyle get headingMedium => GoogleFonts.exo2(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static TextStyle get headingSmall => GoogleFonts.exo2(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textMuted,
  );
  
  static TextStyle get buttonLabel => GoogleFonts.exo2(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  // Декорации
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  static BoxDecoration get neonButtonDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.4),
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  );
  
  static InputDecoration get searchInputDecoration => InputDecoration(
    hintText: 'Поиск развлечений...',
    hintStyle: bodyMedium.copyWith(color: textMuted),
    prefixIcon: const Icon(Icons.search, color: textMuted),
    filled: true,
    fillColor: surfaceColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
