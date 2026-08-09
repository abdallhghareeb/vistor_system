import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class VisitorsSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  const VisitorsSearchWidget({
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.5.h,
      decoration: BoxDecoration(
        color: const Color(0xffF2F4F5),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyleClass.captionStyle(
                color: AppColor.defaultBlackColor,
              ),
              decoration: InputDecoration(
                hintText: LanguageProvider.translate('visitors', 'search'),
                hintStyle: TextStyleClass.smallStyle(
                  color: const Color(0xff8B959D),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: const Color(0xff89949C),
                  size: 4.5.w,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 1.4.h),
              ),
            ),
          ),
          Container(
            width: 13.w,
            height: double.infinity,
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Color(0xffE0E4E7))),
            ),
            child: IconButton(
              onPressed: onFilterTap,
              icon: Icon(
                Icons.tune_rounded,
                color: const Color(0xff87929A),
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
