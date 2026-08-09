import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../../core/widget/upload_image_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: authProvider.regFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          LanguageProvider.translate("auth", "create_account"),
                          style: TextStyleClass.semiHeadStyle(
                            color: AppColor.defaultBlackColor,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          LanguageProvider.translate("auth", "login_des"),
                          style: TextStyleClass.normalStyle(
                            color: AppColor.defaultGrey,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Center(child: UploadImageWidget(fromAuth: true,),),

                        Consumer<AuthProvider>(
                          builder: (context, value, child) =>
                              ListTextFieldWidget(
                                inputs: authProvider.registerInputs,
                                borderRadius: 4,
                              ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ButtonWidget(
                  text: "sign_up",
                  onTap: () {
                    bool isConfirmPassword = authProvider.registerInputs.
                    firstWhere((element) => element.key == "ConfirmPassword",).controller.text ==
                        authProvider.registerInputs.last.controller.text;
                    if (authProvider.regFormKey.currentState!.validate() &&
                        isConfirmPassword) {
                      authProvider.registerButton();
                    } else {
                      authProvider.submitRegisterForm();
                    }
                  },
                ),
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () {
                    navPop();
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${LanguageProvider.translate("auth", "have_account")} ",
                            style: TextStyleClass.smallStyle(
                              color: AppColor.defaultBlackColor,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: LanguageProvider.translate("auth", "sign_in"),
                            style: TextStyleClass.smallStyle(
                              color: AppColor.defaultColor,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
