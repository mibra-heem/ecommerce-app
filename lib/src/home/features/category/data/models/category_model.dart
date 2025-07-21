import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.icon,
    super.parentId,
    super.order,
  });

  const CategoryModel.empty() : super.empty();

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'] as int,
      name: data['name'] as String,
      slug: data['slug'] as String,
      icon: data['icon_url'] as String?,
      parentId: data['parent_id'] as int?,
      order: data['order'] as int,
    );
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? parentId,
    String? icon,
    int? order,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      parentId: parentId ?? this.parentId,
      order: order ?? this.order,
    );
  }

  // No need for this
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug' : slug,
      'icon': icon,
      'parent_id': parentId,
      'order': order
    };
  }
}
