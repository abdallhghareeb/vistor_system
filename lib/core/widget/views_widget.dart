import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/text_style.dart';

class ViewWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool? isIcon;
  final Color? color, iconColor, textStyleColor;
  const ViewWidget(
      {super.key,
      required this.text,
      required this.icon,
      this.iconColor,
      this.textStyleColor,
      this.color, this.isIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(1.5.w),
        decoration: BoxDecoration(
            color: color ,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isIcon != null
                ? Icon(icon, color: iconColor)
                : const SizedBox(),
                SizedBox(width: 0.5.w),
            Text(text, style: TextStyleClass.smallStyle(color: textStyleColor),),
          ],
        ),
      ),
    );
  }
}

/* Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor ?? AppColor.greyTextColor),
        Text(
          text,
          style: TextStyleClass.normalStyle(
              color: textStyleColor ?? AppColor.greyTextColor),
        )
      ],
    ); */
