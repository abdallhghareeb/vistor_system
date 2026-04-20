import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key,required this.data });
  final Map<String,dynamic>data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        data['onTap']();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffE8EDEC)
        ),
        child:Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( LanguageProvider.translate("settings", data['title']),
                    style: TextStyleClass.normalStyle(color: AppColor.defaultColor),),
                  Text( LanguageProvider.translate("settings", data['description']),
                    style: TextStyleClass.smallStyle(color: Color(0xff6B7280)),),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined,size: 4.w,color: AppColor.defaultColor,)
          ],
        ),
      ),
    );
  }
}
