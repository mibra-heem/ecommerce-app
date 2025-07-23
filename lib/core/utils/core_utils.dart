import 'dart:io';

import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/app/resources/media.dart';
import 'package:ecommerce_app/core/config/api.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
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
        ? NetworkImage(ApiConfig.baseUrl + imageUrl)
        : AssetImage(fallbackImage ?? Media.defaultShoeImage)) as ImageProvider;

    return imageProvider;
  }

  /// Formats price with commas (e.g., 125000 -> 1,25,000)
  static String currencyFormat(num price) {
    final priceStr = price.toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return priceStr.replaceAllMapped(reg, (match) => ',');
  }

  static Color parseColor(String colorHex) {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xff')));
    } on Exception catch (_) {
      return Colours.grey400;
    }
  }
}
