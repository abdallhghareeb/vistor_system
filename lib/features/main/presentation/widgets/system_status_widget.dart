import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/main_page_provider.dart';
import 'single_status_widget.dart';

class SystemStatusWidget extends StatelessWidget {
  const SystemStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =Provider.of(context);
    return Column(
      children: [
        SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LanguageProvider.translate("home", "system_status"),
                style: TextStyleClass.semiHeadStyle(color: AppColor.defaultColor).copyWith(fontWeight: FontWeight.bold),),
              // Text(LanguageProvider.translate("home", "view_details"),style: TextStyleClass.smallStyle(),),
            ],
          ),
        ),
        SizedBox(height: 2.h,),
        Wrap(spacing: 4.w,runSpacing: 2.h,
          children: List.generate(mainProvider.systemStatus.length,
                (index) => SingleStatusWidget(status: mainProvider.systemStatus[index],),),
        ),
        SizedBox(height: 2.h,),

      ],
    );
  }
}
