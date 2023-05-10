import 'package:dishv3/core/extensions/text.extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/layout/base-page.layout.dart';
import '../../domain/entities/dish.entity.dart';
import '../../presentation/widgets/dish-card.widget.dart';
import '../../presentation/providers/dish.provider.dart';
import '../controller/dish.controller.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  late DishController _dishController;
  late List<DishEntity> dishList;

  @override
  void initState() {
    super.initState();
    _dishController = ref.read(dishControllerProvider);

    _dishController.fetchDishList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfDish = ref.watch(listDishProvider);

    return BasePageLayout(
      containerPadding: 0.0,
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listOfDish.length,
        itemBuilder: (context, index) {
          return DishCardWidget(
            cardIcon: Icons.wine_bar_rounded,
            cardTitle: listOfDish[index].dishName.capitalize(),
            cardSubtitle: listOfDish[index].dishLocation ?? '- - -',
          );
        },
      ),
    );
  }
}
