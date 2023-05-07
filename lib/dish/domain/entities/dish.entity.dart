import 'package:equatable/equatable.dart';

class DishEntity extends Equatable {
  const DishEntity({
    required this.dishName,
    required this.dishIconPath,
    required this.dishRecipeUrl,
    this.dishLocation,
  });

  final String dishName;
  final String dishIconPath;
  final String dishRecipeUrl;
  final String? dishLocation;

  @override
  List<Object> get props => [];
}
