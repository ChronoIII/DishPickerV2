import 'package:flutter/material.dart';

import '../../domain/entities/dish.entity.dart';
import 'dish-card.widget.dart';

class DishListWidget extends StatefulWidget {
  const DishListWidget({
    super.key,
    required this.listOfDish,
  });

  final List<DishEntity> listOfDish;

  @override
  State<DishListWidget> createState() => _DishListWidgetState();
}

class _DishListWidgetState extends State<DishListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.listOfDish.length,
      itemBuilder: (context, index) {
        return DishCardWidget(
          dishIcon: Icons.wine_bar_rounded,
          dishData: widget.listOfDish[index],
          // cardSubtitle: widget.listOfDish[index].dishLocation ?? '- - -',
        );
      },
    );
  }
}
