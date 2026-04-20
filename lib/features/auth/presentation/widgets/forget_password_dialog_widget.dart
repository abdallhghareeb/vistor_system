import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/reset_password_provider.dart';

class ForgetPasswordDialogWidget extends StatelessWidget {
  const ForgetPasswordDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordProvider resetPasswordProvider = Provider.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: resetPasswordProvider.formKey,
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 100.w,height: 3.h,
                child: Stack(alignment: Alignment.center,
                  children: [
                    Container(width: 100.w,height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black.withAlpha((0.25*255).round()), spreadRadius: 0,blurRadius: 2,offset: Offset(0,0))
                        // ],
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
                    Text(LanguageProvider.translate("auth", "forget_password_title"),style: TextStyleClass.semiHeadStyle(),),
                    SizedBox(height: 2.h,),
                    Text(LanguageProvider.translate("auth", "forget_password_des"),
                      style: TextStyleClass.smallStyle(color: AppColor.labelTextColor),),
                    SizedBox(height: 2.h,),
                    ListTextFieldWidget(inputs: resetPasswordProvider.resetPasswordInputs,),
                    SizedBox(height: 3.h,),
                    ButtonWidget(onTap: (){
                      if(resetPasswordProvider.formKey.currentState!.validate()){
                        resetPasswordProvider.forgotPassword();
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
    );
  }
}
