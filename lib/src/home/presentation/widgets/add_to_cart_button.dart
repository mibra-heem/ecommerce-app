import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({required this.product, super.key});

  final Product product;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isAdding = false;

  Future<void> _handleAddToCart(BuildContext context) async {
    setState(() => _isAdding = true);

    final product = widget.product;
    context.read<CartProvider>().addToCart(
          CartItem(
            id: product.id,
            name: product.name,
            imageUrl: product.images?.first ?? '',
            price: product.price,
            color: '#000000',
            size: 'Medium',
          ),
        );

    // Snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Product added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            // Navigate to cart screen
          },
        ),
      ),
    );

    setState(() => _isAdding = false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isAdding ? null : () => _handleAddToCart(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _isAdding ? Colors.grey : Colours.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: _isAdding
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
      ),
    );
  }
}
