import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/app/resources/fonts.dart';
import 'package:flutter/material.dart';

class MyAppBarTheme {
  const MyAppBarTheme._();

  static const light = AppBarTheme(
    backgroundColor: Colours.appBarLight,
    actionsIconTheme: IconThemeData(color: Colours.white, size: 20),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: Fonts.poppins,
      letterSpacing: 0.8,
    ),
    iconTheme: IconThemeData(color: Colours.white),
  );

  static const dark = AppBarTheme(
    backgroundColor: Colours.appBarDark,
    actionsIconTheme: IconThemeData(color: Colours.white, size: 20),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: Fonts.poppins,
      letterSpacing: 0.8,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
