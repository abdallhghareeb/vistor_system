import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../widgets/settings_app_bar.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(title: 'language'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 3.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(color: const Color(0xffEDF1F4)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1C3550).withValues(alpha: 0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LanguageOption(
                    label: LanguageProvider.translate('settings', 'arabic'),
                    selected: languageProvider.language.languageCode == 'ar',
                    onTap: (){
                      languageProvider.setLanguage(Locale("ar"));
                    },
                  ),
                  const Divider(height: 1, color: Color(0xffEDF1F4)),
                  _LanguageOption(
                    label: LanguageProvider.translate('settings', 'english'),
                    selected: languageProvider.language.languageCode == 'en',
                    onTap: (){
                      languageProvider.setLanguage(Locale("en"));
                    },
                  ),

                ],
              ),
            ),
            SizedBox(height: 5.h,),
            ButtonWidget(onTap: (){
              languageProvider.changeLanguage();
            }, text: "save"),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.5.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyleClass.normalStyle(
                  color: AppColor.defaultColor,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 4.5.w,
              height: 4.5.w,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColor.defaultColor
                      : const Color(0xffAAB4BC),
                  width: 1.5,
                ),
              ),
              child: selected
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColor.defaultColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
