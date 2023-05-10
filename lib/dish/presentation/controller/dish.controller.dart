import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../domain/repositories/dish.repository.dart';
import '../../domain/usecases/randomize-dish.usecase.dart';

class DishController {
  final Ref ref;
  late DishRepository dishRepository;
  late RandomizeDish _randomizeDish;

  DishController(this.ref) {
    dishRepository = ref.read(dishRepositoryProvider);

    // Use cases
    _randomizeDish = RandomizeDish(dishRepository);
  }

  Future<void> randomizeDish() async {
    ref.watch(selectedDishProvider.notifier).state = null;

    await Future.delayed(const Duration(seconds: 5));

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
    var response = await dishRepository.getRecipe(selectedDish!);

    response.fold(
      (left) {
        ref.watch(loadingRecipeProvider.notifier).state = true;
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
}
