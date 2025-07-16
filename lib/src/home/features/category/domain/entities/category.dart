import 'package:equatable/equatable.dart';

class Category extends Equatable{

  const Category({
    required this.id,
    required this.name,
    this.image,
  });

  const Category.empty() : this(
    id: 0,
    name: 'category.name',
  );

  final int id;
  final String name;
  final String? image;

  @override
  List<Object?> get props => [
    id, name, image
  ];

  @override
  String toString(){
    return 'Category{id: $id, name: $name, image : $image}';
  }


}
