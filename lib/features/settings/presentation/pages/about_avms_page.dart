import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../widgets/settings_app_bar.dart';

class AboutAvmsPage extends StatelessWidget {
  const AboutAvmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(title: 'about_avms'),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AboutSection(
              title: 'about_system',
              body: 'about_system_body',
            ),
            SizedBox(height: 3.h),
            const _AboutSection(title: 'our_mission', body: 'our_mission_body'),
            SizedBox(height: 3.h),
            Text(
              LanguageProvider.translate('settings', 'support_contact'),
              style: TextStyleClass.normalStyle(
                color: AppColor.defaultBlackColor,
              ).copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  '${LanguageProvider.translate('settings', 'support_email')}: '
                  'support@avms.com',
                  style:
                      TextStyleClass.captionStyle(
                        color: AppColor.defaultColor,
                      ).copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.defaultColor,
                      ),
                ),
                SizedBox(width: 1.5.w),
                Icon(
                  Icons.open_in_new_rounded,
                  color: AppColor.defaultColor,
                  size: 3.5.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final String body;

  const _AboutSection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageProvider.translate('settings', title),
          style: TextStyleClass.normalStyle(
            color: AppColor.defaultBlackColor,
          ).copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 1.h),
        Text(
          LanguageProvider.translate('settings', body),
          style: TextStyleClass.captionStyle(
            color: const Color(0xff5E6871),
          ).copyWith(height: 1.7),
        ),
      ],
    );
  }
}
