import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/src/home/features/banner/domain/entities/banner.dart';

class GetBanners extends UseCaseWithoutParams<List<BannerEntity>>{

  const GetBanners(this._repo);

  final HomeRepo _repo;

  @override
  RFuture<List<BannerEntity>> call() => _repo.getBanners();
  
}
