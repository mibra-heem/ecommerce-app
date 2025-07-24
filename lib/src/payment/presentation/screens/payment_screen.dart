import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/payment/presentation/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();
    final selected = provider.selectedMethod;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _buildOption(
          context,
          title: 'Cash on Delivery',
          value: PaymentMethods.cod,
          selected: selected,
        ),
        const SizedBox(height: 15),
        _buildOption(
          context,
          title: 'Credit / Debit Card (Stripe)',
          value: PaymentMethods.stripe,
          selected: selected,
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required PaymentMethods value,
    required PaymentMethods selected,
  }) {
    return InkWell(
      onTap: () => context.read<PaymentProvider>().selectMethod(value),
      // borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(
            value == PaymentMethods.cod
                ? Icons.money_rounded
                : FontAwesomeIcons.stripe,
            color: Colours.primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          // if (value == selected)
          Icon(
            FontAwesomeIcons.circleDot,
            size: 18,
            color: value == selected ? Colours.primary : Colours.disable,
          ),
        ],
      ),
    );
  }
}
