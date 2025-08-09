import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/payment/domain/usecases/create_payment_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentProvider(this._createPaymentIntent);

  final CreatePaymentIntent _createPaymentIntent;

  PaymentMethods _selectedMethod = PaymentMethods.cod;
  PaymentMethods get selectedMethod => _selectedMethod;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  void selectMethod(PaymentMethods method) {
    _selectedMethod = method;
    notifyListeners();
  }

  Future<void> initPaymentSheet(BuildContext context,
      {required int amount}) async {
    final result = await _createPaymentIntent(amount);

    await result.fold(
      (failure) async {
        debugPrint('Payment Intent Error: ${failure.errorMessage}');
      },
      (clientSecret) async {
        try {
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              customerId: '#12345',
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: 'Mohart',
              // appearance: PaymentSheetAppearance(
              //   colors: PaymentSheetAppearanceColors(
              //     background: context.color.surface,
              //   ),
              //   shapes: const PaymentSheetShape(
              //     borderRadius: 12,
              //   ),
              //   primaryButton: const PaymentSheetPrimaryButtonAppearance(
              //     colors: PaymentSheetPrimaryButtonTheme(
              //       dark: PaymentSheetPrimaryButtonThemeColors(
              //         background: Colours.primary,
              //         text: Colours.white,
              //       ),
              //       light: PaymentSheetPrimaryButtonThemeColors(
              //         background: Colours.primary,
              //         text: Colours.white,
              //       ),
              //     ),
              //   ),
              // ),
            ),
          );

          debugPrint('Payment Sheet Initialized Successfully!');
        } on Exception catch (e) {
          debugPrint('Unexpected Payment error: $e');
        }
      },
    );
  }

  Future<void> makeStripePayment(
    BuildContext context, {
    required int amount,
  }) async {
    _isProcessing = true;
    notifyListeners();

    try {
      await initPaymentSheet(context, amount: amount);
      await Stripe.instance.presentPaymentSheet();

      // ✅ Payment was successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful')),
      );

      // Navigate only after confirmed success
      await context.pushNamed(RouteName.orderPlaced);
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // ❌ Payment was cancelled by user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment cancelled')),
        );
      } else {
        // ❗ Any other payment-related error
        debugPrint('Stripe Error: ${e.error.localizedMessage}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Payment failed: ${e.error.localizedMessage}')),
        );
      }
    } on Exception catch (e) {
      debugPrint('Unexpected Payment Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }
}
