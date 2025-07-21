import 'package:ecommerce_app/core/config/storage.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSrc {
  const ThemeLocalDataSrc();

  Future<int> loadThemeMode();
  Future<void> cacheThemeMode(int index);
}

class ThemeLocalDataSrcImpl implements ThemeLocalDataSrc {
  const ThemeLocalDataSrcImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> cacheThemeMode(int index) async {
    try {
      await _prefs.setInt(StorageConfig.theme, index);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'cache-theme-mode-failed',
      );
    }
  }

  @override
  Future<int> loadThemeMode() async {
    try {
      
      return _prefs.getInt(StorageConfig.theme) ?? ThemeMode.dark.index;

    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'load-theme-mode-failed',
      );
    }
  }
}
