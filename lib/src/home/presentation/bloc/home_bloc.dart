import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/home/domain/usecases/get_banners.dart';
import 'package:ecommerce_app/src/home/domain/usecases/get_categories.dart';
import 'package:ecommerce_app/src/home/domain/usecases/get_products.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetBanners getBanners,
    required GetCategories getCategories,
    required GetProducts getProducts,
  })  : _getBanners = getBanners,
        _getCategories = getCategories,
        _getProducts = getProducts,
        super(const HomeState()) {
    on<GetBannersEvent>(_getBannersHandler);
    on<GetCategoriesEvent>(_getCategoriesHandler);
    on<GetProductsEvent>(_getProductsHandler);
  }

  final GetBanners _getBanners;
  final GetCategories _getCategories;
  final GetProducts _getProducts;

  Future<void> _getBannersHandler(
    GetBannersEvent event,
    Emitter<HomeState> emit,
  ) async {
    // emit(LoadingBanners());
    // final result = await _getBanners();

    // result.fold((failure) => emit(BannerError(failure.errorMessage)),
    //     (banners) {
    //   emit(BannersLoaded(banners));
    // });

    emit(state.copyWith(isLoadingBanners: true));
    final result = await _getBanners();
    result.fold(
      (failure) => emit(
          state.copyWith(isLoadingBanners: false, bannerError: failure.errorMessage)),
      (banners) =>
          emit(state.copyWith(isLoadingBanners: false, banners: banners)),
    );
  }

  Future<void> _getCategoriesHandler(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    // emit(LoadingCategories());
    // final result = await _getCategories();

    // result.fold((failure) => emit(CategoryError(failure.errorMessage)),
    //     (categories) {
    //   emit(CategoriesLoaded(categories));
    // });

    emit(state.copyWith(isLoadingCategories: true));
    final result = await _getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categoryError: failure.errorMessage,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categories: categories,
        ),
      ),
    );
  }

  Future<void> _getProductsHandler(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    // emit(LoadingProducts());
    // final result = await _getProducts();

    // result.fold((failure) => emit(ProductError(failure.errorMessage)),
    //     (products) {
    //   emit(ProductsLoaded(products));
    // });

    emit(state.copyWith(isLoadingProducts: true));
    final result = await _getProducts();
    result.fold(
      (failure) => emit(state.copyWith(
          isLoadingProducts: false, productError: failure.errorMessage)),
      (products) =>
          emit(state.copyWith(isLoadingProducts: false, products: products)),
    );
  }
}
