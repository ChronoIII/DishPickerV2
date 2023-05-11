import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/dish.repository-impl.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../domain/usecases/get-recipe.usecase.dart';
import '../../presentation/controller/dish.controller.dart';

final loadingDishProvider = StateProvider<bool>((ref) => false);

final loadingRecipeProvider = StateProvider<bool>((ref) => false);

final listDishProvider = StateProvider<List<DishEntity>>((ref) => []);

final selectedDishProvider = StateProvider<DishEntity?>((ref) => null);

final selectedRecipeProvider = FutureProvider<dynamic>((ref) async {
  final selectedDish = ref.watch(selectedDishProvider);
  GetRecipe getRecipe = GetRecipe(ref.read(dishRepositoryProvider));
  Either<FailureException, dynamic> response = await getRecipe(selectedDish!);

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
