import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../entities/dish.entity.dart';

abstract class DishRepository {
  Future<Either<FailureException, DishEntity>> randomizeDish();
  Future<Either<FailureException, Object>> getRecipe(DishEntity selectedDish);
}
