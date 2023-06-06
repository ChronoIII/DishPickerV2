import 'dart:convert';

import 'package:dishv3/dish/data/models/dish.model.dart';
import 'package:dishv3/dish/domain/usecases/fetch-dish-list.usecase.dart';
import 'package:dishv3/dish/domain/usecases/get-recipe.usecase.dart';
import 'package:dishv3/dish/domain/usecases/save-dish.usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repositories/recipe.repository.dart';
import '../../domain/usecases/delete-dish.usecase.dart';
import '../../presentation/providers/dish.provider.dart';
import '../../domain/repositories/dish.repository.dart';
import '../../domain/usecases/randomize-dish.usecase.dart';

class DishController {
  final Ref ref;
  late DishRepository _dishRepository;
  late RecipeRepository _recipeRepository;
  late RandomizeDish _randomizeDish;
  late GetRecipe _getRecipe;
  late FetchDishList _fetchDishList;
  late SaveDishUseCase _saveDish;
  late DeleteDishUseCase _deleteDish;

  DishController(this.ref) {
    _dishRepository = ref.read(dishRepositoryProvider);

    // Use cases
    _randomizeDish = RandomizeDish(_dishRepository);
    _getRecipe = GetRecipe(_recipeRepository);
    _fetchDishList = FetchDishList(_dishRepository);
    _saveDish = SaveDishUseCase(_dishRepository);
    _deleteDish = DeleteDishUseCase(_dishRepository);
  }

  Future<void> randomizeDish() async {
    ref.watch(selectedDishProvider.notifier).state = null;

    await Future.delayed(const Duration(seconds: 2));

    var response = await _randomizeDish();
    response.fold(
      (left) {},
      (right) {
        ref.watch(selectedDishProvider.notifier).state = right;
      },
    );
  }

  Future<void> getCuisineRecipe() async {
    ref.watch(loadingRecipeProvider.notifier).state = true;

    var selectedDish = ref.watch(selectedDishProvider);
    var response = await _getRecipe(selectedDish!);

    response.fold(
      (left) {
        ref.watch(loadingRecipeProvider.notifier).state = false;
      },
      (right) {
        var encodedRecipe = json.encode(right);
        var decodedRecipe = json.decode(encodedRecipe);

        ref.watch(selectedIngredientsProvider.notifier).state =
            decodedRecipe['ingredients'];

        ref.watch(selectedInstructionsProvider.notifier).state =
            decodedRecipe['instructions'];

        ref.watch(loadingRecipeProvider.notifier).state = false;
      },
    );
  }

  Future<void> fetchDishList() async {
    var response = await _fetchDishList();

    response.fold(
      (left) {},
      (right) {
        ref.watch(listDishProvider.notifier).state = right;
      },
    );
  }

  Future<void> saveDish(String dishName, String? dishLocation) async {
    var response = await _saveDish(
      DishModel(
        dishName: dishName,
        dishIconPath: null,
        dishRecipe: null,
        dishLocation: (dishLocation == '') ? null : dishLocation,
      ),
    );

    response.fold(
      (left) {
        print(left.message);
      },
      (right) {
        print(right.toString());
      },
    );
  }

  Future<void> deleteDish(int dishId) async {
    var response = await _deleteDish(dishId);

    response.fold(
      (left) {
        print(left.message);
      },
      (right) {
        print(right.toString());
      },
    );
  }
}
