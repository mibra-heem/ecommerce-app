import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/constants/api_const.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:ecommerce_app/core/resources/media.dart';
import 'package:ecommerce_app/core/utils/dimensions.dart';
import 'package:ecommerce_app/src/home/presentation/provider/home_provider.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          readOnly: true,
          onTap: () {},
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: context.theme.colorScheme.surfaceBright,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            // 🖼️ Auto Sliding Banner
            Consumer<HomeProvider>(builder: (_, provider, __) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: Dimensions.height(120),
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 8),
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                ),
                items: provider.banners.map((banner) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: ApiConst.baseUrl+banner.image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) {
                        return const Image(
                            image: AssetImage(Media.defaultShoeImage));
                      },
                    ),
                  );
                }).toList(),
              );
            }),
            // const SizedBox(height: 10),
            // 🧭 Horizontal Categories
            SizedBox(
              height: 30,
              child: Consumer<HomeProvider>(builder: (_, provider, __) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    final isSelected = provider.currentCategory == index;
                    return GestureDetector(
                      onTap: () {
                        provider.currentCategory = index;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colours.primary
                              : context.theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category.name,
                          style: isSelected
                              ? context.theme.textTheme.labelSmall
                                  ?.copyWith(color: Colours.grey100)
                              : context.theme.textTheme.labelSmall,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // const SizedBox(height: 20),
            Text(
              'Featured',
              style: context.theme.textTheme.headlineMedium,
            ),
            // const SizedBox(height: 10),
            // 📦 Horizontal Product List
            SizedBox(
              height: context.height * .25,
              child: Consumer<HomeProvider>(builder: (_, provider, __) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return ProductCard(
                      name: product.name,
                      price: product.price,
                      imageUrl: ApiConst.baseUrl + product.image!,
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 20),
            Text(
              'New Arrivals',
              style: context.theme.textTheme.headlineMedium,
            ),
            // 🔲 Grid of Products
            Consumer<HomeProvider>(builder: (_, provider, __) {
              return GridView.builder(
                itemCount: provider.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63,
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = provider.products[index];
                  return ProductCard(
                    name: product.name,
                    price: product.price,
                    imageUrl: ApiConst.baseUrl + product.image!,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
