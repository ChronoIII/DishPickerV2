import 'dart:convert';
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
      var recipeKey = '${selectedDish.dishName}.recipe';

      String? recipeCache = await SecureStorageUtil().getFromStorage(recipeKey);

      if (recipeCache != null) {
        var jsonRecipe = json.decode(recipeCache);

        return Right({
          'ingredients': jsonRecipe['ingredients'],
          'instructions': jsonRecipe['instructions'],
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

  @override
  Future<Either<FailureException, List<DishEntity>>> fetchDishList() async {
    try {
      var json = await AssetUtil.getJson('dish-list.json');

      return Right(
        json.map((data) => DishModel.fromJson(data)).toList(),
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

    var recipeObject = {
      "ingredients": ingredientText,
      "instructions": instructionText,
    };

    SecureStorageUtil().saveToStorage(
        '${selectedDish.dishName}.recipe', json.encode(recipeObject));

    return json.decode(json.encode(recipeObject));
  }

  String formatRecipe(String text) {
    var newText = text.replaceFirst(RegExp('(Ingredients:|Instructions:)'), '');

    var removeBreaks = newText.replaceAll(RegExp('(?<= ) | +\$|(?<=\n)\n'), '');

    return removeBreaks;
  }
}
