import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/config/text_style.dart';
import 'package:visitor/features/auth/presentation/providers/complete_data_provider.dart';
import 'package:visitor/features/language/presentation/provider/language_provider.dart';
import '../../../../config/app_color.dart';
import 'home_user_widget.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CompleteDataProvider completeDataProvider = Provider.of(context);

    return Container(
      width: double.infinity,
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 3.5.w),
      color: AppColor.defaultColor,
      child: Column(
        children: [
          SizedBox(height: 2.h),
          const HomeUserWidget(),
          SizedBox(height: 4.h),
          Text(completeDataProvider.totalVisitors.toString(),
            style: TextStyleClass.headStyle(
              color: Colors.white,
            ).copyWith(fontSize: 26.sp, fontWeight: FontWeight.bold, height: 1),
          ),
          Text(
            LanguageProvider.translate('home', 'total_visitors'),
            style: TextStyleClass.smallStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
