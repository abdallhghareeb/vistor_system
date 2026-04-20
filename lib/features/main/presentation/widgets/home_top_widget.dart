import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import 'general_look_widget.dart';
import 'greeting_widget.dart';
import 'home_user_widget.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:4.w),
      decoration: BoxDecoration(
          color: AppColor.defaultColor,borderRadius: BorderRadius.vertical(bottom: Radius.circular(46))
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeUserWidget(),
          GreetingWidget(),
          GeneralLookWidget(),
        ],
      ),
    );
  }
}
