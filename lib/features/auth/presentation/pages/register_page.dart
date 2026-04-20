import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false,);
    return Scaffold(resizeToAvoidBottomInset: false,backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(key: authProvider.regFormKey,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 3.h),
                      Text(
                        LanguageProvider.translate("auth", "create_account",),
                        style: TextStyleClass.semiHeadStyle(color: AppColor.defaultBlackColor).copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.h),
                      Consumer<AuthProvider>(builder: (context, value, child) =>
                          ListTextFieldWidget(inputs: authProvider.registerInputs, borderRadius: 4,),
                      ),
                      SizedBox(height: 4.h),
                      ButtonWidget(
                        text: "sign_up",
                        onTap: () {
                          if(authProvider.regFormKey.currentState!.validate() &&
                              authProvider.registerInputs[5].controller.text
                                  == authProvider.registerInputs.last.controller.text){
                            authProvider.registerButton();
                          }else{
                            authProvider.submitRegisterForm();
                          }

                        },
                      ),
                      SizedBox(height: 4.h),
                      InkWell(
                        onTap: (){
                          navPop();
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${LanguageProvider.translate("auth", "have_account")} ",
                                style: TextStyleClass.normalStyle(color: AppColor.defaultBlackColor,),
                              ),
                              TextSpan(
                                text: LanguageProvider.translate("auth", "login"),
                                style: TextStyleClass.normalStyle(color: AppColor.defaultColor,).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
