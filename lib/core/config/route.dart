class RoutePath{

  const RoutePath._();

  static const initial = '/';
  static const splash = '/splash';
  static const home = '/home';
  static const product = '/product/:id';
  static const cart = '/cart';
  static const profile = '/profile';
  static const checkout= '/checkout';
  static const address = '/address';
  static const payment= '/payment';

  static String getProduct(String id) => '$product/$id';
}

class RouteName{

  const RouteName._();

  static const initial = 'initial';
  static const splash = 'splash';
  static const home = 'home';
  static const product = 'product';
  static const cart = 'cart';
  static const profile = 'profile';
  static const checkout= 'checkout';
  static const address = 'address';
  static const payment= 'payment';

}
