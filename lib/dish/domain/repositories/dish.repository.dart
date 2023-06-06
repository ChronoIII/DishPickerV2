import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../../data/models/dish.model.dart';
import '../entities/dish.entity.dart';

abstract class DishRepository {
  Future<Either<FailureException, DishEntity>> randomizeDish();
  // Future<Either<FailureException, Object>> getRecipe(DishEntity selectedDish);
  Future<Either<FailureException, List<DishEntity>>> fetchDishList();
  Future<Either<FailureException, bool>> saveDish(DishModel dish);
  Future<Either<FailureException, bool>> deleteDish(int dishId);
}
