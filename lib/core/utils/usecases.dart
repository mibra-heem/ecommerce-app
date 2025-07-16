import 'package:ecommerce_app/core/utils/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  RFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  RFuture<Type> call();
}
