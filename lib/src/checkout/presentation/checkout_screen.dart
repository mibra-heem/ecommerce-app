import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ADDRESS SECTION
                      _buildAddressSection(context, addressProvider),

                      const SizedBox(height: 20),

                      /// CART SUMMARY
                      _buildCartSummary(context, cartProvider),

                      const Spacer(),
                      const SizedBox(height: 20),

                      /// ORDER SUMMARY (Subtotal, Shipping, Total)
                      _buildOrderSummary(context, cartProvider),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50, // or 56 / 60 as needed
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: addressProvider.hasAddress
                ? () => context.pushNamed(RouteName.payment)
                : null,
            child: const Text(
              'Proceed to Payment',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  /// Address Section
  Widget _buildAddressSection(BuildContext context, AddressProvider provider) {
    debugPrint('${provider.addresses}');
    return GestureDetector(
      onTap: () {
        if (provider.hasAddress) {
          // Navigate to AddressSelectionScreen
          context.pushNamed(RouteName.address);
        } else {
          // Navigate to AddAddressScreen
          context.pushNamed(RouteName.addressCreate);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.isDarkMode ? Colours.grey900 : Colours.grey100,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, color: Colours.primary),
            const SizedBox(width: 10),
            Expanded(
              child: provider.hasAddress
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.defaultAddress?.name ?? '',
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          provider.defaultAddress?.fullAddress ?? '',
                          style: context.theme.textTheme.bodySmall,
                        ),
                      ],
                    )
                  : Text(
                      'No Address Found. Tap to Add.',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: Colours.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colours.grey600,
            ),
          ],
        ),
      ),
    );
  }

  /// Cart Summary
  Widget _buildCartSummary(BuildContext context, CartProvider cartProvider) {
    final cartItems = cartProvider.items.values.toList();
    final visibleItems = _isExpanded ? cartItems : cartItems.take(2).toList();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.isDarkMode ? Colours.grey900 : Colours.grey100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart Summary',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (cartItems.length > 2)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(_isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  label: Text(_isExpanded ? 'Show Less' : 'View All'),
                ),
            ],
          ),
          const SizedBox(height: 10),
          ...visibleItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: ApiConfig.baseUrl + item.imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    'x${item.quantity}',
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      color: Colours.grey600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Order Summary (Subtotal, Shipping, Total)
  Widget _buildOrderSummary(BuildContext context, CartProvider cartProvider) {
    final subtotal = cartProvider.subtotal;
    const shipping = 200; // Example fixed shipping cost
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.isDarkMode ? Colours.grey900 : Colours.grey100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Shipping', shipping),
          const Divider(height: 16, thickness: 1),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, num price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          'Rs. ${CoreUtils.currencyFormat(price)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colours.primary : Colours.grey800,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
