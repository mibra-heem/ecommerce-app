import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/favourite/domain/repos/favourite_repo.dart';

class CacheFavouriteData extends UseCaseWithParams<void, int>{

  const CacheFavouriteData(this._repo);

  final FavouriteRepo _repo;

  @override
  RFuture<void> call(int index) => _repo.cacheFavouriteData(index);
}
