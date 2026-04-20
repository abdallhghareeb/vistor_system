import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../history/presentation/provider/history_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/main_page_provider.dart';

class GeneralLookWidget extends StatelessWidget {
  const GeneralLookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    HistoryProvider historyProvider = Provider.of<HistoryProvider>(context);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("${LanguageProvider.translate("home", "overview")} ",
              maxLines: 1,style: TextStyleClass.normalStyle(color: Colors.white),)),
            InkWell(
                onTap: (){
                  mainProvider.setIndex(1);
                },
                child: Text(LanguageProvider.translate("home", "see_all"),style: TextStyleClass.smallStyle(color: Colors.white),)),
          ],
        ),
        SizedBox(height: 2.h,),
        Container(padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
              color: Color(0xff5182EF),borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${historyProvider.myWorkEntity?.hoursSummary.today??""}",
                            style:  TextStyleClass.semiHeadStyle(color: Colors.white,).copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: LanguageProvider.translate("home", "hours"),
                            style: TextStyleClass.smallStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Text(LanguageProvider.translate("home", "today"),style: TextStyleClass.smallStyle(color: Colors.white),),
                  ],
                ),
              ),
              Container(color: Colors.white,height: 4.h,width: 0.2.w,margin: EdgeInsets.symmetric(horizontal: 4.w),),
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${historyProvider.myWorkEntity?.hoursSummary.thisWeek??""}",
                            style:  TextStyleClass.semiHeadStyle(color: Colors.white,).copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: LanguageProvider.translate("home", "hours"),
                            style: TextStyleClass.smallStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Text(LanguageProvider.translate("home", "this_week"),style: TextStyleClass.smallStyle(color: Colors.white),),
                  ],
                ),
              ),
              Container(color: Colors.white,height: 4.h,width: 0.2.w,margin: EdgeInsets.symmetric(horizontal: 4.w),),
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${historyProvider.myWorkEntity?.hoursSummary.thisMonth??""}",
                            style:  TextStyleClass.semiHeadStyle(color: Colors.white,).copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: LanguageProvider.translate("home", "hours"),
                            style: TextStyleClass.smallStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Text(LanguageProvider.translate("home", "this_month"),style: TextStyleClass.smallStyle(color: Colors.white),),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h,),

      ],
    );
  }
}
