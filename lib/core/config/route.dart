class RoutePath{

  const RoutePath._();

  static const initial = '/';
  static const splash = '/splash';
  static const home = '/home';
  static const product = '/product/:slug';
  static const cart = '/cart';
  static const cartView = '/cart-view';
  static const profile = '/profile';
  static const checkout= '/checkout';
  static const address = '/address';
  static const addressCreate = '/address/create';
  static const addressEdit = '/address/:id/edit';
  static const payment= '/payment';
  static const message= '/message';
  static const confirmOrder= '/confirm-order';


  // static String getProduct(String id) => '$product/$id';
}

class RouteName{

  const RouteName._();

  static const initial = 'initial';
  static const splash = 'splash';
  static const home = 'home';
  static const product = 'product';
  static const cart = 'cart';
  static const cartView = 'cart-view';
  static const profile = 'profile';
  static const checkout= 'checkout';
  static const address = 'address';
  static const addressCreate = 'address-create';
  static const addressEdit = 'address-edit';
  static const payment = 'payment';
  static const message= 'message';
  static const confirmOrder = 'confirm-order';

}
