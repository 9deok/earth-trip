import 'package:flutter/material.dart';

class AppColors {
  // Brand palette (requested)
  static const Color brandPrimary = Color(0xFF6C584C);
  static const Color brandSecondary = Color(0xFFADC178);
  static const Color accent = Color(0xFFDDA15E);
  static const Color background = Color(0xFFFEFAF4);
  static const Color backgroundSub = Color(0xFFF0F2F5);

  // Semantic/supporting (keep for future use)
  static const Color success = Color(0xFF2E7D32);
  static const Color info = Color(0xFF0277BD);
  static const Color warning = Color(0xFFF9A825);
  static const Color danger = Color(0xFFC62828);

  // Typography
  static const Color textPrimary = Color(0xFF3A3A3A);
  static const Color textSecondary = Color(
    0x993A3A3A,
  ); // 60% opacity of textPrimary

  // Scheme helpers (derive from seed, then override key tones)
  static ColorScheme lightColorScheme() {
    final base = ColorScheme.fromSeed(
      seedColor: brandPrimary,
      brightness: Brightness.light,
    );
    return base.copyWith(
      primary: brandPrimary,
      onPrimary: Colors.white,
      secondary: brandSecondary,
      onSecondary: Colors.black,
      tertiary: accent,
      onTertiary: Colors.white,
      background: background,
      onBackground: textPrimary,
      surface: Colors.white,
      onSurface: textPrimary,
      surfaceVariant: backgroundSub,
      onSurfaceVariant: textSecondary,
    );
  }

  // No dark theme for now
}
