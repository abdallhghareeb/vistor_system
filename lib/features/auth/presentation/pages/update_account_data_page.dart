import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/complete_data_provider.dart';

class UpdateAccountDataPage extends StatelessWidget {
  const UpdateAccountDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final completeDataProvider = Provider.of<CompleteDataProvider>(context, listen: false,);
    return SafeArea(
      child: Scaffold(backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(title: Text(LanguageProvider.translate("settings", "update_profile")),),
        body: Form(
          key: completeDataProvider.resetPasswordFormKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        // Center(child: UploadImageWidget(fromAuth: completeDataProvider.fromAuthRegister,)),
                        // SizedBox(height: 2.h),
                        ListTextFieldWidget(
                          color: Colors.white,
                          borderRadius: 12,
                          inputs: completeDataProvider.registerInputs,
                        ),
                        SizedBox(height: 2.h),

                        InkWell(
                            onTap: (){
                              completeDataProvider.goToResetPasswordPage();
                            },
                            child: Text(LanguageProvider.translate("auth", "reset_password"),
                              style: TextStyleClass.normalStyle(color: AppColor.defaultColor),))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                child: ButtonWidget(
                  text: "update_data",
                  onTap: () {
                    if(completeDataProvider.resetPasswordFormKey.currentState!.validate()){
                      completeDataProvider.updateProfileButton(updatePassword: false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
