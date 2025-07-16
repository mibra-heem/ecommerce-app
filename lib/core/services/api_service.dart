import 'dart:convert';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiService {
  Future<DMap> get({required String url, String? serverAccessToken});
  Future<DMap> post({
    required String url,
    required DMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  });
}

class ApiService implements BaseApiService {
  const ApiService({required String baseUrl}) : _baseUrl = baseUrl;

  final String _baseUrl;

  @override
  Future<DMap> get({
    required String url,
    String? serverAccessToken,
  }) async {
    final uri = Uri.parse(_baseUrl + url);

    debugPrint('uri => $_baseUrl$url');


    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint('Request was successfull.');

        return jsonDecode(response.body) as DMap;
      } else {
        throw ServerException(
          message: 'GET request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<DMap> post({
    required String url,
    required DMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final res = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (res.statusCode == 200) {
        debugPrint('Notification Sent Successfully.');
        return jsonDecode(res.body) as DMap;
      }

      return {'message': 'No Data found.', 'statusCode': res.statusCode};
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
