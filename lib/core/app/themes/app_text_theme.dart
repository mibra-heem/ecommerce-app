import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const light = TextTheme(
    headlineMedium: TextStyle(
      color: Colours.grey800,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: Colours.black,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colours.black,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(
      color: Colours.grey600,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Colours.grey600,
    ),
  );

  static const dark = TextTheme(
    headlineSmall: TextStyle(
      color: Colours.grey200,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(color: Colours.grey100),
    titleLarge: TextStyle(
      color: Colours.white,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colours.white,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(
      color: Colours.grey500,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(color: Colours.grey600),
    labelMedium: TextStyle(
      color: Colours.grey100,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Colours.grey400,
    ),
    
  );
}
