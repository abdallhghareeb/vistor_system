import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../widget/text_field.dart';

void reportDialog({required String title,required String type,required int id}){
  TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    context: Constants.globalContext(), 
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top:Radius.circular(5.w)),
  ),
    builder: (BuildContext context) => SizedBox(
      height: 30.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 5.h,),
          Text(title,style: Constants.isTablet? TextStyleClass.smallStyle(color: Colors.black):  TextStyleClass.smallStyle(color: Colors.black),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: TextFieldWidget(controller: controller,maxLines: 2,
              contentPadding:Constants.isTablet? EdgeInsets.symmetric(vertical: 1.h,horizontal: 0.5.w) :null,
              style: Constants.isTablet? TextStyleClass.smallStyle():  TextStyleClass.smallStyle(color: Colors.black),),
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: (){
                  },
                  icon: Text(LanguageProvider.translate("buttons", "send"),style:  Constants.isTablet? TextStyleClass.smallStyle(color: Colors.red):  TextStyleClass.smallStyle(color: Colors.red),),
                ),
              ),
              SizedBox(width: 2.w,),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Text(LanguageProvider.translate('buttons', 'cancel')
                    ,style:  Constants.isTablet? TextStyleClass.smallStyle(color: Colors.black):  TextStyleClass.smallStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}