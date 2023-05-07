import '../../domain/entities/dish.entity.dart';

class DishModel extends DishEntity {
  const DishModel({
    required super.dishName,
    required super.dishIconPath,
    required super.dishRecipeUrl,
    required super.dishLocation,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) => DishModel(
        dishName: json['dishName'],
        dishIconPath: json['dishIconPath'],
        dishRecipeUrl: json['dishRecipeUrl'],
        dishLocation: json['dishLocation'],
      );
}
