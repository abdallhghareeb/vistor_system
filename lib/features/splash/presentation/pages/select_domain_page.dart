import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/select_domain_provider.dart';

class SelectDomainPage extends StatelessWidget {
  const SelectDomainPage({super.key,});
  @override
  Widget build(BuildContext context) {
    SelectDomainProvider selectDomainProvider = Provider.of<SelectDomainProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Container(height: 100.h,width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h,),
                TextFieldWidget(controller: selectDomainProvider.codeController,
                  label: LanguageProvider.translate("auth", "select_domain"),
                  ),
                SizedBox(height: 5.h,),

                Center(
                  child: ButtonWidget(width: 50.w,
                    onTap: (){
                      if(selectDomainProvider.codeController.text.isNotEmpty){
                        selectDomainProvider.getDomain();
                      }else{
                        showToast(LanguageProvider.translate("auth", "select_domain"));
                      }
                    },
                    text: "save",
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}