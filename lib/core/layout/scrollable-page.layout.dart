import '../../core/layout/base-page.layout.dart';
import 'package:flutter/material.dart';

class ScrollablePageLayout extends StatelessWidget {
  const ScrollablePageLayout({
    super.key,
    required this.contents,
    this.containerPadding,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.actionButtons,
    this.bottomTabmenu,
    this.disableTabmenu,
  });

  final List<Widget> contents;
  final double? containerPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final List<Widget>? actionButtons;
  final BottomNavigationBar? bottomTabmenu;
  final bool? disableTabmenu;

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      disableTabmenu: disableTabmenu,
      containerPadding: containerPadding,
      actionButtons: actionButtons,
      bottomTabmenu: bottomTabmenu,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: [
            ...contents,
          ],
        ),
      ),
    );
  }
}
