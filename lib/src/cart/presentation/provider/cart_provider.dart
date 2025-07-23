import 'package:ecommerce_app/src/cart/domain/entities/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  /// Total items count
  int get totalItems =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  /// Total cart price
  double get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));

  /// Subtotal (alias of totalPrice for clarity)
  double get subtotal => totalPrice;

  /// Add a product to the cart
  void addToCart(CartItem newItem) {
    final key = newItem.uniqueKey;
    if (_items.containsKey(key)) {
      _items[key]!.quantity += newItem.quantity;
    } else {
      _items[key] = newItem;
    }
    notifyListeners();
    debugPrint('CartItems From Cart Provider =>  $items');
  }

  /// Remove a product completely
  void removeFromCart(String uniqueKey) {
    _items.remove(uniqueKey);
    notifyListeners();
  }

  /// Increase quantity of a specific item
  void increment(String uniqueKey) {
    if (_items.containsKey(uniqueKey)) {
      _items[uniqueKey]!.quantity++;
      notifyListeners();
    }
  }

  /// Decrease quantity of a specific item
  void decrement(String uniqueKey) {
    if (_items.containsKey(uniqueKey) && _items[uniqueKey]!.quantity > 1) {
      _items[uniqueKey]!.quantity--;
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
