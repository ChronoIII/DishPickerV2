import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dishv3/core/utils/asset.util.dart';
import 'package:dishv3/core/utils/secure-storage.util.dart';
import 'package:dishv3/dish/data/models/dish.model.dart';
import '../../../core/exceptions/failure.exception.dart';
import '../../../core/utils/chat-gpt.util.dart';
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

  @override
  Future<Either<FailureException, Object>> getRecipe(
      DishEntity selectedDish) async {
    try {
      var ingredientsKey = '${selectedDish.dishName}.ingredients';
      var instructionsKey = '${selectedDish.dishName}.instructions';

      String? ingredientsCache =
          await SecureStorageUtil().getFromStorage(ingredientsKey);
      String? instructionsCache =
          await SecureStorageUtil().getFromStorage(instructionsKey);

      if (ingredientsCache != null && instructionsCache != null) {
        return Right({
          'ingredients': ingredientsCache,
          'instructions': instructionsCache,
        });
      }

      var fullRecipe = await ChatGptUtil().askQuestion(
        'what is the recipe for ${selectedDish.dishName} ${selectedDish.dishLocation}',
      );

      return Right(
        defineRecipe(selectedDish, fullRecipe),
      );
    } catch (e) {
      return Left(
        FailureException(message: e.toString()),
      );
    }
  }

  Object defineRecipe(DishEntity selectedDish, String fullRecipe) {
    var ingredientText = formatRecipe(
      fullRecipe.substring(
        fullRecipe.indexOf('Ingredients:'),
        fullRecipe.indexOf('Instructions:'),
      ),
    );

    var instructionText = formatRecipe(
      fullRecipe.substring(
        fullRecipe.indexOf('Instructions:'),
      ),
    );

    SecureStorageUtil()
        .saveToStorage('${selectedDish.dishName}.ingredients', ingredientText);
    SecureStorageUtil().saveToStorage(
        '${selectedDish.dishName}.instructions', instructionText);

    return {
      "ingredients": ingredientText,
      "instructions": instructionText,
    };
  }

  String formatRecipe(String text) {
    var newText = text.replaceFirst(RegExp('(Ingredients:|Instructions:)'), '');

    var removeBreaks = newText.replaceAll(RegExp('(?<= ) | +\$|(?<=\n)\n'), '');

    return removeBreaks;
  }
}
