import '../../domain/entities/dish.entity.dart';

class DishModel extends DishEntity {
  const DishModel({
    super.dishId,
    required super.dishName,
    required super.dishIconPath,
    required super.dishRecipe,
    required super.dishLocation,
  });

  factory DishModel.fromJson(Map<dynamic, dynamic> json) => DishModel(
        dishId: json[columnId] ?? 0,
        dishName: json[columnName],
        dishIconPath: json[columnIconPath],
        dishRecipe: json[columnRecipe],
        dishLocation: json[columnLocation],
      );
}
