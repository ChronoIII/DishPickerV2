import 'package:dartz/dartz.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';

class DishRepositoryImpl implements DishRepository {
  @override
  Future<Either<FailureException, DishEntity>> randomizeDish() async {
    await Future.delayed(const Duration(seconds: 2));
    return const Right(
      DishEntity(
        dishName: 'test',
        dishIconPath: 'test',
        dishRecipeUrl: 'test',
      ),
    );
  }
}
