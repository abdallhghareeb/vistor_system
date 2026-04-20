import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';

class HomeLocationWidget extends StatelessWidget {
  const HomeLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sharedPreferences.getString('location_name')??LanguageProvider.translate('home', 'location_name'),
            style: TextStyleClass.semiHeadStyle(color: AppColor.defaultColor),),
          InkWell(
            onTap: (){
            },
            child: Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.defaultColor,
              ),
              child: SvgWidget(svg: Images.edit,width: 6.w,),
            ),
          ),
        ],
      ),
    );
  }
}
