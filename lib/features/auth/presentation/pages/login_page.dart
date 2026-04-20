import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../splash/presentation/provider/select_domain_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/reset_password_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false,);
    return Scaffold(resizeToAvoidBottomInset: false,backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Form(key: authProvider.formKey,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 18.h),
                    Text(
                      LanguageProvider.translate("auth", "login",),
                      style: TextStyleClass.semiHeadStyle(color: AppColor.defaultBlackColor).copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 3.h),
                    Consumer<AuthProvider>(builder: (context, value, child) =>
                        ListTextFieldWidget(inputs: authProvider.loginInputs, borderRadius: 4,),
                    ),
                    SizedBox(height: 1.h),
                    InkWell(
                      onTap: (){
                        Provider.of<ResetPasswordProvider>(context,listen: false).showForgetPasswordDialog();
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            LanguageProvider.translate("auth", "forget_password",),
                            style: TextStyleClass.smallStyle(color: AppColor.labelTextColor).copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ButtonWidget(
                      text: "login",
                      onTap: () {
                        if(authProvider.formKey.currentState!.validate()){
                          authProvider.loginButton();
                        }
                      },
                    ),
                    SizedBox(height: 4.h),
                    InkWell(
                      onTap: (){
                        authProvider.goToRegisterPage();
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${LanguageProvider.translate("auth", "not_have_account")} ",
                              style: TextStyleClass.normalStyle(color: AppColor.defaultBlackColor,),
                            ),
                            TextSpan(
                              text: LanguageProvider.translate("auth", "sign_up"),
                              style: TextStyleClass.normalStyle(color: AppColor.defaultColor,).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    InkWell(
                      onTap: (){
                        Provider.of<SelectDomainProvider>(context,listen: false).removeDomain();
                      },
                      child: Text(
                        LanguageProvider.translate("auth", "select_domain",),
                        style: TextStyleClass.normalStyle(color: AppColor.defaultColor)
                            .copyWith(fontWeight: FontWeight.bold,fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
