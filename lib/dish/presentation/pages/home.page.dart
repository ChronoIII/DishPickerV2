import 'package:dishv3/dish/presentation/widgets/home-default.widget.dart';
import 'package:dishv3/dish/presentation/widgets/home-selected.widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../../core/layout/main-page.layout.dart';
import '../../../core/utils/asset.util.dart';

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
      disableTabmenu: isDishLoading,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // actionButtons: [
      //   IconButton(
      //     onPressed: () {
      //       context.push('/list');
      //     },
      //     icon: const Icon(Icons.menu_book_outlined),
      //   ),
      // ],
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
                if (isDishLoading == false)
                  if (selectedDish == null)
                    const HomeDefaultWidget()
                  else
                    const HomeSelectedWidget()
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
        )
      ],
    );
  }
}
