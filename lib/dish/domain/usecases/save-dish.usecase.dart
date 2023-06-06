import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../../data/models/dish.model.dart';
import '../repositories/dish.repository.dart';

class SaveDishUseCase {
  final DishRepository _repository;

  SaveDishUseCase(this._repository);

  Future<Either<FailureException, bool>> call(DishModel dish) {
    return _repository.saveDish(dish);
  }
}
