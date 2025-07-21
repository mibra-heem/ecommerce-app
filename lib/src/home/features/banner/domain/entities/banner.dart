import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  const BannerEntity({
    required this.id,
    required this.image,
    this.link,
    this.order = 0,
  });

  const BannerEntity.empty()
      : this(
          id: 0,
          image: 'banner.image',
        );

  final int id;
  final String image;
  final String? link;
  final int order;

  @override
  List<Object?> get props => [
        id,
        image,
        link,
        order,
      ];

  @override
  String toString() {
    return 'Banner{id: $id, image : $image, link: $link, order: $order}';
  }
}
