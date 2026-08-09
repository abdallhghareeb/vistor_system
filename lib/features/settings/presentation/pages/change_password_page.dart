import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../widgets/settings_app_bar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompleteDataProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(title: 'change_password'),
      body: Form(
        key: provider.changePasswordFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 3.h),
          child: Column(
            children: [
              ListTextFieldWidget(
                color: Colors.white,
                borderRadius: 12,
                inputs: provider.changePasswordInputs,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.changePasswordFormKey.currentState!.validate()) {
                     provider.changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.defaultColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                  child: Text(LanguageProvider.translate('buttons', 'save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
