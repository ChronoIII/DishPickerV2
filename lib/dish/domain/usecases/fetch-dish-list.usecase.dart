import '../repositories/dish.repository.dart';

class FetchDishList {
  final DishRepository _repository;

  const FetchDishList(this._repository);

  call() {
    return _repository.fetchDishList();
  }
}
