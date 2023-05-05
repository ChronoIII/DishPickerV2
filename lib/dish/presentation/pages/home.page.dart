import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/providers/dish.provider.dart';
import '../../../core/layout/main-page.layout.dart';
import '../../../core/utils/asset.util.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishController = ref.read(dishControllerProvider);

    return MainPageLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      contents: <Widget>[
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image(
                  image: AssetUtil.getImage('meal.png'),
                ),
                const Text('Touch me daddy...'),
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
