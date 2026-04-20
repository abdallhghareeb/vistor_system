import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/complete_data_provider.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final completeDataProvider = Provider.of<CompleteDataProvider>(context, listen: false,);
    return SafeArea(
      child: Scaffold(backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(title: Text(LanguageProvider.translate("settings", "update_profile")),),
        body: Form(
          key: completeDataProvider.formKey,
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
                        ListTextFieldWidget(
                          color: Colors.white,
                          borderRadius: 12,
                          inputs: completeDataProvider.passwordInputs,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                child: ButtonWidget(
                  text: "update_password",
                  onTap: () {
                    if(completeDataProvider.formKey.currentState!.validate()){
                      completeDataProvider.updateProfileButton(updatePassword: true);
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
