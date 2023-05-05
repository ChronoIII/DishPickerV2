import 'package:flutter/material.dart';
import '../widgets/app-bar.core.widget.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    super.key,
    required this.contents,
    this.containerPadding,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  final List<Widget> contents;
  final double? containerPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCoreWidget(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(containerPadding ?? 10.0),
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
