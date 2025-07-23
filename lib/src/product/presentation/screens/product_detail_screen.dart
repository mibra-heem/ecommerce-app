import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/extensions/int_extension.dart';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:ecommerce_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/favourite/presentation/provider/favourite_provider.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  bool _isDescExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: context.theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 8),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, __) {
              return Badge(
                label: Text('${cart.totalItems}'),
                isLabelVisible: cart.totalItems > 0,
                offset: const Offset(-4, 4),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, size: 24,),
                  onPressed: () {
                    context.pushNamed(RouteName.cart);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel
            _buildImageCarousel(context),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  if (product.brand != null && product.brand!.isNotEmpty)
                    Text(
                      product.brand!,
                      style: context.theme.textTheme.labelSmall
                          ?.copyWith(color: Colours.grey600),
                    ),
                  const SizedBox(height: 4),

                  // Name
                  Text(
                    product.name,
                    style: context.theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    'Rs. ${CoreUtils.currencyFormat(product.price)}',
                    style: context.theme.textTheme.headlineSmall
                        ?.copyWith(color: Colours.primary),
                  ),

                  const SizedBox(height: 8),

                  // Ratings & Sold
                  _buildRatingSoldRow(context),

                  const SizedBox(height: 12),

                  // Sizes
                  if (product.sizes != null && product.sizes!.isNotEmpty)
                    _buildSizesSelector(context),

                  const SizedBox(height: 12),

                  // Colors
                  if (product.colors != null && product.colors!.isNotEmpty)
                    _buildColorsSelector(context),

                  const SizedBox(height: 16),

                  // Description
                  _buildDescription(context),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Buttons
      bottomNavigationBar: _buildBottomButtons(context),
    );
  }

  /// IMAGE CAROUSEL
  Widget _buildImageCarousel(BuildContext context) {
    final product = widget.product;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: context.width,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayCurve: Curves.linear,
            autoPlay: true,
            onPageChanged: (index, _) {
              setState(() => _currentImageIndex = index);
            },
          ),
          items: product.images!.map((img) {
            return CachedNetworkImage(
              imageUrl: ApiConfig.baseUrl + img,
              fit: BoxFit.fill,
              width: double.infinity,
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
            );
          }).toList(),
        ),
        // Favourite Icon
        Positioned(
          top: 12,
          right: 12,
          child: InkWell(
            onTap: () {
              context.read<FavouriteProvider>().toggleFavourite(product);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Selector<FavouriteProvider, bool>(
                selector: (_, provider) => provider.isFavourite(product),
                builder: (_, isFavourite, __) {
                  debugPrint('Favourite Icon rebuilding only...');
                  return Icon(
                    isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    size: 24,
                    color: Colours.primary,
                  );
                },
              ),
            ),
          ),
        ),
        // Dots Indicator
        Positioned(
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(product.images!.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentImageIndex == index ? 8 : 6,
                height: _currentImageIndex == index ? 8 : 6,
                decoration: BoxDecoration(
                  color: _currentImageIndex == index
                      ? Colours.primary
                      : Colours.grey500,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  /// RATINGS & SOLD
  Widget _buildRatingSoldRow(BuildContext context) {
    final product = widget.product;
    return Row(
      children: [
        if (product.rating != 0.0)
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                product.rating.toStringAsFixed(1),
                style: context.theme.textTheme.labelMedium,
              ),
            ],
          ),
        if (product.reviews != null) ...[
          const SizedBox(width: 6),
          Text(
            '(${product.reviews!.length.toCompact}) reviews',
            style: context.theme.textTheme.labelSmall
                ?.copyWith(color: Colours.grey600),
          ),
        ],
        if (product.solds != null) ...[
          const SizedBox(width: 8),
          Text(
            '• ${product.solds!.toCompact} sold',
            style: context.theme.textTheme.labelSmall
                ?.copyWith(color: Colours.grey600),
          ),
        ],
      ],
    );
  }

  /// SIZES SELECTOR
  Widget _buildSizesSelector(BuildContext context) {
    final product = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Size', style: context.theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: product.sizes!.map((size) {
            final isSelected = _selectedSize == size;
            return ChoiceChip(
              label: Text(size),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedSize = size),
              selectedColor: Colours.primary,
              labelStyle:
                  TextStyle(color: isSelected ? Colors.white : Colours.grey500),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// COLORS SELECTOR
  Widget _buildColorsSelector(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Color', style: context.theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: product.colors!.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CoreUtils.parseColor(color),
                  border: isSelected
                      ? Border.all(color: Colours.primary, width: 2)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// DESCRIPTION
  Widget _buildDescription(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: context.theme.textTheme.titleSmall),
        const SizedBox(height: 6),
        Text(
          product.description ?? 'No description available.',
          maxLines: _isDescExpanded ? null : 3,
          overflow: TextOverflow.fade,
          style: context.theme.textTheme.bodySmall,
        ),
        if ((product.description?.length ?? 0) > 100)
          InkWell(
            onTap: () => setState(() => _isDescExpanded = !_isDescExpanded),
            child: Text(
              _isDescExpanded ? 'Show Less' : 'Read More',
              style: const TextStyle(color: Colours.primary, fontSize: 12),
            ),
          ),
      ],
    );
  }

  /// BOTTOM BUTTONS
  Widget _buildBottomButtons(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  final product = widget.product;
                  final cartItem = CartItem(
                    id: product.id,
                    name: product.name,
                    imageUrl: product.images?.first ?? '',
                    price: product.price,
                    color: _selectedColor,
                    size: _selectedSize,
                  );
                  context.read<CartProvider>().addToCart(cartItem);
                },
                icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colours.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Buy now
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(color: Colours.grey100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
