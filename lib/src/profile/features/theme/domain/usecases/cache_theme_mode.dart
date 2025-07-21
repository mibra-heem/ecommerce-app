import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/profile/features/theme/domain/repo/theme_repo.dart';

class CacheThemeMode extends UseCaseWithParams<void, int>{

  const CacheThemeMode(this._repo);

  final ThemeRepo _repo;

  @override
  RFuture<void> call(int index) => _repo.cacheThemeMode(index);
}
