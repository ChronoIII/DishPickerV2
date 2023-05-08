import '../../domain/entities/dish.entity.dart';
import '../repositories/dish.repository.dart';

class GetRecipe {
  final DishRepository _repository;

  GetRecipe(this._repository);

  call(DishEntity selectedDish) {
    _repository.getRecipe(selectedDish);
  }
}
