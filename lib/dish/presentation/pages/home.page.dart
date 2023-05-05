import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../../core/layout/main-page.layout.dart';
import '../../../core/utils/asset.util.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dishController = ref.read(dishControllerProvider);
    final selectedDish = ref.watch(selectedDishProvider);

    return MainPageLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      contents: <Widget>[
        Text(selectedDish != null ? selectedDish.dishName : 'test random'),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image(
                  image: AssetUtil.getImage('meal.png'),
                ),
                const Text('Touch me daddy.'),
              ],
            ),
          ),
          onTap: () {
            dishController.randomizeDish();
          },
        ),
      ],
    );
  }
}
