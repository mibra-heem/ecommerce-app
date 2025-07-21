// ignore_for_file: document_ignores

import 'package:equatable/equatable.dart';

/// ignore: must_be_immutable
class CartItem extends Equatable {
  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.color,
    this.size,
    this.material,
    this.quantity = 1,
  });

  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String? color;
  final String? size;
  final String? material;
  int quantity;

  // A unique key for each variant
  String get uniqueKey => "$id-${color ?? ''}-${size ?? ''}-${material ?? ''}";

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        price,
        color,
        size,
        material,
        quantity,
      ];

    @override
  String toString() {
    return 'CartItem{id: $id, name: $name, price : $price, imageUrl: '
        '$imageUrl, size: $size, color : $color, quantity: $quantity}';
  }
}
