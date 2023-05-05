import '../values/asset.values.dart';
import 'package:flutter/material.dart';

class AssetUtil {
  AssetUtil();

  static AssetImage getImage(String filename) {
    var fullPath = '$imagePath/$filename';
    return AssetImage(fullPath);
  }

  static void getFont(String fontFamily) {}
}
