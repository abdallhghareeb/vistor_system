import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';

class HomeActionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeActionWidget({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(2.5.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(2.5.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: Row(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Icon(icon, color: color, size: 5.5.w),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleClass.smallStyle(
                        color: Colors.white,
                      ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      subtitle,
                      style: TextStyleClass.labelStyle(
                        color: Colors.white,
                      ).copyWith(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
