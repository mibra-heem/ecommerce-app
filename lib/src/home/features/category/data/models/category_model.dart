import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.image,
  });

  const CategoryModel.empty() : super.empty();

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'] as int,
      name: data['name'] as String,
      image: data['image'] as String?,
    );
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
