import 'package:ecommerce_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Product> _favourites = [];

  List<Product> get favourites => List.unmodifiable(_favourites);

  bool isFavourite(Product product) {
    return _favourites.any((p) => p.id == product.id);
  }

  void toggleFavourite(Product product) {
    if (isFavourite(product)) {
      _favourites.removeWhere((p) => p.id == product.id);
    } else {
      _favourites.add(product);
    }
    debugPrint('Favourites => $_favourites');
    notifyListeners();
  }
}
