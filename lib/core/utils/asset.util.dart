import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../values/asset.values.dart';

class AssetUtil {
  AssetUtil();

  static Image getImage(String filename, {int scaleMulitplier = 1}) {
    var fullPath = '$imageFullPath/$filename';
    return Image.asset(
      fullPath,
      scale: 1.0 / scaleMulitplier,
    );
  }

  static Future<List<dynamic>> getJson(String filename) async {
    var fullPath = '$jsonFullPath/$filename';
    var data = await rootBundle.loadString(fullPath);
    return json.decode(data);
  }

  static void getFont(String fontFamily) {}
}
