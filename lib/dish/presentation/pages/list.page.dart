import 'package:dishv3/core/extensions/text.extension.dart';
import 'package:dishv3/core/widgets/textbox.widget.dart';
import 'package:dishv3/dish/presentation/widgets/dish-list.widget.dart';
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
    bool showAdvanceOption = false;
    final listOfDish = ref.watch(listDishProvider);

    return BasePageLayout(
      containerPadding: 0.0,
      body: Column(
        children: [
          Expanded(
            child: DishListWidget(
              listOfDish: listOfDish,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Colors.black87,
              ),
              onPressed: () => showPopup(showAdvanceOption),
              label: const Text(
                'Add new Dish',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  showPopup(showAdvanceOption) {
    final cuisineName = TextEditingController();
    final cuisineLocation = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            // margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.only(top: 15.0),
            width: double.infinity,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add new Cuisine',
                      style: TextStyle(),
                    ),
                  ],
                ),
                const Divider(color: Colors.black45),
                Column(
                  children: [
                    TextboxWidget(
                      controller: cuisineName,
                      labelText: 'Cuisine Name',
                      hintText: 'e.g. Pork sinigang, Chicken adobo,',
                      containerPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    if (!showAdvanceOption)
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.grey,
                          weight: 1.0,
                          size: 16.0,
                        ),
                        label: const Text(
                          'Advance options',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (showAdvanceOption)
                      TextboxWidget(
                        controller: cuisineLocation,
                        labelText: 'Location (optional)',
                        containerPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                  ],
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    _dishController.saveDish(
                      cuisineName.text,
                      cuisineLocation.text,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
