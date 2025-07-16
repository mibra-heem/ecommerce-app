import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/profile/features/theme/data/datasource/theme_local_data_src.dart';
import 'package:ecommerce_app/src/profile/features/theme/domain/repo/theme_repo.dart';

class ThemeRepoImpl implements ThemeRepo {
  const ThemeRepoImpl(this._localDataSrc);

  final ThemeLocalDataSrc _localDataSrc;

  @override
  RFuture<void> cacheThemeMode(int index) async {
    try {
      await _localDataSrc.cacheThemeMode(index);

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<int> loadThemeMode() async {
    try {
      final result = await _localDataSrc.loadThemeMode();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
