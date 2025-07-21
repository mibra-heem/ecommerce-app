import 'package:ecommerce_app/src/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel(
      {required super.id,
      required super.name,
      required super.imageUrl,
      required super.price,
    });
}
