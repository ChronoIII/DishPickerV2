import '../repositories/dish.repository.dart';

class RandomizeDish {
  RandomizeDish(this._repository);

  final DishRepository _repository;

  call() {
    return _repository.randomizeDish();
  }
}
