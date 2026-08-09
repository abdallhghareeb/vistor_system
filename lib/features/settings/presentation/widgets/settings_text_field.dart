import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';

class SettingsTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const SettingsTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.onToggleVisibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleClass.smallStyle(
            color: AppColor.defaultBlackColor,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 0.8.h),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyleClass.smallStyle(color: AppColor.defaultBlackColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyleClass.smallStyle(
              color: Colors.grey.shade500,
            ),
            suffixIcon: onToggleVisibility == null
                ? null
                : IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xffAEB7BE),
                      size: 4.5.w,
                    ),
                  ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.4.h,
            ),
            filled: true,
            fillColor: Colors.white,
            border: _border(const Color(0xffDCE3E8)),
            enabledBorder: _border(const Color(0xffDCE3E8)),
            focusedBorder: _border(AppColor.defaultColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(2.w),
    borderSide: BorderSide(color: color),
  );
}
