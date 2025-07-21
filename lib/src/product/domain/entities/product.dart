import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    this.description,
    this.brand,
    this.rating = 0.0,
    this.images,
    this.colors,
    this.sizes,
    this.materials,
    this.reviews,
    this.solds,
  });

  const Product.empty()
      : this(
          id: 'product.id',
          name: 'product.name',
          categoryId: 0,
          price: 0,
        );

  final String id;
  final String name;
  final int price;
  final int categoryId;
  final double rating;
  final String? brand;
  final String? description;
  final List<String>? images;
  final List<String>? sizes;
  final List<String>? colors;
  final List<String>? materials;
  final List<String>? reviews;
  final int? solds;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        categoryId,
        images,
        description,
      ];

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price : $price, categoryId: '
        '$categoryId, image_urls: $images, description : $description}';
  }
}
