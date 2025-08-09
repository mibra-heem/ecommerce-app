import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/app/resources/media.dart';
import 'package:ecommerce_app/core/app/views/loading_view.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/widgets/not_found_text.dart';
import 'package:ecommerce_app/core/widgets/popup_item.dart';
import 'package:ecommerce_app/src/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/product_card_horizontal.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/src/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<int> categoryId = ValueNotifier(0);
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>()
      ..add(const GetBannersEvent())
      ..add(const GetCategoriesEvent())
      ..add(const GetProductsEvent());

    // _scrollController.addListener(_onScroll());
  }

  // void _onScroll() {
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //   const threshold = 200; // Load more when 200px from bottom
  //   if (currentScroll >= maxScroll - threshold) {
  //     // context.read<HomeBloc>().add(const GetProductsEvent(loadMore: true));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>()
              ..add(const GetBannersEvent())
              ..add(const GetCategoriesEvent())
              ..add(const GetProductsEvent());
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildBannerSlider()),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(child: _buildCategorySection()),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(child: _buildSectionTitle('Featured')),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: _buildFeaturedProducts()),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(child: _buildSectionTitle('New Arrivals')),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              _buildStaggeredProducts(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'MOHART',
        style: context.theme.textTheme.titleLarge?.copyWith(
          color: Colours.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Badge(
            isLabelVisible: false,
            child: Icon(IconlyBold.notification),
          ),
          onPressed: () {},
        ),
        PopupMenuButton(
          offset: const Offset(0, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: const Icon(LucideIcons.moreVertical),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Favourite',
                icon: IconlyLight.heart,
              ),
              onTap: () => context.pushNamed(RouteName.favourite),
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Settings',
                icon: IconlyLight.setting,
              ),
              onTap: () => context.pushNamed(RouteName.setting),
            ),
          ],
        ),
      ],
      elevation: 0,
    );
  }

  // Widget _buildSearchBar() {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       height: 45,
  //       decoration: BoxDecoration(
  //         color: context.isDarkMode ? Colours.grey900 : Colours.white,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 4,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       alignment: Alignment.centerLeft,
  //       child: Row(
  //         children: [
  //           const Icon(Icons.search, color: Colours.grey600),
  //           const SizedBox(width: 8),
  //           Text(
  //             'Search products...',
  //             style: context.theme.textTheme.bodyMedium
  //                 ?.copyWith(color: Colours.grey600),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBannerSlider() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.isLoadingBanners) {
          // Return shimmer placeholder
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade500,
            // direction: ShimmerDirection.ttb,
            child: Container(
              height: context.height * 0.18,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state.banners.isEmpty) {
          return const NotFoundText('No Products');
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: context.height * 0.18,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            enlargeCenterPage: true,
            viewportFraction: 1,
          ),
          items: state.banners.map((banner) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: ApiConfig.baseUrl + banner.image,
                width: double.infinity,
                fit: BoxFit.fill,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (_, __, ___) =>
                    const Image(image: AssetImage(Media.defaultShoeImage)),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCategorySection() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.isLoadingCategories) {
          return const LoadingView();
        } else if (state.categories.isEmpty) {
          return const NotFoundText('No Categories');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Categories'),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    state.categories.where((c) => c.parentId == null).length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ValueListenableBuilder(
                    valueListenable: categoryId,
                    builder: (context, value, _) {
                      final isSelected = categoryId.value == index;
                      return GestureDetector(
                        onTap: () {
                          categoryId.value = index;
                        },
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? Colours.grey900
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colours.primary
                                  : Colours.grey300,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Category icon
                              if (category.icon != null)
                                CachedNetworkImage(
                                  imageUrl: ApiConfig.baseUrl + category.icon!,
                                  width: 40,
                                  height: 40,
                                  errorWidget: (_, __, ___) {
                                    return const Icon(Icons.category);
                                  },
                                )
                              else
                                const Icon(Icons.image),
                              const SizedBox(height: 6),
                              Text(
                                category.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.theme.textTheme.labelSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text('View All'),
          ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.isLoadingProducts) return const LoadingView();
        if (state.products.isEmpty) return const NotFoundText('No Products');

        return SizedBox(
          height: context.width * 0.36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final products = state.products.reversed.toList();
              final product = (products[index] as ProductModel).copyWith(
                solds: 1500,
                reviews: List.filled(160, 'Good, Product.'),
                rating: 4.5,
                brand: 'Mohart',
                colors: ['#FF5733', '#4285F4', '#000000'],
                sizes: ['Small', 'Medium', 'Large'],
                materials: ['Leather', 'Paper', 'Wooden', 'Plastic'],
              );
              return ProductCardHorizontal(
                product: product,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStaggeredProducts() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.isLoadingProducts) {
          return const SliverToBoxAdapter(
            child: LoadingView(),
          );
        }
        if (state.products.isEmpty) {
          return const SliverToBoxAdapter(
            child: NotFoundText('No Products'),
          );
        }

        return SliverMasonryGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childCount: state.products.length,
          itemBuilder: (context, index) {
            final products = state.products;
            final product = (products[index] as ProductModel).copyWith(
              solds: 1500,
              reviews: List.filled(160, 'Good, Product.'),
              rating: 4.5,
              brand: 'Mohart',
              colors: ['#FF5733', '#4285F4', '#000000'],
              sizes: ['Small', 'Medium', 'Large'],
              materials: ['Leather', 'Paper', 'Wooden', 'Plastic'],
            );
            return ProductCardVertical(
              product: product,
            );
          },
        );
      },
    );
  }
}
