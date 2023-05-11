import 'package:dartz/dartz.dart';
import 'package:dishv3/core/exceptions/failure.exception.dart';
import 'package:dishv3/dish/domain/entities/dish.entity.dart';

import '../repositories/dish.repository.dart';

class FetchDishList {
  final DishRepository _repository;

  const FetchDishList(this._repository);

  Future<Either<FailureException, List<DishEntity>>> call() {
    return _repository.fetchDishList();
  }
}
