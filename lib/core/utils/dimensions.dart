import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class Dimensions {

  const Dimensions._();

  static late double screenHeight;
  static late double screenWidth;

  static late double baseWidth;
  static late double baseHeight;

  static void init(BuildContext context, {double? height, double? width}) {
    screenHeight = context.height;
    screenWidth = context.width;
    baseHeight = height ?? 812;
    baseWidth = width ?? 375;
  }

  static double width(double w) {
    debugPrint('${screenWidth * (w / baseWidth)}');
    return screenWidth * (w / baseWidth);
  }

  static double height(double h) {
    debugPrint('${screenHeight * (h / baseHeight)}');

    return screenHeight * (h / baseHeight);
  }

  static double size(double sizeFactor) {
    final baseAverageDimension = (baseWidth + baseHeight) / 2;
    final currentAverageDimension = (screenWidth + screenHeight) / 2;
    return currentAverageDimension * (sizeFactor / baseAverageDimension);
  }
}
