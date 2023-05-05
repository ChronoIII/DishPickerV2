import 'package:equatable/equatable.dart';

class DishEntity extends Equatable {
  const DishEntity({
    required this.dishName,
    required this.dishIconPath,
    required this.dishRecipeUrl,
  });

  final String dishName;
  final String dishIconPath;
  final String dishRecipeUrl;

  @override
  List<Object> get props => [];
}
