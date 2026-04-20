import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/settings_provider.dart';
import '../widgets/setting_widget.dart';
import '../widgets/top_settings_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar : AppBar(title: Text(LanguageProvider.translate("home", "settings")),),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: TopSettingsWidget()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h,),
                  child: Text(
                    LanguageProvider.translate("settings", "general",),
                    style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15),),
                  child: Wrap(runSpacing: 1.h,
                    children: List.generate(settingsProvider.generalSettings.length,
                          (index) => SettingWidget(data: settingsProvider.generalSettings[index],),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h,),
                  child: Text(LanguageProvider.translate("settings", "support",),
                    style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Wrap(runSpacing: 1.h,
                    children: List.generate(
                      settingsProvider.supportSettings.length,
                          (index) => SettingWidget(data: settingsProvider.supportSettings[index],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
