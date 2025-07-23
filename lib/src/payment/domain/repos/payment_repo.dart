import 'package:ecommerce_app/core/utils/typedef.dart';

abstract class PaymentRepo {
  const PaymentRepo();

  RFuture<String> createPaymentIntent(int amount);

}
