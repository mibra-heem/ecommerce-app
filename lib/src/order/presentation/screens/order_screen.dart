import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId; // Pass order ID from previous screen

  const OrderSuccessScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final paymentProvider = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        automaticallyImplyLeading: false, // Prevent back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Header
            _buildSuccessHeader(context),
            const SizedBox(height: 24),
            // Delivery Address
            _buildSectionCard(
              title: 'Delivery Address',
              child: _buildAddress(addressProvider),
            ),
            const SizedBox(height: 16),
            // Cart Items
            _buildSectionCard(
              title: 'Cart Items',
              child: Column(
                children: cartProvider.items.values.map((item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      ApiConfig.baseUrl + item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/placeholder.png',
                        width: 50,
                        height: 50,
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SpinKitFadingCircle(
                          color: Colours.primary,
                          size: 30,
                        );
                      },
                    ),
                  ),
                  title: Text(item.name, style: context.theme.textTheme.titleMedium),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Text(
                    'Rs. ${(item.price * item.quantity).toStringAsFixed(0)}',
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Payment Method
            _buildSectionCard(
              title: 'Payment Method',
              child: Text(
                paymentProvider.selectedMethod.name.toUpperCase(),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colours.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Order Summary
            _buildSectionCard(
              title: 'Order Summary',
              child: _buildOrderSummary(cartProvider),
            ),
            const SizedBox(height: 24),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _downloadReceipt(context, orderId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.grey200,
                      foregroundColor: Colours.grey800,
                    ),
                    child: const Text('Download Receipt'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.primary,
                    ),
                    child: const Text('Continue Shopping'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/order-details', arguments: orderId),
                child: const Text(
                  'Track Order',
                  style: TextStyle(
                    color: Colours.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colours.primary,
            size: 80,
          ),
          const SizedBox(height: 8),
          Text(
            'Order Placed Successfully!',
            style: context.theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colours.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Order ID: $orderId',
            style: context.theme.textTheme.titleMedium?.copyWith(
              color: Colours.grey800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colours.grey800,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildAddress(AddressProvider provider) {
    if (!provider.hasAddress) {
      return const Text('No address selected', style: TextStyle(color: Colours.grey600));
    }
    final address = provider.defaultAddress!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.recipientName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
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
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          'Rs. ${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
            color: isTotal ? Colours.primary : Colours.grey800,
          ),
        ),
      ],
    );
  }

  Future<void> _downloadReceipt(BuildContext context, String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/orders/$orderId/receipt'),
        headers: {'Authorization': 'Bearer your-auth-token'}, // Replace with actual token
      );

      if (response.statusCode == 200) {
        // Handle receipt download (e.g., save to device or open as PDF)
        // For simplicity, show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt downloaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download receipt')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error downloading receipt')),
      );
    }
  }
}