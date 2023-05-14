import 'dart:convert';

import 'package:dishv3/dish/domain/usecases/fetch-dish-list.usecase.dart';
import 'package:dishv3/dish/domain/usecases/get-recipe.usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../domain/repositories/dish.repository.dart';
import '../../domain/usecases/randomize-dish.usecase.dart';

class DishController {
  final Ref ref;
  late DishRepository _dishRepository;
  late RandomizeDish _randomizeDish;
  late GetRecipe _getRecipe;
  late FetchDishList _fetchDishList;

  DishController(this.ref) {
    _dishRepository = ref.read(dishRepositoryProvider);

    // Use cases
    _randomizeDish = RandomizeDish(_dishRepository);
    _getRecipe = GetRecipe(_dishRepository);
    _fetchDishList = FetchDishList(_dishRepository);
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
}
