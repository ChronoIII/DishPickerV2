import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/dish.entity.dart';
import '../providers/dish.provider.dart';

class DishListTileWidget extends ConsumerWidget {
  const DishListTileWidget({
    super.key,
    required this.dish,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardSubtitle,
  });

  final DishEntity dish;
  final IconData cardIcon;
  final String cardTitle;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(right: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              // color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(
          Icons.wine_bar,
          // color: Colors.white,
        ),
      ),
      title: Text(
        cardTitle,
        style: const TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          const Icon(
            Icons.bakery_dining,
            // color: Colors.yellowAccent,
          ),
          Text(
            " $cardSubtitle",
            // style: TextStyle(color: Colors.white),
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.keyboard_arrow_right),
        // color: Colors.white,
        iconSize: 30.0,
        onPressed: () {
          ref.watch(viewDishProvider.notifier).state = dish;
          context.push('/recipe');
        },
      ),
    );
  }
}
