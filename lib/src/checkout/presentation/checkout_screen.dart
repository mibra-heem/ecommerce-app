import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/app/views/loading_view.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:ecommerce_app/core/widgets/my_field.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:ecommerce_app/src/payment/presentation/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isExpanded = false;
  final _couponController = TextEditingController();
  final _couponFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _couponController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final paymentProvider = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
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

                      const SizedBox(height: 20),

                      /// ORDER SUMMARY (Subtotal, Shipping, Total)
                      _buildOrderSummary(context, cartProvider),

                      const SizedBox(height: 20),

                      /// Add Coupon CODE
                      _buildPaymentOptions(context, paymentProvider),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: context.color.surfaceContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            _buildSummaryRow(
              'Total',
              cartProvider.subtotal + 200,
              isTotal: true,
            ),
            Consumer<PaymentProvider>(
              builder: (context, provider, _) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primary,
                      disabledBackgroundColor: Colours.disable,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: !addressProvider.hasAddress
                        ? null
                        : provider.isProcessing
                            ? null
                            : () async {
                                switch (provider.selectedMethod) {
                                  case PaymentMethods.stripe:
                                    await provider.makeStripePayment(
                                      context,
                                      amount:
                                          (cartProvider.subtotal.toInt() + 10) *
                                              100,
                                    );
                                  case PaymentMethods.cod:
                                    await context
                                        .pushNamed(RouteName.orderPlaced);
                                  case PaymentMethods.paypal:
                                    await context
                                        .pushNamed(RouteName.orderPlaced);
                                }
                                _placeOrder(context);
                              },
                    child: provider.isProcessing
                        ? const LoadingView()
                        : const Center(
                            child: Text(
                              'Place Order',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colours.white,
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Address Section
  Widget _buildAddressSection(BuildContext context, AddressProvider provider) {
    debugPrint('${provider.addresses}');
    return GestureDetector(
      onTap: () async {
        if (provider.hasAddress) {
          // Navigate to AddressSelectionScreen
          await context.pushNamed(RouteName.address);
          debugPrint('back at checkout screen');
        } else {
          // Navigate to AddAddressScreen
          await context.pushNamed(RouteName.addressCreate);
        }
        _couponFocusNode.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.color.surfaceContainer,
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
        color: context.color.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                IconlyBold.bag,
                color: Colours.primary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Cart Summary',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (cartItems.length > 2)
                TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact),
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
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
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
    const shipping = 10; // Example fixed shipping cost

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.color.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5,
            children: [
              const Icon(
                Icons.receipt_long,
                color: Colours.primary,
              ),
              Text(
                'Order Summary',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Shipping', shipping),
          const Divider(height: 20, thickness: 1),

          _buildCouponCode(),
          // _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, num price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: isTotal
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        if (isTotal)
          const SizedBox(
            width: 15,
          ),
        Text(
          '\$${CoreUtils.currencyFormat(price)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colours.primary : Colours.grey500,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }

  /// Coupon Code
  Widget _buildCouponCode() {
    return Container(
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: context.color.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: MyField(
              controller: _couponController,
              hintText: 'Enter Coupon Code',
              fillColor: context.color.surface,
              focusNode: _couponFocusNode,
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // apply Coupon code logic
            },
            child: const Text(
              'Apply',
              style: TextStyle(color: Colours.primary),
            ),
          )
        ],
      ),
    );
  }

  /// Select Payment Options
  Widget _buildPaymentOptions(BuildContext context, PaymentProvider provider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.color.surfaceContainer,
      ),
      child: const PaymentMethodSelector(),
    );
  }

  void _placeOrder(BuildContext context) {
    // TODO: Call API or handle order placement logic here.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );

    // Clear cart after placing the order
    context.read<CartProvider>().clearCart();
    Navigator.of(context).popUntil((route) => route.isFirst);

    debugPrint('Order Placed & Cart is Empty. . . . . . . . . . .');
  }
}
