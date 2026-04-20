import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/images.dart';

class MarkerWidget extends StatelessWidget {
  final GlobalKey? markerKey;
  const MarkerWidget({super.key, this.markerKey});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: markerKey,
      child: Container(
        width: 80.0,
        height: 80.0,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffBBCFF9).withAlpha((0.6 * 255).round()),
        ),
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.defaultColor, width: 1),
            image: const DecorationImage(
                image: AssetImage(Images.logo),
                fit: BoxFit.cover
            ),
          ),
        ),
      ),
    );
  }
}