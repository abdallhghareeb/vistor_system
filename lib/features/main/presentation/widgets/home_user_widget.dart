import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/core/constants/images.dart';

import '../../../../config/text_style.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final notificationProvider = context.read<NotificationProvider>();
    final name = authProvider.userEntity?.username?.trim();
    final imageUrl = authProvider.userEntity?.pictureUrl;

    return Row(
      children: [
        Container(
          width: 11.w,
          height: 11.w,
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: ClipOval(
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _fallback(),
                  )
                : _fallback(),
          ),
        ),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Text(
            name?.isNotEmpty == true
                ? name!
                : LanguageProvider.translate('home', 'guest'),
            style: TextStyleClass.captionStyle(
              color: Colors.white,
            ).copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ),
        Consumer<NotificationProvider>(builder:
            (BuildContext context, value, Widget?child) {
          return Badge(
            label: Text("${value.unReadNum}"),
            isLabelVisible: value.unReadNum>0 && authProvider.userEntity !=null ,
            child: InkWell(
              onTap: value.goToNotificationPage,
              child: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 6.w,
              ),
            ),
          );
            },

        ),
      ],
    );
  }

  Widget _fallback() => Image.asset(Images.logo, fit: BoxFit.cover,);
}
