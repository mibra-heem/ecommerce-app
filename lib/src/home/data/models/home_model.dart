import 'package:ecommerce_app/src/home/domain/entities/home_entity.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.banners,
    required super.categories,
    required super.products,
  });

  HomeModel.empty() : super.empty();

  factory HomeModel.fromJson(Map<String, dynamic> data) {
    return HomeModel(
      banners: data['banners'] as List<BannerEntity>,
      categories: data['categories'] as List<CategoryEntity>,
      products: data['products'] as List<Product>,
    );
  }

  HomeModel copyWith({
    List<BannerEntity>? banners,
    List<CategoryEntity>? categories,
    List<Product>? products,
  }) {
    return HomeModel(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  // No need of this on user side
  Map<String, dynamic> toJson() {
    return {
      'banners': banners,
      'categories': categories,
      'products': products,
    };
  }
}
