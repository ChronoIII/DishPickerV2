import 'package:flutter/material.dart';

import '../widgets/app-bar.core.widget.dart';

class BasePageLayout extends StatelessWidget {
  const BasePageLayout({
    super.key,
    required this.body,
    this.actionButtons,
    this.bottomTabmenu,
    this.containerPadding,
  });

  final Widget body;
  final List<Widget>? actionButtons;
  final BottomNavigationBar? bottomTabmenu;
  final double? containerPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCoreWidget(actions: actionButtons),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(containerPadding ?? 10.0),
        child: body,
      ),
      bottomNavigationBar: bottomTabmenu,
    );
  }
}
