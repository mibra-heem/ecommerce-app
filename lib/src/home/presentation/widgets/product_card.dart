import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:ecommerce_app/core/resources/media.dart';
import 'package:ecommerce_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.name,
    required this.price,
    required this.imageUrl,
    super.key,
  });

  final String name;
  final int price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        // decoration: BoxDecoration(
        // color: Colors.amber, borderRadius: BorderRadius.circular(20)),
        width: context.width * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: context.width * 0.35,
                width: context.width * 0.35,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) {
                  return const Image(image: AssetImage(Media.defaultShoeImage));
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    name,
                    maxLines: 2,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Rs.',
                    style: context.theme.textTheme.labelMedium
                        ?.copyWith(color: Colours.primaryLight, fontSize: 12),
                    children: [
                      TextSpan(
                        text: '$price',
                        style: context.theme.textTheme.labelMedium
                            ?.copyWith(color: Colours.primaryLight),
                      ),
                    ],
                  ),
                ),
                Text('Wearium', style: context.theme.textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
