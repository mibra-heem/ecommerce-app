import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/home/data/datasources/home_remote_data_src.dart';
import 'package:ecommerce_app/src/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';

class HomeRepoImpl implements HomeRepo {
  const HomeRepoImpl(this._remoteDataSrc);

  final HomeRemoteDataSrc _remoteDataSrc;

  @override
  RFuture<List<BannerEntity>> getBanners() async {
    try {
      final banners = await _remoteDataSrc.getBanners();
      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<List<Category>> getCategories() async{
    try {
      final categories = await _remoteDataSrc.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<List<Product>> getProducts() async{
    try {
      final products = await _remoteDataSrc.getProducts();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
