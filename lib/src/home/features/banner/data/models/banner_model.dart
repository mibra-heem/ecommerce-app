import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.categoryId,
    required super.image,
  });

  const BannerModel.empty() : super.empty();

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      id: data['id'] as int,
      categoryId: data['category_id'] as int,
      image: data['image'] as String,
    );
  }

  BannerModel copyWith({
    int? id,
    int? categoryId,
    String? image,
  }) {
    return BannerModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'image': image,
    };
  }
}
