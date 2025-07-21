import 'package:ecommerce_app/core/app/resources/fonts.dart';
import 'package:ecommerce_app/core/widgets/my_field.dart';
import 'package:flutter/material.dart';

class TitledInputField extends StatelessWidget {
  const TitledInputField({
    required this.controller,
    required this.title,
    this.required = true,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon; 
  final bool required;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            RichText(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: Fonts.poppins,
                  fontWeight: FontWeight.w500,
                ),
                children: !required ? null : const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            if(suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 10),
        MyField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          overrideValidator: true,
          validator: (value){
            if(!required) return null;
            if(value == null || value == ''){
              return 'This field is required.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
