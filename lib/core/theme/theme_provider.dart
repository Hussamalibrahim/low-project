import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';
import 'app_theme.dart';

class ThemeState {
  final ThemeMode themeMode;
  final AppColorTheme colorTheme;
  final AppFontSize fontSize;

  const ThemeState({
    required this.themeMode,
    required this.colorTheme,
    required this.fontSize,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    AppColorTheme? colorTheme,
    AppFontSize? fontSize,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      colorTheme: colorTheme ?? this.colorTheme,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  static const _themeModeKey = 'pref_theme_mode';
  static const _colorThemeKey = 'pref_color_theme';
  static const _fontSizeKey = 'pref_font_size';

  ThemeNotifier()
      : super(const ThemeState(
          themeMode: ThemeMode.system,
          colorTheme: AppColorTheme.royalBlue,
          fontSize: AppFontSize.medium,
        )) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIdx = prefs.getInt(_themeModeKey);
    final colorThemeIdx = prefs.getInt(_colorThemeKey);
    final fontSizeIdx = prefs.getInt(_fontSizeKey);

    state = state.copyWith(
      themeMode: themeModeIdx != null
          ? ThemeMode.values[themeModeIdx]
          : ThemeMode.system,
      colorTheme: colorThemeIdx != null
          ? AppColorTheme.values[colorThemeIdx]
          : AppColorTheme.royalBlue,
      fontSize: fontSizeIdx != null
          ? AppFontSize.values[fontSizeIdx]
          : AppFontSize.medium,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  Future<void> setColorTheme(AppColorTheme theme) async {
    state = state.copyWith(colorTheme: theme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorThemeKey, theme.index);
  }

  Future<void> setFontSize(AppFontSize size) async {
    state = state.copyWith(fontSize: size);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_fontSizeKey, size.index);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
