import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/payment/domain/repos/payment_repo.dart';

class CreatePaymentIntent extends UseCaseWithParams<String, int>{

  const CreatePaymentIntent(this._repo);

  final PaymentRepo _repo;

  @override
  RFuture<String> call(int amount) => _repo.createPaymentIntent(amount);
  
}
