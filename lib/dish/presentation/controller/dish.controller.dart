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
    var response = await _randomizeDish();
    response.fold(
      (left) {},
      (right) {
        ref.watch(selectedDishProvider.notifier).state = right;
      },
    );
  }
}
