import 'dart:convert';

import 'package:flutter/services.dart';

import '../values/asset.values.dart';
import 'package:flutter/material.dart';

class AssetUtil {
  AssetUtil();

  static AssetImage getImage(String filename) {
    var fullPath = '$imageAssetPath/$filename';
    return AssetImage(fullPath);
  }

  static Future<List<dynamic>> getJson(String filename) async {
    var fullPath = '$jsonAssetPath/$filename';
    var data = await rootBundle.loadString(fullPath);
    return json.decode(data);
  }

  static void getFont(String fontFamily) {}
}
