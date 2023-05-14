import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../dish/presentation/providers/dish.provider.dart';
import '../widgets/app-bar.core.widget.dart';

class BasePageLayout extends ConsumerWidget {
  const BasePageLayout(
      {super.key,
      required this.body,
      this.actionButtons,
      this.bottomTabmenu,
      this.containerPadding,
      this.disableTabmenu});

  final Widget body;
  final List<Widget>? actionButtons;
  final BottomNavigationBar? bottomTabmenu;
  final double? containerPadding;
  final bool? disableTabmenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabmenu = ref.watch(selectedTabmenuProvider);

    return Scaffold(
      appBar: AppBarCoreWidget(actions: actionButtons),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(containerPadding ?? 10.0),
        child: body,
      ),
      // bottomNavigationBar: bottomTabmenu,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},4ar
      //   child: const Text('+'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: (disableTabmenu ?? false)
          ? null
          : BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).primaryColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.checklist_rounded,
                  ),
                  label: 'Recipe',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_book_rounded,
                  ),
                  label: 'List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                )
              ],
              currentIndex: selectedTabmenu,
              onTap: (index) {
                ref.watch(selectedTabmenuProvider.notifier).state = index;
              },
              backgroundColor: Colors.black12,
            ),
    );
  }
}
