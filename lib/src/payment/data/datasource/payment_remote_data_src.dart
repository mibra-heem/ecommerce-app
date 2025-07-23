import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/services/api_service.dart';
import 'package:flutter/material.dart';

abstract class PaymentRemoteDataSrc {
  const PaymentRemoteDataSrc();

  Future<String> createPaymentIntent(int amount);

}

class PaymentRemoteDataSrcImpl implements PaymentRemoteDataSrc {
  const PaymentRemoteDataSrcImpl(ApiService apiService)
      : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<String> createPaymentIntent(int amount) async {
    try {
      final data = await _apiService.post(
        url: ApiConfig.createPaymentIntent,
        body: {'amount': amount, 'currency': 'usd'},
      );

      debugPrint('Create Payment Intent Data : $data ');

      return data['clientSecret'] as String;
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
