import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return color ?? AppColor.primaryTheme;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(child: CircularProgressIndicator()))
            : SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                fontSize: CustomFontSize.small(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
