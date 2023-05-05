import 'package:flutter/material.dart';
import '../values/app.values.dart';

class AppBarCoreWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appTitle),
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
