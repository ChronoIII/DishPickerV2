import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/dish.repository-impl.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../domain/usecases/get-recipe.usecase.dart';
import '../../domain/usecases/randomize-dish.usecase.dart';
import '../../presentation/controller/dish.controller.dart';

final selectedTabmenuProvider = StateProvider<int>((ref) => 0);

final loadingDishProvider = StateProvider<bool>((ref) => false);

final loadingRecipeProvider = StateProvider<bool>((ref) => false);

final listDishProvider = StateProvider<List<DishEntity>>((ref) => []);

final viewDishProvider = StateProvider<DishEntity?>((ref) => null);

final selectedDishProvider = StateProvider<DishEntity?>((ref) => null);

final selectedRecipeProvider = FutureProvider<dynamic>((ref) async {
  final viewDish = ref.watch(viewDishProvider);
  if (viewDish == null) {
    return null;
  }

  GetRecipe getRecipe = GetRecipe(ref.read(dishRepositoryProvider));
  Either<FailureException, dynamic> response = await getRecipe(viewDish);

  return response.fold(
    (left) {
      throw Exception(left.message);
    },
    (right) {
      return right;
    },
  );
});

final selectedIngredientsProvider = StateProvider<String?>((ref) => null);

final selectedInstructionsProvider = StateProvider<String?>((ref) => null);

final dishControllerProvider =
    StateProvider<DishController>((ref) => DishController(ref));

final dishRepositoryProvider =
    StateProvider<DishRepository>((ref) => DishRepositoryImpl());
