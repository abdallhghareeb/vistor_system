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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              Text(LanguageProvider.translate("auth", "forget_password"),style: TextStyleClass.semiHeadStyle().copyWith(fontWeight: FontWeight.bold),),
              SizedBox(height: 2.h,),
              Text(LanguageProvider.translate("auth", "login_des"),
                style: TextStyleClass.normalStyle(color: AppColor.defaultGrey),),
              SizedBox(height: 2.h,),
              ListTextFieldWidget(inputs: resetPasswordProvider.resetPasswordInputs,),
              SizedBox(height: 3.h,),
              ButtonWidget(onTap: (){
                if(resetPasswordProvider.formKey.currentState!.validate()){
                  resetPasswordProvider.forgotPassword();
                }
              }, text: "send_code"),
            ],
          ),
        ),
      ),
    );
  }
}
