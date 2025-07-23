import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/src/payment/data/datasource/payment_remote_data_src.dart';
import 'package:ecommerce_app/src/payment/domain/repos/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  const PaymentRepoImpl(this._remoteDataSrc);

  final PaymentRemoteDataSrc _remoteDataSrc;

  @override
  RFuture<String> createPaymentIntent(int amount) async {
    try {
      final banners = await _remoteDataSrc.createPaymentIntent(amount);
      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

}
