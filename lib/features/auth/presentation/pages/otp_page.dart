import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/reset_password_provider.dart';
import '../widgets/verification_widget.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordProvider resetPasswordProvider = Provider.of(context);
    return Scaffold(resizeToAvoidBottomInset: false,backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: resetPasswordProvider.changeFormKey,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                VerificationWidget(),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      ListTextFieldWidget(inputs: resetPasswordProvider.newPasswordInputs,),
                      SizedBox(height: 3.h,),
                      ButtonWidget(onTap: (){
                        if(resetPasswordProvider.changeFormKey.currentState!.validate() &&
                            resetPasswordProvider.newPasswordInputs.first.controller.text
                                == resetPasswordProvider.newPasswordInputs.last.controller.text){
                          resetPasswordProvider.resetPassword();
                        }else{
                          if(resetPasswordProvider.newPasswordInputs.first.controller.text
                              != resetPasswordProvider.newPasswordInputs.last.controller.text){
                            showToast(LanguageProvider.translate("validation", "password_not_match"));
                          }
                        }
                      }, text: "submit"),
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

                    ],
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
