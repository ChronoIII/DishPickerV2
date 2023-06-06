import 'package:dishv3/dish/presentation/widgets/dish-list-tile.widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/dish.entity.dart';

class DishCardWidget extends StatelessWidget {
  const DishCardWidget({
    super.key,
    required this.dishIcon,
    required this.dishData,
    this.cardSubtitle,
  });

  final IconData dishIcon;
  final DishEntity dishData;
  final String? cardSubtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Container(
        // decoration:
        //     const BoxDecoration(color: Color.fromRGBO(238, 238, 238, 0.894)),
        child: DishListTileWidget(
          dishIcon: dishIcon,
          dishData: dishData,
          cardSubtitle: cardSubtitle ?? '- - -',
        ),
      ),
    );
  }
}
