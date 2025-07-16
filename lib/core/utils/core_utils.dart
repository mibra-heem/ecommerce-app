import 'dart:io';

import 'package:ecommerce_app/core/constants/api_const.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:ecommerce_app/core/resources/media.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CoreUtils {
  CoreUtils._();

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showLoading(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(color: Colours.primary),
        );
      },
    );
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static String joinIdsWithTimeStamp({
    required String userId,
    required String chatId,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final ids = [userId, chatId]..sort();
    return '${ids.join('_')}_$timestamp';
  }

  static ImageProvider getImageProvider({
    required String? imageUrl,
    String? fallbackImage,
  }) {
    final imageProvider = (imageUrl != null && imageUrl.isNotEmpty
        ? NetworkImage(ApiConst.baseUrl + imageUrl)
        : AssetImage(fallbackImage ?? Media.defaultShoeImage)) as ImageProvider;

    return imageProvider;
  }
}
