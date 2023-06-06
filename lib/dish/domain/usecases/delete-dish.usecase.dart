import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../repositories/dish.repository.dart';

class DeleteDishUseCase {
  final DishRepository _repository;

  DeleteDishUseCase(this._repository);

  Future<Either<FailureException, bool>> call(int dishId) {
    return _repository.deleteDish(dishId);
  }
}
