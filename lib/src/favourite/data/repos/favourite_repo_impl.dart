import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/favourite/data/datasource/favourite_local_data_src.dart';
import 'package:ecommerce_app/src/favourite/domain/repos/favourite_repo.dart';

class FavouriteRepoImpl implements FavouriteRepo {
  const FavouriteRepoImpl(this._localDataSrc);

  final FavouriteLocalDataSrc _localDataSrc;

  @override
  RFuture<void> cacheFavouriteData(int index) async {
    try {
      await _localDataSrc.cacheFavouriteData(index);

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<int> loadFavouriteData() async {
    try {
      final result = await _localDataSrc.loadFavouriteData();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
