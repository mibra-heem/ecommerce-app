import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/failure.dart';

typedef RFuture<T> = Future<Either<Failure, T>>;
typedef DMap = Map<String, dynamic>;
