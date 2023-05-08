import 'package:dishv3/core/layout/scrollable-page.layout.dart';
import 'package:dishv3/core/utils/asset.util.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollablePageLayout(
      contents: [
        ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('test'),
              leading: AssetUtil.getImage('meal.png'),
            );
          },
        ),
      ],
    );
  }
}
