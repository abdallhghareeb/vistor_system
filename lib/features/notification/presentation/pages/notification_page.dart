import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../widgets/notifications_list_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.defaultColor,
            size: 4.5.w,
          ),
        ),
        title: Text(
          LanguageProvider.translate('notification', 'notification'),
          style: TextStyleClass.normalStyle(
            color: AppColor.defaultColor,
          ).copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: const NotificationsListWidget(),
    );
  }
}
