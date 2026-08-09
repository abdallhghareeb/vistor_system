import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/features/settings/presentation/provider/settings_provider.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsTileData> items;

  const SettingsSection({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Text(
            LanguageProvider.translate('settings', title),
            style: TextStyleClass.normalStyle(color: const Color(0xff7A858E)),
          ),
        ),
        SizedBox(height: 0.8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(color: const Color(0xffEDF1F4)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1C3550).withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  SettingsTile(data: items[index]),
                  if (index != items.length - 1)
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 4.w),
                      child: const Divider(height: 1, color: Color(0xffEDF1F4)),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class SettingsTileData {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool version;

  const SettingsTileData({
    required this.title,
    required this.icon,
    required this.onTap,
    this.version = false,
  });
}

class SettingsTile extends StatelessWidget {
  final SettingsTileData data;

  const SettingsTile({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(3.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.3.h),
        child: Row(
          children: [
            Container(
              width: 9.w,
              height: 9.w,
              decoration: BoxDecoration(
                color: const Color(0xffEAF3F9),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Icon(data.icon, color: AppColor.defaultColor, size: 4.5.w),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                LanguageProvider.translate('settings', data.title),
                style: TextStyleClass.smallStyle(
                  color: AppColor.defaultColor,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            if(!data.version)
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.defaultColor,
              size: 3.5.w,
            ),
            if(data.version)
              Text(settingsProvider.version,style: TextStyleClass.normalStyle(color: AppColor.defaultColor),),
          ],
        ),
      ),
    );
  }
}
