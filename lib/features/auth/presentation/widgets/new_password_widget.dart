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

class NewPasswordWidget extends StatelessWidget {
  const NewPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordProvider resetPasswordProvider = Provider.of(context);
    return SafeArea(
      child: Form(
        key: resetPasswordProvider.changeFormKey,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
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
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LanguageProvider.translate("auth", "create_password_title"),style: TextStyleClass.normalStyle(),),
                      SizedBox(height: 2.h,),
                      Text(LanguageProvider.translate("auth", "create_password_des"),
                        style: TextStyleClass.smallStyle(color: AppColor.labelTextColor),),
                      SizedBox(height: 2.h,),
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
                    ],
                  ),
                ),
                SizedBox(height: 3.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
