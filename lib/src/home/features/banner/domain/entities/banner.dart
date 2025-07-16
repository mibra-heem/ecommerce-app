import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable{

  const BannerEntity({
    required this.id,
    required this.categoryId,
    required this.image,
  });

  const BannerEntity.empty() : this(
    id: 0,
    categoryId: 1,
    image: 'banner.image',
  );

  final int id;
  final int categoryId;
  final String image;

  @override
  List<Object?> get props => [
    id, categoryId, image,
  ];

  @override
  String toString(){
    return 'Banner{id: $id, categoryId: $categoryId, image : $image}';
  }


}
