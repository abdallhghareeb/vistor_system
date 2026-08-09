import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_animation_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/notification_provider.dart';
import 'notification_section_widget.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();

    return Builder(
      builder: (context) {
        if (notificationProvider.notifications == null) {
          return Center(
            child: LoadingAnimationWidget(
              gif: LottiePaths.loading,
              width: 20.w,
              height: 5.h,
              topPadding: 0,
            ),
          );
        } else if (notificationProvider.notifications!.isEmpty) {
          return Center(
            child: EmptyAnimation(
              title: '',
              gif: LottiePaths.noSearch,
              width: 45.w,
              height: 18.h,
            ),
          );
        }

        final notifications = notificationProvider.notifications!;
        final splitAt = notifications.length > 3 ? 3 : notifications.length;

        return ListView(
          controller: notificationProvider.controller,
          padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
          children: [
            NotificationSectionWidget(
              title: LanguageProvider.translate('notification', 'today'),
              notifications: notifications.take(splitAt).toList(),
              notificationProvider: notificationProvider,
            ),
            if (notifications.length > splitAt) ...[
              SizedBox(height: 2.5.h),
              NotificationSectionWidget(
                title: LanguageProvider.translate('notification', 'last_days'),
                notifications: notifications.skip(splitAt).toList(),
                notificationProvider: notificationProvider,
              ),
            ],
            if (notificationProvider.paginationStarted) const LoadingWidget(),
          ],
        );
      },
    );
  }
}
