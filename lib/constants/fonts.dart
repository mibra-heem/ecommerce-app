import 'package:flutter/material.dart';

class CustomFontSize {
  static double small(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 12 : 10;
  }

  static double medium(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 14 : 12;
  }

  static double large(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 16 : 14;
  }

  static double extraLarge(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 18 : 16;
  }

  static double extraExtraLarge(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 20 : 18;
  }

  static double iconsFont(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 36 : 48;
  }
}
