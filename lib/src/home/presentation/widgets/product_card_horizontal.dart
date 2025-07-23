import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/extensions/int_extension.dart';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:ecommerce_app/src/favourite/presentation/provider/favourite_provider.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.width * .36;

    final imageUrl = (product.images != null && product.images!.isNotEmpty)
        ? ApiConfig.baseUrl + product.images!.first
        : 'https://via.placeholder.com/150';

    return Container(
      width: context.width * .7,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image with Favourite button
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(14)),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      RouteName.product,
                      pathParameters: {'slug': product.slug},
                      extra: product,
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: cardHeight,
                    height: cardHeight,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (_, __, ___) => const ColoredBox(
                      color: Colours.grey300,
                      child: Icon(Icons.broken_image, color: Colours.grey600),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    context.read<FavouriteProvider>().toggleFavourite(product);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
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
                          size: 18,
                          color: Colours.primary,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product Details (with spaceBetween)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOP SECTION
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.brand != null && product.brand!.isNotEmpty)
                        Text(
                          product.brand!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            color: Colours.grey600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs. ${CoreUtils.currencyFormat(product.price)}',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: Colours.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (product.rating != 0.0 || product.reviews != null)
                        Row(
                          children: [
                            if (product.rating != 0.0) ...[
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: context.theme.textTheme.labelSmall,
                              ),
                            ],
                            if (product.reviews != null)
                              Text(
                                ' (${product.reviews!.length.toCompact})',
                                style: context.theme.textTheme.labelSmall
                                    ?.copyWith(color: Colours.grey600),
                              ),
                            if (product.solds != null) ...[
                              const Spacer(),
                              Text(
                                '${product.solds!.toCompact} sold',
                                style: context.theme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: Colours.grey600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),

                  // BOTTOM SECTION (Add-to-Cart)
                  Align(
                    alignment: Alignment.centerRight,
                    child: AddToCartButton(product: product),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
