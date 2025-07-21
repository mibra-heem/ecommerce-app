import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable{
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    this.icon,
    this.order = 0,
  });

  const CategoryEntity.empty() : this(
    id: 0,
    name: 'category.name',
    slug: 'category.slug',
  );

  final int id;
  final String name;
  final String slug;
  final int? parentId;
  final String? icon;
  final int order;

  @override
  List<Object?> get props => [
    id, name, slug, icon, parentId, order,
  ];

  @override
  String toString(){
    return 'Category{id: $id, name: $name, slug: $slug, icon : $icon, '
    'parent_id: $parentId, order: $order}';
  }


}
