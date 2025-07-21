import 'package:ecommerce_app/core/config/storage.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavouriteLocalDataSrc {
  const FavouriteLocalDataSrc();

  Future<int> loadFavouriteData();
  Future<void> cacheFavouriteData(int index);
}

class FavouriteLocalDataSrcImpl implements FavouriteLocalDataSrc {
  const FavouriteLocalDataSrcImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFavouriteData(int index) async {
    try {
      await _prefs.setInt(StorageConfig.theme, index);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'cache-favourite-data-failed',
      );
    }
  }

  @override
  Future<int> loadFavouriteData() async {
    try {
      
      return _prefs.getInt(StorageConfig.theme) ?? ThemeMode.dark.index;

    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'load-favourite-data-failed',
      );
    }
  }
}
