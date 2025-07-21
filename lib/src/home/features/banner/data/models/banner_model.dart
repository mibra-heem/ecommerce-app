import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.image,
    super.link,
    super.order,
  });

  const BannerModel.empty() : super.empty();

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      id: data['id'] as int,
      image: data['image_url'] as String,
      link: data['link'] as String?,
      order: data['order'] as int,
    );
  }

  BannerModel copyWith({
    int? id,
    String? image,
    String? link,
    int? order,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      link: link ?? this.link,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': image,
      'link': link,
      'order': order,
    };
  }
}
