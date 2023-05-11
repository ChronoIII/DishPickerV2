import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/layout/scrollable-page.layout.dart';
import '../../../core/utils/asset.util.dart';
import '../../../core/extensions/text.extension.dart';
import '../../presentation/providers/dish.provider.dart';
import '../../../core/layout/main-page.layout.dart';

class RecipePage extends ConsumerStatefulWidget {
  const RecipePage({super.key});

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewDish = ref.watch(viewDishProvider);
    final selectedRecipe = ref.watch(selectedRecipeProvider);

    return selectedRecipe.when(
      error: (e, _) => MainPageLayout(
        contents: [
          Text(e.toString()),
        ],
      ),
      loading: () {
        return MainPageLayout(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          contents: [
            AssetUtil.getImage('book.gif', scaleMulitplier: 2),
          ],
        );
      },
      data: (data) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    viewDish != null ? viewDish.dishName.capitalize() : '',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_selectedIndex == 0)
                  Text(data['ingredients'] ?? '')
                else if (_selectedIndex == 1)
                  Text(data['instructions'] ?? '')
              ],
            )
          ],
        );
      },
    );
  }
}
