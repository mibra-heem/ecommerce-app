import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/order/presentation/screens/pdf_generator.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final paymentProvider = context.watch<PaymentProvider>();

    final subtotal = cartProvider.subtotal;
    const shipping = 10.0;
    final total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colours.success,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Thank you for your order!',
                style: context.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Delivery Address',
              icon: Icons.location_on,
              child: _buildAddress(addressProvider),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Cart Items',
              icon: Icons.shopping_bag,
              context: context,
              child: Column(
                children: cartProvider.items.values.map((item) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        ApiConfig.baseUrl + item.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(item.name),
                    subtitle: Text('x${item.quantity}'),
                    trailing: Text('\$${item.price * item.quantity}'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Payment Method',
              context: context,
              icon: Icons.payment_outlined,
              child: Text(
                paymentProvider.selectedMethod.name.toUpperCase(),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Order Summary',
              context: context,
              icon: Icons.receipt_long,
              child: Column(
                children: [
                  _summaryRow('Subtotal', subtotal),
                  const SizedBox(height: 8),
                  _summaryRow('Shipping', shipping),
                  const Divider(thickness: 1, height: 24),
                  _summaryRow('Total', total, isTotal: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                final pdfBytes =
                    await OrderPDFGenerator.generateOrderReceiptPdf(
                  recipientName:
                      addressProvider.defaultAddress?.recipientName ?? '',
                  address: '${addressProvider.defaultAddress?.fullAddress}',
                  paymentMethod: paymentProvider.selectedMethod.name,
                  subtotal: cartProvider.subtotal,
                  shipping: 200,
                  total: cartProvider.subtotal + 10,
                  items: cartProvider.items.values.map((item) {
                    return {
                      'name': item.name,
                      'quantity': item.quantity,
                      'total': item.quantity * item.price,
                    };
                  }).toList(),
                );

                context.pushNamed(RouteName.viewOrderReceipt, extra: pdfBytes);
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Download Receipt as PDF'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.color.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colours.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildAddress(AddressProvider provider) {
    if (!provider.hasAddress) {
      return const Text('No address selected');
    }
    final address = provider.defaultAddress!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(address.recipientName,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('${address.street}, ${address.city}, ${address.state}'),
        Text('Zip: ${address.postalCode}, ${address.country}'),
        Text('Phone: ${address.phone}'),
      ],
    );
  }

  Widget _summaryRow(String label, double price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          '\$${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colours.primary : Colours.grey800,
          ),
        ),
      ],
    );
  }
}
