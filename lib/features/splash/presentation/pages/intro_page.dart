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
          body: SizedBox(width: 100.w, height: 100.h,
            child: Stack(
              children: [
                Container(
                  height: 60.h,width: 100.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(splashProvider.intro[splashProvider.index]['image'],),
                            fit: BoxFit.cover),
                        color: Colors.white)
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                      child: splashProvider.skipIntro(),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 4.h,),
                  margin: EdgeInsets.only(top: 55.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              Text(
                                LanguageProvider.translate('intro', splashProvider.intro[splashProvider.index]['title']),
                                style: TextStyleClass.headStyle().copyWith(fontWeight: FontWeight.w500),textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 2.h,),
                              Text(LanguageProvider.translate('intro', splashProvider.intro[splashProvider.index]['body']),
                                style: TextStyleClass.normalStyle(),textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
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
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
