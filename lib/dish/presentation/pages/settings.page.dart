import 'package:flutter/material.dart';

import '../../../core/layout/main-page.layout.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainPageLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      contents: [
        Text('Settings Page'),
      ],
    );
  }
}
