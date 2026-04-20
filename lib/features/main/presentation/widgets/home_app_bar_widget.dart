import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'check_button_widget.dart';
import 'home_top_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            HomeTopWidget(),
          ],
        ),
        Container(alignment: Alignment.topCenter,
          padding:EdgeInsets.only(top: 38.h),
          child: CheckButtonWidget(),
        ),

      ],
    );
  }
}
