import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'check_data_widget.dart';
import 'home_top_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const HomeTopWidget(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 1.5.h,
            child: const CheckDataWidget(),
          ),
        ],
      ),
    );
  }
}
