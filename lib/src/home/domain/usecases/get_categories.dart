import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/src/home/features/category/domain/entities/category.dart';

class GetCategories extends UseCaseWithoutParams<List<Category>>{

  const GetCategories(this._repo);

  final HomeRepo _repo;

  @override
  RFuture<List<Category>> call() => _repo.getCategories();
  
}
