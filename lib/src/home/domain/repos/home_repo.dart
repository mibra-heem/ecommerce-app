import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';

abstract class HomeRepo {
  const HomeRepo();

  RFuture<List<BannerEntity>> getBanners();
  RFuture<List<Category>> getCategories();
  RFuture<List<Product>> getProducts();

}
