import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/list_text_field.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/add_excuse_provider.dart';
import 'excuse_add_files_widget.dart';

class AddExcuseDialogWidget extends StatelessWidget {
  const AddExcuseDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AddExcuseProvider addExcuseProvider = Provider.of(context);
    return SafeArea(
      child: Form(
        key: addExcuseProvider.formKey,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                    child: Column(
                      children: [
                        SizedBox(height: 3.h,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(LanguageProvider.translate("home", "add_excuse"),
                            style: TextStyleClass.normalStyle().copyWith(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: (){navPop();},
                            child: Container(padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE9EFFD),
                              ),
                              child: Icon(Icons.close,size: 6.w,color: AppColor.defaultColor,),
                            ),
                          ),
                        ],),
                        SizedBox(height: 1.h,),
                        ListTextFieldWidget(inputs: addExcuseProvider.addExcuseFields,required:true,
                          color: Colors.white,labelColor: Colors.white,),
                        SizedBox(height: 2.h,),
                        ExcuseAddFilesWidget(),
                        SizedBox(height: 2.h,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color:Color(0xffA7A7A7,),blurRadius: 16,spreadRadius: 0,offset: Offset(0, -4)),
                      ]
                  ),
                  child: ButtonWidget(onTap: (){
                    if(addExcuseProvider.formKey.currentState!.validate()){
                      addExcuseProvider.createExcuse();
                    }
                  }, text: "apply_excuse")),
            ],
          ),
        ),
      ),
    );
  }
}
