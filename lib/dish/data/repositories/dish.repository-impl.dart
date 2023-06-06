import 'dart:convert';
import 'dart:math';
import 'package:dartz/dartz.dart';

import '../providers/dish.provider.dart';
import '/core/utils/asset.util.dart';
import '/core/utils/secure-storage.util.dart';
import '../../data/models/dish.model.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../../core/utils/chat-gpt.util.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';

class DishRepositoryImpl implements DishRepository {
  @override
  Future<Either<FailureException, DishEntity>> randomizeDish() async {
    try {
      var random = Random();
      var dishList = await DishProvider().index();
      if (dishList.isEmpty) {
        throw Exception('No dish was found.');
      }
      int index =
          (dishList.length == 1) ? 0 : random.nextInt(dishList.length - 1);
      DishEntity selected = dishList[index];

      return Right(selected);
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<FailureException, List<DishEntity>>> fetchDishList() async {
    try {
      var dishList = await DishProvider().index();
      return right(dishList);
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> saveDish(DishModel dish) async {
    try {
      await DishProvider().store(dish);
      return right(true);
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> deleteDish(int dishId) async {
    try {
      await DishProvider().destroy(dishId);
      return right(true);
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }
}
