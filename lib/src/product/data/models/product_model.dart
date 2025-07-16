import 'package:ecommerce_app/src/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.image,
    super.description,
  });

  const ProductModel.empty() : super.empty();

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] as String,
      name: data['name'] as String,
      price: data['price'] as int ,
      image: data['image'] as String?,
      description: data['description'] as String?,
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    String? image,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
    };
  }
}
