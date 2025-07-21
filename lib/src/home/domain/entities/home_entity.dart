import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.banners,
    required this.categories,
    required this.products,
  });

  HomeEntity.empty()
      : this(
          banners: <BannerEntity>[],
          categories: <CategoryEntity>[],
          products: <Product>[],
        );

  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<Product> products;

  @override
  List<Object?> get props => [
        banners,
        categories,
        products,
      ];

  @override
  String toString() {
    return 'HomeEntity{banners: $banners, categories: $categories, products: '
        '$products}';
  }
}
