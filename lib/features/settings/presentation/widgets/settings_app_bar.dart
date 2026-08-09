import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/features/language/presentation/provider/language_provider.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const SettingsAppBar({
    required this.title,
    this.showBackButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.defaultColor,
                size: 4.w,
              ),
            )
          : null,
      title: Text(
        LanguageProvider.translate("settings", title),
        style: TextStyleClass.normalStyle(
          color: AppColor.defaultColor,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.5.h);
}
