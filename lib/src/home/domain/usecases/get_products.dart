import 'package:ecommerce_app/core/utils/typedef.dart';
import 'package:ecommerce_app/core/utils/usecases.dart';
import 'package:ecommerce_app/src/home/domain/repos/home_repo.dart';
import 'package:ecommerce_app/src/product/domain/entities/product.dart';

class GetProducts extends UseCaseWithoutParams<List<Product>>{

  const GetProducts(this._repo);

  final HomeRepo _repo;

  @override
  RFuture<List<Product>> call() => _repo.getProducts();
  
}
