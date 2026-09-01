import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/features/language/presentation/provider/language_provider.dart';
import 'package:visitor/features/scan/presentation/providers/scan_provider.dart';
import 'package:visitor/features/auth/presentation/providers/auth_provider.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../config/theme.dart';
import '../provider/main_page_provider.dart';
import '../widgets/home_action_widget.dart';
import '../widgets/home_app_bar_widget.dart';
import '../../../visitors/presentation/widgets/quick_overview_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: barColor().copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColor.defaultColor,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FA),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBarWidget(),
              if (AuthProvider.isGuestMode()) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(3.5.w, 0, 3.5.w, 1.5.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.5.w,
                      vertical: 1.6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFF4E5),
                      borderRadius: BorderRadius.circular(2.5.w),
                      border: Border.all(color: const Color(0xffF59E0B)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: const Color(0xffD97706),
                          size: 7.w,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            LanguageProvider.translate(
                              'home',
                              'guest_preview_data',
                            ),
                            style:
                                TextStyleClass.normalStyle(
                                  color: const Color(0xff9A5300),
                                ).copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.35,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                child: Column(
                  children: [
                    HomeActionWidget(
                      title: LanguageProvider.translate('home', 'quick_scan'),
                      subtitle: LanguageProvider.translate(
                        'home',
                        'quick_scan_des',
                      ),
                      icon: Icons.qr_code_scanner_rounded,
                      color: AppColor.defaultColor,
                      onTap: () {
                        Provider.of<ScanProvider>(
                          context,
                          listen: false,
                        ).goToScanPage();
                      },
                    ),
                    SizedBox(height: 1.h),
                    HomeActionWidget(
                      title: LanguageProvider.translate(
                        'home',
                        'search_visitor',
                      ),
                      subtitle: LanguageProvider.translate(
                        'home',
                        'search_visitor_des',
                      ),
                      icon: Icons.search_rounded,
                      color: const Color(0xff19B8AA),
                      onTap: () {
                        context.read<MainProvider>().setIndex(1);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                child: Text(
                  LanguageProvider.translate("home", "quick_overview"),
                  style: TextStyleClass.smallStyle(
                    color: AppColor.defaultColor,
                  ).copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 1.5.h),
              const QuickOverviewWidget(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
