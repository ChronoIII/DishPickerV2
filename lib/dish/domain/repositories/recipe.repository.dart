import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../entities/dish.entity.dart';

abstract class RecipeRepository {
  Future<Either<FailureException, Object>> getRecipe(DishEntity selectedDish);
}
