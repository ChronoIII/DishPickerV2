import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/text.extension.dart';
import '../../presentation/providers/dish.provider.dart';

class HomeSelectedWidget extends ConsumerWidget {
  const HomeSelectedWidget({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDish = ref.watch(selectedDishProvider);
    final dishController = ref.read(dishControllerProvider);

    return Column(
      children: [
        Text(
          selectedDish!.dishName.capitalize(),
          style: const TextStyle(
            fontSize: 23.0,
          ),
        ),
        const Text(
          '(Tap again for another dish.)',
          style: TextStyle(
            fontSize: 10.0,
            color: Color.fromARGB(150, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 15.0),
        TextButton(
          child: const Text('Check for the Recipe'),
          onPressed: () async {
            await dishController.getCuisineRecipe().then(
                  (value) => parentContext.go('/recipe'),
                );
          },
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
