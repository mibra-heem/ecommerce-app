import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<Color> indicatorColor = Colors.black.obs;

  void toggleTheme() {
    indicatorColor.value = Get.isDarkMode ? Colors.white : Colors.black;
  }
}
