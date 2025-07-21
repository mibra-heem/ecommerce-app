import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:flutter/material.dart';

class AppColorScheme {
  const AppColorScheme._();

  static const light = ColorScheme.light(
      primary: Colours.primary,
      onPrimary: Colours.grey100,
      primaryContainer: Colours.primary,
      secondary: Colours.grey900,
      onSecondary: Colours.grey100,
      tertiary: Colours.grey800,
      onTertiary: Colours.grey200,
      surface: Colours.scaffoldLight,
      surfaceContainer: Colours.white,
    );

  static const dark = ColorScheme.dark(
    primary: Colours.primary,
    onPrimary: Colours.grey100,
    primaryContainer: Colours.primary,
    secondary: Colours.grey100,
    onSecondary: Colours.grey900,
    tertiary: Colours.grey200,
    onTertiary: Colours.grey800,
    onSurface: Colours.grey100,
    surfaceContainer: Colours.grey900,
  );
}
