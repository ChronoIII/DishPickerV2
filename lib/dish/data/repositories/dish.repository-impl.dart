import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dishv3/core/utils/asset.util.dart';
import 'package:dishv3/dish/data/models/dish.model.dart';
import 'package:flutter/services.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/dish.repository.dart';

class DishRepositoryImpl implements DishRepository {
  @override
  Future<Either<FailureException, DishEntity>> randomizeDish() async {
    try {
      var random = Random();
      var json = await AssetUtil.getJson('dish-list.json');
      int index = random.nextInt(json.length - 1);
      DishModel selected = DishModel.fromJson(json[index]);

      return Right(selected);
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }
}
