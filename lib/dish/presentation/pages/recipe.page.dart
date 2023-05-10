import 'package:dishv3/core/extensions/text.extension.dart';
import 'package:dishv3/dish/presentation/providers/dish.provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/layout/scrollable-page.layout.dart';

class RecipePage extends ConsumerStatefulWidget {
  const RecipePage({super.key});

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedDish = ref.watch(selectedDishProvider);
    final recipeIngredients = ref.watch(selectedIngredientsProvider);
    final recipeInstructions = ref.watch(selectedInstructionsProvider);

    return ScrollablePageLayout(
      bottomTabmenu: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket_outlined,
            ),
            label: 'Ingredients',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.collections_bookmark_rounded,
            ),
            label: 'Instructions',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      contents: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.sync_outlined,
                size: 30.0,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            selectedDish!.dishName.capitalize(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (_selectedIndex == 0)
          Text(recipeIngredients ?? '')
        else if (_selectedIndex == 1)
          Text(recipeInstructions ?? '')
      ],
    );
  }
}
