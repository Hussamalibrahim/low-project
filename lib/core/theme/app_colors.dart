import 'package:flutter/material.dart';

enum AppColorTheme {
  royalBlue('الأزرق الملكي'),
  midnightNavy('الكحلي الليلي'),
  emerald('الزمردي الدمشقي'),
  burgundy('العنابي الملكي'),
  gold('الذهبي العتيق'),
  slate('الإردوازي الوقور');

  final String arabicName;
  const AppColorTheme(this.arabicName);
}

class ThemeColors {
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color secondary;
  final Color accent;
  final Color backgroundLight;
  final Color surfaceLight;
  final Color backgroundDark;
  final Color surfaceDark;

  const ThemeColors({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.secondary,
    required this.accent,
    required this.backgroundLight,
    required this.surfaceLight,
    required this.backgroundDark,
    required this.surfaceDark,
  });
}

class AppPalettes {
  static const Map<AppColorTheme, ThemeColors> palettes = {
    AppColorTheme.royalBlue: ThemeColors(
      primary: Color(0xFF1A365D),
      primaryLight: Color(0xFF60A5FA),
      primaryDark: Color(0xFF0F2442),
      secondary: Color(0xFF3182CE),
      accent: Color(0xFFD69E2E),
      backgroundLight: Color(0xFFF7FAFC),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF0F172A),
      surfaceDark: Color(0xFF1E293B),
    ),
    AppColorTheme.midnightNavy: ThemeColors(
      primary: Color(0xFF0A192F),
      primaryLight: Color(0xFF38BDF8),
      primaryDark: Color(0xFF020C1B),
      secondary: Color(0xFF3B82F6),
      accent: Color(0xFF64FFDA),
      backgroundLight: Color(0xFFF8FAFC),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF020617),
      surfaceDark: Color(0xFF0F172A),
    ),
    AppColorTheme.emerald: ThemeColors(
      primary: Color(0xFF064E3B),
      primaryLight: Color(0xFF34D399),
      primaryDark: Color(0xFF022C22),
      secondary: Color(0xFF10B981),
      accent: Color(0xFFF59E0B),
      backgroundLight: Color(0xFFF0FDF4),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF022C22),
      surfaceDark: Color(0xFF064E3B),
    ),
    AppColorTheme.burgundy: ThemeColors(
      primary: Color(0xFF4C0519),
      primaryLight: Color(0xFFFB7185),
      primaryDark: Color(0xFF29020D),
      secondary: Color(0xFFBE123C),
      accent: Color(0xFFEAB308),
      backgroundLight: Color(0xFFFFF1F2),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF1F040C),
      surfaceDark: Color(0xFF3B0716),
    ),
    AppColorTheme.gold: ThemeColors(
      primary: Color(0xFF78350F),
      primaryLight: Color(0xFFFBBF24),
      primaryDark: Color(0xFF451A03),
      secondary: Color(0xFFD97706),
      accent: Color(0xFF2563EB),
      backgroundLight: Color(0xFFFFFBEB),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF1C1204),
      surfaceDark: Color(0xFF2E1E09),
    ),
    AppColorTheme.slate: ThemeColors(
      primary: Color(0xFF334155),
      primaryLight: Color(0xFF94A3B8),
      primaryDark: Color(0xFF1E293B),
      secondary: Color(0xFF64748B),
      accent: Color(0xFF3B82F6),
      backgroundLight: Color(0xFFF8FAFC),
      surfaceLight: Color(0xFFFFFFFF),
      backgroundDark: Color(0xFF0F172A),
      surfaceDark: Color(0xFF1E293B),
    ),
  };
}
