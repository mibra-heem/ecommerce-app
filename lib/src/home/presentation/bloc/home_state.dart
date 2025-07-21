part of 'home_bloc.dart';

// sealed class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }

// final class HomeInitial extends HomeState {}

// final class LoadingBanners extends HomeState {}

// final class LoadingCategories extends HomeState {}

// final class LoadingProducts extends HomeState {}

// final class BannersLoaded extends HomeState {
//   const BannersLoaded(this.banners);

//   final List<BannerEntity> banners;

//   @override
//   List<Object> get props => [banners];
// }

// final class CategoriesLoaded extends HomeState {
//   const CategoriesLoaded(this.categories);

//   final List<CategoryEntity> categories;

//   @override
//   List<Object> get props => [categories];
// }

// final class ProductsLoaded extends HomeState {
//   const ProductsLoaded(this.products);

//   final List<Product> products;

//   @override
//   List<Object> get props => [products];
// }

// final class BannerError extends HomeState {
//   const BannerError(this.message);

//   final String message;

//   @override
//   List<Object> get props => [message];
// }

// final class CategoryError extends HomeState {
//   const CategoryError(this.message);

//   final String message;

//   @override
//   List<Object> get props => [message];
// }

// final class ProductError extends HomeState {
//   const ProductError(this.message);

//   final String message;

//   @override
//   List<Object> get props => [message];
// }

class HomeState extends Equatable {
  const HomeState({
    this.isLoadingBanners = false,
    this.isLoadingCategories = false,
    this.isLoadingProducts = false,
    this.banners = const [],
    this.categories = const [],
    this.products = const [],
    this.bannerError,
    this.categoryError,
    this.productError,
  });

  final bool isLoadingBanners;
  final bool isLoadingCategories;
  final bool isLoadingProducts;
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<Product> products;
  final String? bannerError;
  final String? categoryError;
  final String? productError;


  HomeState copyWith({
    bool? isLoadingBanners,
    bool? isLoadingCategories,
    bool? isLoadingProducts,
    List<BannerEntity>? banners,
    List<CategoryEntity>? categories,
    List<Product>? products,
    String? bannerError,
    String? categoryError,
    String? productError,
  }) {
    return HomeState(
      isLoadingBanners: isLoadingBanners ?? this.isLoadingBanners,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      bannerError: bannerError,
      categoryError: categoryError,
      productError: productError,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingBanners,
        isLoadingCategories,
        isLoadingProducts,
        banners,
        categories,
        products,
        bannerError,
        categoryError,
        productError,
      ];
}
