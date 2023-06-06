import '../../domain/entities/dish.entity.dart';
import '../repositories/recipe.repository.dart';

class GetRecipe {
  final RecipeRepository _repository;

  GetRecipe(this._repository);

  call(DishEntity selectedDish) {
    return _repository.getRecipe(selectedDish);
  }
}
