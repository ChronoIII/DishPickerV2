import 'package:flutter/material.dart';
import '../values/app.values.dart';

class AppBarCoreWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCoreWidget({
    super.key,
    this.actions,
  });

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        appTitle,
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
      actions: actions,
      backgroundColor: Colors.black87,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
