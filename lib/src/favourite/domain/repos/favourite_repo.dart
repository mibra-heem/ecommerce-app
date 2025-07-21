import 'package:ecommerce_app/core/utils/typedef.dart';

abstract class FavouriteRepo {
  const FavouriteRepo();

  RFuture<int> loadFavouriteData(); 
  RFuture<void> cacheFavouriteData(int index); 

}
