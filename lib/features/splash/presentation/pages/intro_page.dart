import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/splash_provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splashProvider, _) {
      return SafeArea(
        top: false,
        child: Scaffold(
          body: Container(width: 100.w,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(splashProvider.intro[splashProvider.index]['image'],),fit: BoxFit.cover),
                color: Colors.white), height: 100.h,
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                      child: splashProvider.skipIntro(),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        LanguageProvider.translate('intro', splashProvider.intro[splashProvider.index]['title']),
                        style: TextStyleClass.headStyle(color:Colors.white).copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(LanguageProvider.translate('intro', splashProvider.intro[splashProvider.index]['body']),
                        style: TextStyleClass.smallStyle(color:Colors.white),),
                      SizedBox(height: 4.h),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              splashProvider.intro.length, (i) => Expanded(
                                child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.5.w,),
                                child: Container(height: 1.w,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        color:splashProvider.index >=i ? AppColor.defaultColor :Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(2.w)))
                                ),
                              )
                          )
                      ),
                      SizedBox(height: 3.h),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (splashProvider.index > 0)
                            InkWell(
                              onTap: () {
                                splashProvider.decrementSelect();
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Container(
                                      height: 6.h, width: 6.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                          color: AppColor.defaultColor),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(LanguageProvider.isAr()?
                                            Icons.arrow_forward_ios_outlined : Icons.arrow_back_ios_outlined,
                                            size: 5.w,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Expanded(
                            child: ButtonWidget(
                              text: "next",height: 6.h,
                              onTap: (){splashProvider.incrementSelect();},),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
              ],
            ),
          ),
        ),
      );
    });
  }
}
