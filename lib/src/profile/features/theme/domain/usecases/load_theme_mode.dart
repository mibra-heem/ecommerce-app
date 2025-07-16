import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/profile/features/theme/domain/repo/theme_repo.dart';

class LoadThemeMode extends UseCaseWithoutParams<int>{

  const LoadThemeMode(this._repo);

  final ThemeRepo _repo;

  @override
  RFuture<int> call() => _repo.loadThemeMode();
}
