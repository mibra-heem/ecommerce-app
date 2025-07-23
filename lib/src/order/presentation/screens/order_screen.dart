import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final paymentProvider = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSectionTitle('Delivery Address'),
            const SizedBox(height: 8),
            _buildAddress(addressProvider),
            const Divider(height: 30),
            _buildSectionTitle('Cart Items'),
            const SizedBox(height: 8),
            ...cartProvider.items.values.map((item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(ApiConfig.baseUrl + item.imageUrl, width: 50, height: 50),
                  ),
                  title: Text(item.name),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Text('Rs. ${item.price * item.quantity}'),
                )),
            const Divider(height: 30),
            _buildSectionTitle('Payment Method'),
            const SizedBox(height: 8),
            Text(
              paymentProvider.selectedMethod.name.toUpperCase(),
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 30),
            _buildSectionTitle('Order Summary'),
            const SizedBox(height: 8),
            _buildOrderSummary(cartProvider),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _placeOrder(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildOrderSummary(CartProvider cartProvider) {
    final subtotal = cartProvider.subtotal;
    const shipping = 200.0;
    final total = subtotal + shipping;

    return Column(
      children: [
        _summaryRow('Subtotal', subtotal),
        const SizedBox(height: 8),
        _summaryRow('Shipping', shipping),
        const Divider(height: 16, thickness: 1),
        _summaryRow('Total', total, isTotal: true),
      ],
    );
  }

  Widget _summaryRow(String label, double price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(
          'Rs. ${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colours.primary : Colours.grey800,
          ),
        ),
      ],
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
  }
}
