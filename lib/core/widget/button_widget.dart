import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  final double? width, height, borderRadius, elevation;
  final void Function() onTap;
  final Color? color, borderColor;
  final String text;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? directionBorderRadius;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool? isGradient;
  final bool widgetAfterText, takeSmallestWidth;
  const ButtonWidget(
      {this.widget,
      this.width,
      this.height,
      this.directionBorderRadius,
      required this.onTap,
      this.borderRadius,
      required this.text,
      this.textStyle,
      this.borderColor,
      this.color,
      this.widgetAfterText = true,
      super.key,
      this.takeSmallestWidth = false,
      this.elevation,
      this.isGradient , this.padding});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: takeSmallestWidth ? null : (width ?? 90.w),
        height: height ?? (Constants.isTablet ? 7.h :6.h),
        decoration: BoxDecoration(
          borderRadius: directionBorderRadius ?? BorderRadius.circular(borderRadius ?? 4),
          color: color ?? AppColor.defaultColor,
          border: borderColor == null || color == null
              ? null
              : Border.all(color: borderColor!),
        ),
        child: Padding(
          padding:padding ?? EdgeInsets.symmetric(horizontal: 2.w,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widgetAfterText) widget ?? const SizedBox(),
              Text(
                LanguageProvider.translate("buttons", text),
                style: textStyle ?? TextStyleClass.buttonStyle(color: Colors.white),
              ),
              if (widgetAfterText) widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
