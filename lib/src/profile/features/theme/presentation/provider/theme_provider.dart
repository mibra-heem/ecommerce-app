import 'package:ecommerce_app/core/enums/themes.dart';
import 'package:ecommerce_app/src/profile/features/theme/domain/usecases/cache_theme_mode.dart';
import 'package:ecommerce_app/src/profile/features/theme/domain/usecases/load_theme_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({
    required CacheThemeMode cacheThemeMode,
    required LoadThemeMode loadThemeMode,
  }) : _cacheThemeMode = cacheThemeMode,
       _loadThemeMode = loadThemeMode {
    loadTheme();
  }

  final CacheThemeMode _cacheThemeMode;
  final LoadThemeMode _loadThemeMode;

  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    await _cacheThemeMode(themeMode.index);
  }

  Future<void> setTheme(Themes theme) async {
    switch (theme) {
      case Themes.dark:
        themeMode = ThemeMode.dark;
      case Themes.light:
        themeMode = ThemeMode.light;
      case Themes.system:
        themeMode = ThemeMode.system;
    }
    await _cacheThemeMode(themeMode.index);
  }

  Future<void> loadTheme() async {
    final result = await _loadThemeMode();
    result.fold(
      (failure) =>
          debugPrint('Error loading cached theme: ${failure.errorMessage}'),
      (index) {
        themeMode = ThemeMode.values[index];
      },
    );
  }
}
