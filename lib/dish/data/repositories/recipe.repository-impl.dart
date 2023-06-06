import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.exception.dart';
import '../../../core/utils/chat-gpt.util.dart';
import '../../../core/utils/secure-storage.util.dart';
import '../../domain/entities/dish.entity.dart';
import '../../domain/repositories/recipe.repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
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
        'what is the recipe for ${selectedDish.dishName} ${selectedDish.dishLocation ?? ""}',
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

    var recipeObject = {
      "ingredients": ingredientText,
      "instructions": instructionText,
    };

    // SecureStorageUtil().saveToStorage(
    //     '${selectedDish.dishName}.recipe', json.encode(recipeObject));

    return json.decode(json.encode(recipeObject));
  }

  String formatRecipe(String text) {
    var newText = text.replaceFirst(RegExp('(Ingredients:|Instructions:)'), '');

    var removeBreaks = newText.replaceAll(RegExp('(?<= ) | +\$|(?<=\n)\n'), '');

    return removeBreaks;
  }
}
