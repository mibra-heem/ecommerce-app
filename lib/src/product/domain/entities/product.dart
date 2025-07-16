import 'package:equatable/equatable.dart';

class Product extends Equatable{

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
  });

  const Product.empty() : this(
    id: 'product.id',
    name: 'product.name',
    price: 0,
  );

  final String id;
  final String name;
  final int price;
  final String? image;
  final String? description;

  @override
  List<Object?> get props => [
    id, name, price, image, description,
  ];

  @override
  String toString(){
    return 'Product{id: $id, name: $name, price : $price, image: $image, ' 
    'description : $description}';
  }


}
