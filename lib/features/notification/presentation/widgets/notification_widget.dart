import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';

enum NotificationTone { info, warning, success }

class NotificationWidget extends StatelessWidget {
  final String message;
  final String time;
  final NotificationTone tone;
  final VoidCallback? onTap;

  const NotificationWidget({
    required this.message,
    required this.time,
    required this.tone,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      NotificationTone.info => const Color(0xff1473A7),
      NotificationTone.warning => const Color(0xffF04444),
      NotificationTone.success => const Color(0xff12A85A),
    };
    final icon = switch (tone) {
      NotificationTone.info => Icons.info_outline_rounded,
      NotificationTone.warning => Icons.warning_amber_rounded,
      NotificationTone.success => Icons.check_circle_outline_rounded,
    };

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            // Container(
            //   width: 11.w,
            //   height: 11.w,
            //   decoration: BoxDecoration(
            //     color: color.withValues(alpha: 0.1),
            //     borderRadius: BorderRadius.circular(2.5.w),
            //   ),
            //   child: Icon(icon, color: color, size: 5.5.w),
            // ),
            // SizedBox(width: 3.w),
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleClass.smallStyle().copyWith(height: 1.25),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              time,
              style: TextStyleClass.smallStyle(color: const Color(0xffBBC1C6)),
            ),
          ],
        ),
      ),
    );
  }
}
