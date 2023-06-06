import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/asset.util.dart';
import '../../domain/entities/dish.entity.dart';
import '../providers/dish.provider.dart';

class DishListTileWidget extends ConsumerWidget {
  const DishListTileWidget({
    super.key,
    required this.dishIcon,
    required this.dishData,
    required this.cardSubtitle,
  });

  final IconData dishIcon;
  final DishEntity dishData;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishController = ref.read(dishControllerProvider);
    final int dishId = dishData.dishId ?? 0;
    final String dishTitle = dishData.dishName;

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
            ),
          ),
        ),
        child: const Icon(
          Icons.wine_bar,
        ),
      ),
      title: Text(
        dishTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          const Icon(
            Icons.bakery_dining,
          ),
          Text(
            " $cardSubtitle",
          )
        ],
      ),
      trailing: TextButton(
        child: const Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
        ),
        onPressed: () {
          showMenu(
            context,
            dishData,
            viewRecipe: () {
              ref.watch(selectedDishProvider.notifier).state = dishData;
              context.push('/recipe');
            },
            onDelete: () {
              dishController.deleteDish(dishId);
            },
          );
        },
      ),
    );
  }
}

showMenu(context, dish, {viewRecipe, onDelete}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
          ),
          Positioned(
            top: -45,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: AssetUtil.getImage('meal.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Text(dish.dishName),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  // width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book_outlined),
                    label: const Text(
                      'View Recipe',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    onPressed: viewRecipe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ],
      );
    },
  );
}
