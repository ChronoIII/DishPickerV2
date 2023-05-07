import 'package:dishv3/core/layout/main-page.layout.dart';
import 'package:dishv3/core/utils/asset.util.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  Widget build(BuildContext context) {
    return MainPageLayout(
      contents: <Widget>[
        AssetUtil.getImage('test'),
      ],
    );
  }
}
