import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig{

  const ApiConfig._();

  // Base URL
  static final baseUrl = dotenv.env['BASE_URL'] ?? 'http://192.168.18.86:8000';
  // static const baseUrl = 'http://192.168.18.86:8000';

  // Auth URLs
  static const registrationUrl = '/api/user/register';
  static const loginUrl = '/api/user/login';

  // Products URLs
  static const productsUrl = '/api/user/products';
  static const bannersUrl = '/api/user/banners';
  static const categoriesUrl = '/api/user/categories';

  // Create Stripe Payment Intent
  static const createPaymentIntent = '/api/create-payment-intent';


}
