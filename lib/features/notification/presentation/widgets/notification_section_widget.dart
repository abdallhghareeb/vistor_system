import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';
import '../../domain/entities/notification_entity.dart';
import '../provider/notification_provider.dart';
import 'notification_widget.dart';

class NotificationSectionWidget extends StatelessWidget {
  final String title;
  final List<NotificationEntity> notifications;
  final NotificationProvider notificationProvider;

  const NotificationSectionWidget({
    required this.title,
    required this.notifications,
    required this.notificationProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleClass.normalStyle(color: const Color(0xff68727D)),
        ),
        SizedBox(height: 1.h),
        Wrap(
          children: List.generate(notifications.length, (index) {
            final notification = notifications[index];
            return NotificationWidget(
              message: notification.description,
              time: notification.createdAt,
              tone: NotificationTone.values[index % 3],
              onTap: () {
                notificationProvider.goToNotificationDetailsPage(
                  title: notification.title,
                  data: notification.description,
                  id: notification.id,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
