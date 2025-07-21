import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/extensions/int_extension.dart';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.brand,
    this.rating,
    this.reviews,
    this.sold,
    super.key,
  });

  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final String? brand;
  final double? rating;
  final int? reviews;
  final int? sold;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image + Favourite
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: context.width * 0.45,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (_, __, ___) => Container(
                    color: Colours.grey300,
                    child:
                        const Icon(Icons.broken_image, color: Colours.grey600),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    // Add to favourites
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 18, color: Colours.primary),
                  ),
                ),
              ),
            ],
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (brand != null && brand!.isNotEmpty)
                  Text(
                    brand!,
                    style: context.theme.textTheme.labelSmall
                        ?.copyWith(color: Colours.grey600),
                  ),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs. ${CoreUtils.currencyFormat(price)}',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: Colours.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Rating & Reviews
                if (rating != null || reviews != null)
                  Row(
                    children: [
                      if (rating != null)
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                      if (rating != null) const SizedBox(width: 2),
                      if (rating != null)
                        Text(
                          rating!.toStringAsFixed(1),
                          style: context.theme.textTheme.labelSmall,
                        ),
                      if (reviews != null)
                        Text(
                          ' (${reviews!.toCompact})',
                          style: context.theme.textTheme.labelSmall
                              ?.copyWith(color: Colours.grey600),
                        ),
                    ],
                  ),
                if (sold != null)
                  Text(
                    '${sold!.toCompact} sold',
                    style: context.theme.textTheme.labelSmall
                        ?.copyWith(color: Colours.grey600, fontSize: 11),
                  ),
                const SizedBox(height: 6),

                // Add-to-Cart
                const Align(
                  alignment: Alignment.centerRight,
                  child: AddToCartButton(product: Product.empty()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
