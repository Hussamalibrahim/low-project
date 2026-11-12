import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

enum AppFontSize {
  small('صغير', 0.90),
  medium('متوسط (افتراضي)', 1.0),
  large('كبير', 1.08),
  extraLarge('كبير جداً', 1.15);

  final String arabicName;
  final double scale;
  const AppFontSize(this.arabicName, this.scale);
}

class AppTheme {
  static ThemeData buildTheme({
    required AppColorTheme colorTheme,
    required bool isDark,
    required AppFontSize fontSize,
  }) {
    final palette = AppPalettes.palettes[colorTheme]!;

    final ColorScheme colorScheme = isDark
        ? ColorScheme.dark(
            primary: palette.primaryLight,
            onPrimary: Colors.white,
            secondary: palette.secondary,
            onSecondary: Colors.white,
            surface: palette.surfaceDark,
            onSurface: const Color(0xFFF1F5F9),
            error: const Color(0xFFEF4444),
            onError: Colors.white,
          )
        : ColorScheme.light(
            primary: palette.primary,
            onPrimary: Colors.white,
            secondary: palette.secondary,
            onSecondary: Colors.white,
            surface: palette.surfaceLight,
            onSurface: const Color(0xFF0F172A),
            error: const Color(0xFFDC2626),
            onError: Colors.white,
          );

    final TextTheme baseTextTheme = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    ).textTheme.apply(
      fontFamily: GoogleFonts.cairo().fontFamily,
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? palette.backgroundDark : palette.backgroundLight,
      textTheme: baseTextTheme,
      fontFamily: GoogleFonts.cairo().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? palette.surfaceDark : palette.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: isDark ? palette.surfaceDark : palette.surfaceLight,
        elevation: isDark ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isDark
                ? const Color(0xFF334155)
                : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? const Color(0xFF334155)
                : const Color(0xFFCBD5E1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? const Color(0xFF334155)
                : const Color(0xFFCBD5E1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        thickness: 1,
      ),
    );
  }
}
