import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:ecommerce_app/core/resources/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: Fonts.poppins,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: Colours.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colours.primary,
      surface: Colours.grey300,
      tertiary: Colours.grey200,
      onTertiary: Colours.grey800,
    ),
    applyElevationOverlayColor: false,
    shadowColor: Colors.transparent,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: Colours.scaffoldLight,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colours.grey800,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: Colours.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colours.appBarLight,
      actionsIconTheme: IconThemeData(color: Colours.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colours.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        surfaceTintColor: Colours.white,
        foregroundColor: Colours.grey900,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colours.grey600,
    ),
    dialogTheme: const DialogTheme(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colours.scaffoldLight,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Colours.primary,
      textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: Fonts.poppins,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colours.navBarLight,
      type: BottomNavigationBarType.fixed,
      elevation: 1,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colours.primary,
      foregroundColor: Colours.white,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colours.white,
      surfaceTintColor: Colours.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colours.textFieldLight,
      hintStyle: const TextStyle(color: Colours.grey900),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldLight),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldLight),
      ),
      suffixIconColor: Colours.black,
      prefixIconColor: Colours.black,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: Fonts.poppins,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    shadowColor: Colors.transparent,
    splashColor: Colors.transparent,
    primaryColor: Colours.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colours.primary,
      surface: Colours.grey900,
      brightness: Brightness.dark,
      tertiary: Colours.grey800,
      onTertiary: Colours.grey100,
    ),
    applyElevationOverlayColor: false,
    scaffoldBackgroundColor: Colours.scaffoldDark,
    splashFactory: NoSplash.splashFactory,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colours.grey200,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colours.grey100,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: Colours.grey100,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: TextStyle(
        color: Colours.grey300,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        color: Colours.grey100,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        surfaceTintColor: Colours.grey900,
        foregroundColor: Colours.grey100,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colours.grey300,
    ),
    dialogTheme: const DialogTheme(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colours.grey900,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Colours.white,
      textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: Fonts.poppins,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colours.appBarDark,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colours.primary,
      foregroundColor: Colours.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colours.navBarDark,
      selectedIconTheme: IconThemeData(color: Colours.primaryLight),
      selectedItemColor: Colours.primaryLight,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colours.grey100,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colours.textFieldDark,
      hintStyle: const TextStyle(color: Colours.grey100),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldDark),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colours.textFieldDark),
      ),
      suffixIconColor: Colours.white,
      prefixIconColor: Colours.white,
    ),
  );
}
