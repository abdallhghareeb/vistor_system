import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../history/presentation/provider/check_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';

class InZoneWidget extends StatelessWidget {
  const InZoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 100.w,height: 3.h,
              child: Stack(alignment: Alignment.center,
                children: [
                  Container(width: 100.w,height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColor.smallWhite,width: 0.5),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                    ),
                  ),

                  Container(
                    width: 20.w,
                    height: 0.2.h,
                    decoration: BoxDecoration(
                      color: AppColor.smallWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(width: 35.w,height: 35.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(Images.workLocation),fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  SizedBox(height:2.h,),
                  Text(LanguageProvider.translate("home", "in_zone"),
                    style: TextStyleClass.normalStyle(color: AppColor.defaultColor).copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4.h,),
                  ButtonWidget(onTap: (){
                    navPop();
                    CheckProvider checkProvider = Provider.of<CheckProvider>(context,listen: false);
                    checkProvider.checkIn();
                  }, text: "check_in"),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
          ],
        ),
      ),
    );
  }
}
