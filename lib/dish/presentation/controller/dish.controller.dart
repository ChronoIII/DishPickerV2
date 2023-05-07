import 'dart:js';

import 'package:dishv3/core/utils/chat-gpt.util.dart';
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
    var selectedDish = ref.watch(selectedDishProvider);
    print(await ChatGptUtil().askQuestion(
      'what is the recipe for ${selectedDish?.dishName} ${selectedDish?.dishLocation}',
    ));

    // print(await ChatGptUtil().requestImage(
    //     '${selectedDish?.dishName} ${selectedDish?.dishLocation}'));
  }
}
