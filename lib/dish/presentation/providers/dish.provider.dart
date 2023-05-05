import 'package:dishv3/dish/presentation/controller/dish.controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/repositories/dish.repository-impl.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';

final selectedDishProvider = StateProvider<DishEntity?>((ref) => null);

final dishControllerProvider =
    StateProvider<DishController>((ref) => DishController(ref));

final dishRepositoryProvider =
    StateProvider<DishRepository>((ref) => DishRepositoryImpl());
