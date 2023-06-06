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
    this.floatingActionButton,
  });

  final List<Widget> contents;
  final double? containerPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final List<Widget>? actionButtons;
  final BottomNavigationBar? bottomTabmenu;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      containerPadding: containerPadding,
      actionButtons: actionButtons,
      bottomTabmenu: bottomTabmenu,
      floatingActionButton: floatingActionButton,
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
