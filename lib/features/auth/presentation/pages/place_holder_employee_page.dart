import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/auth_provider.dart';

class PlaceHolderEmployeePage extends StatelessWidget {
  const PlaceHolderEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false,);
    return SafeArea(
      child: Scaffold(backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(key: authProvider.formKey,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),

                  Center(
                    child: Text(
                      LanguageProvider.translate("auth", "your_account_in_review",),
                      style: TextStyleClass.normalStyle(color: AppColor.defaultColor,).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ButtonWidget(
                    text: "logout",
                    onTap: () {
                      authProvider.logout();
                    },
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
