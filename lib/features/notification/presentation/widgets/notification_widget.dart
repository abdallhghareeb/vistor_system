import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';

enum NotificationTone {
  visitCreated,
  checkIn,
  checkOut,
  general;

  static NotificationTone fromEventType(int eventType) {
    return switch (eventType) {
      0 => NotificationTone.visitCreated,
      1 => NotificationTone.checkIn,
      2 => NotificationTone.checkOut,
      _ => NotificationTone.general,
    };
  }
}

class NotificationWidget extends StatelessWidget {
  final String message;
  final String time;
  final bool isRead;
  final NotificationTone tone;
  final VoidCallback? onTap;

  const NotificationWidget({
    required this.message,
    required this.time,
    required this.isRead,
    required this.tone,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      NotificationTone.visitCreated => const Color(0xff1473A7),
      NotificationTone.checkIn => const Color(0xff12A85A),
      NotificationTone.checkOut => const Color(0xffF04444),
      NotificationTone.general => const Color(0xff68727D),
    };
    final icon = switch (tone) {
      NotificationTone.visitCreated => Icons.event_available_outlined,
      NotificationTone.checkIn => Icons.login_rounded,
      NotificationTone.checkOut => Icons.logout_rounded,
      NotificationTone.general => Icons.notifications_none_rounded,
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.4.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(2.5.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: isRead ? Colors.transparent : const Color(0xffF3F8FB),
              borderRadius: BorderRadius.circular(2.5.w),
            ),
            child: Row(
              children: [
                Container(
                  width: 11.w,
                  height: 11.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: isRead ? 0.08 : 0.14),
                    borderRadius: BorderRadius.circular(2.5.w),
                  ),
                  child: Icon(icon, color: color, size: 5.5.w),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleClass.smallStyle().copyWith(
                      height: 1.25,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isRead) ...[
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                    ],
                    Text(
                      time,
                      style: TextStyleClass.smallStyle(
                        color: isRead
                            ? const Color(0xffBBC1C6)
                            : const Color(0xff68727D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
