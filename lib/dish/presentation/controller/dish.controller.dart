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
    ChatGptUtil().test('what is the recipe for menudo');
    await Future.delayed(Duration(seconds: 5));

    var response = await _randomizeDish();
    response.fold(
      (left) {},
      (right) {
        ref.watch(selectedDishProvider.notifier).state = right;
      },
    );
  }
}
