import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_color.dart';
import '../constants/constants.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({super.key, required this.selected,});
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.isTablet?4.w:4.w,
      height: Constants.isTablet?4.w:4.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color:selected?AppColor.defaultColor:Colors.grey.shade400,width: 1.5),

      ),
      padding: EdgeInsets.all(0.7.w),
      child: Container(
        decoration: BoxDecoration(
          color: selected?null:Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
