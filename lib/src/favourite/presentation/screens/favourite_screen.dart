import 'package:ecommerce_app/src/favourite/presentation/provider/favourite_provider.dart';
import 'package:ecommerce_app/src/home/presentation/widgets/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favourites = context.watch<FavouriteProvider>().favourites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: favourites.isEmpty
          ? const Center(
              child: Text(
                'No favourite products yet.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : MasonryGridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final product = favourites[index];
                return ProductCardVertical(
                  product: product,
                ); // Reuse your product widget
              },
            ),
    );
  }
}
