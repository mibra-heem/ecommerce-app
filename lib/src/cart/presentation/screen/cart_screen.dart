import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final key = cart.items.keys.elementAt(index);
                    final item = cart.items[key]!;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colours.grey900
                            : Colours.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: ApiConfig.baseUrl + item.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                              errorWidget: (_, __, ___) => const ColoredBox(
                                color: Colours.grey300,
                                child: Icon(Icons.broken_image,
                                    color: Colours.grey600,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.textTheme.titleMedium,
                                ),
                                if (item.color != null || item.size != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      '${item.color ?? ''} ${item.size != null ? ' | ${item.size}' : ''}',
                                      style: context.theme.textTheme.labelSmall
                                          ?.copyWith(color: Colours.grey600),
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rs. ${item.price}',
                                  style: context.theme.textTheme.titleSmall
                                      ?.copyWith(
                                    color: Colours.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Quantity Controls
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cart.decrement(item.uniqueKey);
                                    },
                                    icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colours.primary),
                                  ),
                                  Text('${item.quantity}',
                                      style:
                                          context.theme.textTheme.bodyMedium),
                                  IconButton(
                                    onPressed: () {
                                      cart.increment(item.uniqueKey);
                                    },
                                    icon: const Icon(Icons.add_circle_outline,
                                        color: Colours.primary),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () =>
                                    cart.removeFromCart(item.uniqueKey),
                                child: Text(
                                  'Remove',
                                  style: context.theme.textTheme.labelSmall
                                      ?.copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Cart Summary
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colours.grey900
                      : Colours.grey100.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text(
                          'Rs. ${cart.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colours.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Handle checkout flow
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
