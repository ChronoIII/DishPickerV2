import 'package:dishv3/dish/presentation/providers/dish.provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repositories/dish.repository.dart';
import '../../domain/usecases/randomize-dish.usecase.dart';

class DishController {
  final Ref ref;
  late DishRepository _dishRepository;
  late RandomizeDish _randomizeDish;

  DishController(this.ref) {
    _dishRepository = ref.read(dishRepositoryProvider);
    _randomizeDish = RandomizeDish(_dishRepository);
  }

  Future<void> randomizeDish() async {
    var response = await _randomizeDish();
    response.fold(
      (left) {},
      (right) {
        print('test');
      },
    );
  }
}
