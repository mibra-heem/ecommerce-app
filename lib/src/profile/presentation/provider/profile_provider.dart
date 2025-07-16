import 'dart:io';
import 'package:ecommerce_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {

  File? pickedImage;
  bool get imageChanged => pickedImage != null;

  Future<void> pickImage() async {
    pickedImage = await CoreUtils.pickImage();
    notifyListeners();
  }
}
