import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NotFoundText extends StatelessWidget {
  const NotFoundText( this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.withAlpha(127),
          ),
        ),
      ),
    );
  }
}
