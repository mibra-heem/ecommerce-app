import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPaymentOption(
              context,
              icon: Icons.money,
              label: 'Cash on Delivery (COD)',
              value: PaymentMethods.cod,
              selected: provider.selectedMethod == PaymentMethods.cod,
              onSelect: () => provider.selectMethod(PaymentMethods.cod),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              context,
              icon: Icons.credit_card,
              label: 'Credit/Debit Card (Stripe)',
              value: PaymentMethods.stripe,
              selected: provider.selectedMethod == PaymentMethods.stripe,
              onSelect: () => provider.selectMethod(PaymentMethods.stripe),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              context,
              icon: Icons.account_balance_wallet,
              label: 'PayPal',
              value: PaymentMethods.paypal,
              selected: provider.selectedMethod == PaymentMethods.paypal,
              onSelect: () => provider.selectMethod(PaymentMethods.paypal),
            ),
            const Spacer(),

            // Confirm button
            ElevatedButton(
              onPressed: provider.isProcessing
                  ? null
                  : () async {
                      if (provider.selectedMethod == PaymentMethods.stripe) {
                        // You may fetch cart total dynamically here
                        const totalAmount =
                            1000; // Amount in PKR, convert in backend
                        await provider.processPayment(totalAmount);
                      }

                      // Navigate to confirm order screen
                      if (!provider.isProcessing) {
                        await context.pushNamed(RouteName.confirmOrder);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: provider.isProcessing
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Confirm & Continue',
                        style: TextStyle(
                          fontSize: 16,
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

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required PaymentMethods value,
    required bool selected,
    required VoidCallback onSelect,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? Colours.primary.withAlpha(25)
              : (context.isDarkMode ? Colours.grey900 : Colours.grey100),
          border: Border.all(
            color: selected ? Colours.primary : Colours.grey300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colours.primary : Colours.grey600),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Radio<PaymentMethods>(
              value: value,
              groupValue: context.read<PaymentProvider>().selectedMethod,
              onChanged: (_) => onSelect(),
              activeColor: Colours.primary,
            ),
          ],
        ),
      ),
    );
  }
}
