import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import 'custom_otp_field_widget.dart';

class VerificationWidget extends StatelessWidget {
  const VerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Text(
                LanguageProvider.translate("auth", "verification"),
                style: TextStyleClass.semiHeadStyle(),
              ),
              SizedBox(height: 2.h),
              Text(
                LanguageProvider.translate("auth", "enter_verification"),
                style: TextStyleClass.smallStyle(
                  color: AppColor.labelTextColor,
                ),
              ),
              SizedBox(height: 2.h),
              const CustomOTPFieldWidget(),
              // SizedBox(height: 3.h,),
              // ButtonWidget(onTap: (){
              //   if(otpProvider.otpController.text.length==6){
              //     otpProvider.verifyOTP();
              //   }
              // }, text: "verify"),
            ],
          ),
        ),
      ),
    );
  }
}
