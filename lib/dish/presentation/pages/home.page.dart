import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../../core/layout/main-page.layout.dart';
import '../../../core/utils/asset.util.dart';
import '../../../core/extensions/text.extension.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController scaleController;
  var _scaleMulitplier = 1;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDishLoading = ref.watch(loadingDishProvider);
    final dishController = ref.read(dishControllerProvider);
    final selectedDish = ref.watch(selectedDishProvider);

    return MainPageLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      contents: <Widget>[
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(animationController),
                  child: AssetUtil.getImage(
                    'meal.png',
                    scaleMulitplier: _scaleMulitplier,
                  ),
                ),
                if (selectedDish == null)
                  Text(isDishLoading ? '' : 'Touch me daddy.')
                else
                  Column(
                    children: [
                      Text(
                        isDishLoading ? '' : selectedDish.dishName.capitalize(),
                        style: const TextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                      Text(
                        isDishLoading ? '' : '(Tap again for another dish.)',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Color.fromARGB(150, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                if (selectedDish != null && isDishLoading == false)
                  Column(
                    children: [
                      const SizedBox(height: 15.0),
                      TextButton(
                        child: const Text('Check for the Recipe'),
                        onPressed: () async {
                          await dishController.getCuisineRecipe().then(
                                (value) => context.go('/recipe'),
                              );
                        },
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
              ],
            ),
          ),
          onTap: () {
            ref.watch(loadingDishProvider.notifier).state = true;
            animationController.repeat();
            setState(() {
              _scaleMulitplier = 2;
            });

            dishController.randomizeDish().then((value) {
              ref.watch(loadingDishProvider.notifier).state = false;
              animationController.reset();
              setState(() {
                _scaleMulitplier = 1;
              });
            });
          },
        ),
      ],
    );
  }
}
