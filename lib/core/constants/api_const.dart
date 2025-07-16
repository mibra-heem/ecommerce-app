
class ApiConst{

  const ApiConst._();

  // Base URL
  // static final baseUrl = dotenv.env['BASE_URL'] ?? 'http://192.168.18.86:8000';
  static const baseUrl = 'http://192.168.18.86:8000';


  // Auth URLs
  static const registrationUrl = '/api/register';
  static const loginUrl = '/api/login';

  // Products URLs
  static const productsUrl = '/api/products';
  static const bannersUrl = '/api/banners';
  static const categoriesUrl = '/api/categories';

}
