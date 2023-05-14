import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/dish/presentation/providers/dish.provider.dart';
import 'home.page.dart';
import 'recipe.page.dart';
import 'list.page.dart';
import 'settings.page.dart';

class IndexPage extends ConsumerWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.watch(selectedTabmenuProvider);

    switch (test) {
      case 0:
        return const HomePage();
      case 1:
        return const RecipePage();
      case 2:
        return const ListPage();
      case 3:
        return const SettingsPage();
      default:
        return const Text('no view');
    }
  }
}
