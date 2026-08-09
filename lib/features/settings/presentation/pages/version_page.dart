import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../widgets/settings_app_bar.dart';

class VersionPage extends StatelessWidget {
  const VersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(title: 'version'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VersionLine(
              text:
                  '${LanguageProvider.translate('settings', 'version')} 1.0.0',
            ),
            SizedBox(height: 1.2.h),
            _VersionLine(
              text:
                  '${LanguageProvider.translate('settings', 'last_updated')}: '
                  '${LanguageProvider.translate('months', 'feb')} 2026',
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionLine extends StatelessWidget {
  final String text;

  const _VersionLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 1.2.w,
          height: 1.2.w,
          decoration: BoxDecoration(
            color: AppColor.defaultColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          text,
          style: TextStyleClass.normalStyle(
            color: AppColor.defaultColor,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
