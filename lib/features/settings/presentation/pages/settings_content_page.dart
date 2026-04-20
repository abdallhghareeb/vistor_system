import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class SettingsContentPage extends StatelessWidget {
  const SettingsContentPage({super.key,required this.element});
  final Map<String,dynamic> element;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar : AppBar(title: Text(LanguageProvider.translate("settings", element['title'])),),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h,),
                  child: Text(LanguageProvider.translate("settings", element['content'],),
                    style: TextStyleClass.captionStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
