import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    this.icon,
    super.key,
    this.size,
    this.color,
    this.onPressed,
  });

  final IconData? icon;
  final double? size;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 60,
      width: size ?? 60,
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon ?? Icons.call, color: Colours.white, size: 30),
      ),
    );
  }
}
