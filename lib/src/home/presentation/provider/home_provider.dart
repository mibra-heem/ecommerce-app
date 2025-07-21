import 'package:ecommerce_app/src/home/domain/usecases/get_banners.dart';
import 'package:ecommerce_app/src/home/domain/usecases/get_categories.dart';
import 'package:ecommerce_app/src/home/domain/usecases/get_products.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required GetProducts getProducts,
    required GetCategories getCategories,
    required GetBanners getBanners,
  })  : _getProducts = getProducts,
        _getCategories = getCategories,
        _getBanners = getBanners {
    Future.microtask(initHomeData);
  }

  final GetProducts _getProducts;
  final GetCategories _getCategories;
  final GetBanners _getBanners;

  int _currentCategory = 0;

  int get currentCategory => _currentCategory;

  set currentCategory(int index) {
    _currentCategory = index;
    debugPrint('Current Category is : $_currentCategory');
    notifyListeners();
  }

  List<Product> _products = [];
  List<BannerEntity> _banners = [];
  List<CategoryEntity> _categories = [];

  List<Product> get products => _products;
  List<BannerEntity> get banners => _banners;
  List<CategoryEntity> get categories => _categories;

  void initHomeData() {
    getBannersHandler();
    getCategoriesHandler();
    getProductsHandler();
  }

  Future<void> getBannersHandler() async {
    final result = await _getBanners();

    result.fold((failure) => failure.errorMessage, (banners) {
      debugPrint('Banners fetched successfully.');
      _banners = banners;
      debugPrint('$_banners');
      notifyListeners();
    });
  }

  Future<void> getCategoriesHandler() async {
    final result = await _getCategories();

    result.fold((failure) => failure.errorMessage, (categories) {
      debugPrint('Categories fetched successfully.');
      _categories = categories;
      debugPrint('$_categories');
      notifyListeners();
    });
  }

  Future<void> getProductsHandler() async {
    debugPrint('getProducts ...............');
    final result = await _getProducts();

    result.fold(
      (failure) => failure.errorMessage,
      (products) {
        debugPrint('Products fetched successfully.');
        _products = products;
        debugPrint('$_products');
        notifyListeners();
      },
    );
  }
}
