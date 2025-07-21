import 'package:ecommerce_app/src/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.categoryId,
    super.brand,
    super.rating,
    super.description,
    super.images,
    super.colors,
    super.sizes,
    super.materials,
    super.reviews,
    super.solds,
  });

  const ProductModel.empty() : super.empty();

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] as String,
      name: data['name'] as String,
      price: data['price'] as int,
      categoryId: data['category_id'] as int,
      brand: data['brand'] as String?,
      rating: data['rating'].runtimeType is int ? 5.0 : 4.0,
      description: data['description'] as String?,
      images: data['image_urls'] != null
          ? List<String>.from(data['image_urls'] as List<dynamic>)
          : null,
      colors: data['colors'] != null
          ? List<String>.from(data['colors'] as List<dynamic>)
          : null,
      sizes: data['sizes'] != null
          ? List<String>.from(data['sizes'] as List<dynamic>)
          : null,
      materials: data['materials'] != null
          ? List<String>.from(data['materials'] as List<dynamic>)
          : null,
      reviews: data['reviews'] != null
          ? List<String>.from(data['reviews'] as List<dynamic>)
          : null,
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    int? categoryId,
    String? brand,
    double? rating,
    String? description,
    List<String>? images,
    List<String>? colors,
    List<String>? sizes,
    List<String>? materials,
    List<String>? reviews,
    int? solds,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      materials: materials ?? this.materials,
      reviews: reviews ?? this.reviews,
      solds: solds ?? this.solds,
    );
  }

  // No need of this on user side
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'images': images,
      'description': description,
    };
  }
}
