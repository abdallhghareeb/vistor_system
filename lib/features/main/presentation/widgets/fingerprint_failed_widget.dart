import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';

class FingerprintFailedWidget extends StatelessWidget {
  const FingerprintFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Text(LanguageProvider.translate("home", "fingerprint_failed"),
            style: TextStyleClass.smallStyle().copyWith(fontWeight: FontWeight.bold),),
          SizedBox(height: 1.h,),
          Text(LanguageProvider.translate("home", "use_camera"),textAlign: TextAlign.center,
            style: TextStyleClass.normalStyle(color: AppColor.defaultColor).copyWith(fontWeight: FontWeight.bold),),
          SizedBox(height: 2.h,),
          Container(width: 30.w,height: 30.w,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.faceId),fit: BoxFit.cover)),
          ),
          SizedBox(height: 4.h,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            InkWell(
              onTap: (){navPop();},
              child: Text(LanguageProvider.translate("buttons", "cancel"),
                style: TextStyleClass.normalStyle(color: AppColor.defaultColor).copyWith(fontWeight: FontWeight.bold),),
            ),

            ButtonWidget(takeSmallestWidth: true,onTap: (){}, text: "confirm",height: 4.h,),
          ],),
        ],
      ),
    );
  }
}
