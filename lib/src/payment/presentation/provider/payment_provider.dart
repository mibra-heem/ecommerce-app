import 'package:ecommerce_app/core/enums/payment_method.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentMethod _selectedMethod = PaymentMethod.cod;

  PaymentMethod get selectedMethod => _selectedMethod;

  void selectMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }
}
