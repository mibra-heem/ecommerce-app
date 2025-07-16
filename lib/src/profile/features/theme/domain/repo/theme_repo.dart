import 'package:ecommerce_app/core/utils/typedef.dart';

abstract class ThemeRepo {
  const ThemeRepo();

  RFuture<int> loadThemeMode(); 
  RFuture<void> cacheThemeMode(int index); 

}
