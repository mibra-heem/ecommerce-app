import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
    this.label, {
    required this.onPressed,
    super.key,
    this.elevation,
    this.labelColor,
    this.buttonColor,
  });

  final String label;
  final Color? labelColor;
  final Color? buttonColor;
  final double? elevation;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: buttonColor ?? Colours.primary,
        foregroundColor: labelColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600),),
    );
  }
}
