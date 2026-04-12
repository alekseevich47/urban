import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrbanTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00D9FF);
  static const Color accentColor = Color(0xFFFF2E6D);
  static const Color successColor = Color(0xFF00E676);
  static const Color warningColor = Color(0xFFFFAB00);
  static const Color errorColor = Color(0xFFFF5252); // Гарантированно здесь
  
  static const Color backgroundColor = Color(0xFF0A0E17);
  static const Color surfaceColor = Color(0xFF151A25);
  static const Color cardColor = Color(0xFF1E2532);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C4);
  static const Color textMuted = Color(0xFF6B7785);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
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
  
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(16),
  );
  
  static BoxDecoration get neonButtonDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(12),
  );
  
  static InputDecoration get searchInputDecoration => InputDecoration(
    hintStyle: bodyMedium.copyWith(color: textMuted),
    prefixIcon: const Icon(Icons.search, color: textMuted),
    filled: true,
    fillColor: surfaceColor,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
  );
}
