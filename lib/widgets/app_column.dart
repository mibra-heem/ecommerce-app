import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height5),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) { return Icon(Icons.star, color: AppColor.mainColor, size:15,);}),
            ),
            SizedBox(width: 10),
            SmallText(text: "4.5"),
            SizedBox(width: 10),
            SmallText(text: "1309"),
            SizedBox(width: 10),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.check_circle,
                text: "Normal",
                iconColor: AppColor.mainColor),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.9km",
                iconColor: AppColor.textColor1),
            IconAndTextWidget(icon: Icons.access_time_filled,
                text: "32 min",
                iconColor: AppColor.secondaryColor)
          ],
        )
      ],
    );
  }
}
