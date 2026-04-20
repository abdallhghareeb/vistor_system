import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/otp_provider.dart';
import '../providers/reset_password_provider.dart';
import 'custom_otp_field_widget.dart';

class VerificationWidget extends StatelessWidget {
  const VerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordProvider resetPasswordProvider = Provider.of(context);
    OtpProvider otpProvider = Provider.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LanguageProvider.translate("auth", "verification"),style: TextStyleClass.semiHeadStyle(),),
                    SizedBox(height: 2.h,),
                    Text(LanguageProvider.translate("auth", "enter_verification"),
                      style: TextStyleClass.smallStyle(color: AppColor.labelTextColor),),
                    SizedBox(height: 2.h,),
                    const CustomOTPFieldWidget(),
                    SizedBox(height: 3.h,),
                    ButtonWidget(onTap: (){
                      if(otpProvider.otpController.text.length==6){
                        otpProvider.verifyOTP();
                      }
                    }, text: "verify"),
                    SizedBox(height: 2.h,),
                    InkWell(
                      onTap: (){
                        resetPasswordProvider.forgotPassword(isResend : true);
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${LanguageProvider.translate("auth", "retry_send")} ",
                                style: TextStyleClass.normalStyle(color: AppColor.defaultBlackColor,),
                              ),
                              TextSpan(
                                text: LanguageProvider.translate("auth", "resend"),
                                style: TextStyleClass.normalStyle(color: AppColor.defaultColor,).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
            ],
          ),
        ),
      ),
    );
  }
}
