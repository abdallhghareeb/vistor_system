import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../history/presentation/provider/history_provider.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/system_status_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: barColor().copyWith(statusBarIconBrightness: Brightness.light,
      statusBarColor: AppColor.defaultColor,
      ),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,extendBodyBehindAppBar: true,extendBody: true,
        body: SizedBox(height: 100.h,width: 100.w,
          child: RefreshIndicator(
            onRefresh: () async {
              Provider.of<HistoryProvider>(context, listen: false).getMyWork();
              Provider.of<AuthProvider>(context,listen:false).getProfile();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBarWidget(),
                  SystemStatusWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}