import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/home/features/banner/data/models/banner_model.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/data/models/category_model.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/data/models/product_model.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

abstract class HomeRemoteDataSrc {
  const HomeRemoteDataSrc();

  Future<List<BannerEntity>> getBanners();
  Future<List<CategoryEntity>> getCategories();
  Future<List<Product>> getProducts();
}

class HomeRemoteDataSrcImpl implements HomeRemoteDataSrc {
  const HomeRemoteDataSrcImpl(ApiService apiService) : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<BannerEntity>> getBanners() async {
    try {
      final data = await _apiService.get(url: ApiConfig.bannersUrl);

      debugPrint('Banners Data : $data');

      final banners = data['banners'] as List<dynamic>;

      return banners
          .map((banner) => BannerModel.fromJson(banner as DMap))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final data = await _apiService.get(url: ApiConfig.categoriesUrl);

      debugPrint('Categories Data : $data');

      final categories = data['categories'] as List<dynamic>;

      return categories
          .map((category) => CategoryModel.fromJson(category as DMap))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final data = await _apiService.get(url: ApiConfig.productsUrl);

      debugPrint('Products Data : $data');

      final products = data['products'] as List<dynamic>;

      return products.map((p) => ProductModel.fromJson(p as DMap)).toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
