import 'package:equatable/equatable.dart';

const String dbPath = 'dishPicker.db';
const String tableDish = 't_dish';
const String columnId = 'id';
const String columnName = 'dish_name';
const String columnIconPath = 'dish_icon_path';
const String columnRecipe = 'dish_recipe';
const String columnLocation = 'dish_location';

class DishEntity extends Equatable {
  const DishEntity({
    this.dishId,
    required this.dishName,
    this.dishIconPath,
    this.dishRecipe,
    this.dishLocation,
  });

  final int? dishId;
  final String dishName;
  final String? dishIconPath;
  final String? dishRecipe;
  final String? dishLocation;

  @override
  List<Object> get props => [];

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: dishName,
      columnIconPath: dishIconPath,
      columnRecipe: dishRecipe,
      columnLocation: dishLocation,
    };

    if (dishId != null) {
      map[columnId] = dishId;
    }
    return map;
  }
}
