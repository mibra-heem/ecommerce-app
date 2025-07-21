import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/favourite/domain/repos/favourite_repo.dart';

class LoadFavouriteData extends UseCaseWithoutParams<int>{

  const LoadFavouriteData(this._repo);

  final FavouriteRepo _repo;

  @override
  RFuture<int> call() => _repo.loadFavouriteData();
}
