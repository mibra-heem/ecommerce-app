import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({
    required this.title,
    required this.icon,
    this.titleColor,
    this.iconColor,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color? titleColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          icon,
          color: iconColor,
        ),
      ],
    );
  }
}
