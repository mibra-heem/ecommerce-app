import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:ecommerce_app/src/payment/domain/usecases/create_payment_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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

  Future<void> processPayment(int amount) async {
    // Handle COD
    if (_selectedMethod == PaymentMethods.cod) {
      debugPrint('COD selected. Payment will be made on delivery.');
      return;
    }

    await makeStripePayment(amount);
  }

  Future<void> makeStripePayment(int amount) async {
    _isProcessing = true;
    notifyListeners();

    try {
      final result = await _createPaymentIntent(amount);

      await result.fold(
        (failure) async {
          debugPrint('Payment Intent Error: ${failure.errorMessage}');
        },
        (clientSecret) async {
          try {
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: clientSecret,
                merchantDisplayName: 'Mohart',
              ),
            );

            await Stripe.instance.presentPaymentSheet();
            debugPrint('Payment successful!');
          } on StripeException catch (e) {
            debugPrint('Payment cancelled: ${e.error.localizedMessage}');
          } catch (e) {
            debugPrint('Unexpected Payment error: $e');
          }
        },
      );
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }
}
