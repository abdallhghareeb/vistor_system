import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../visitors/presentation/providers/visitors_provider.dart';
import '../providers/scan_provider.dart';

class ScanSuccessPage extends StatelessWidget {
  const ScanSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanProvider = context.watch<ScanProvider>();
    final invitation = scanProvider.invitation!;
    final transactionDate = scanProvider.transactionDate ?? DateTime.now();
    final isCheckIn =  scanProvider.selectedTransaction == ScanTransactionType.checkIn;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 3.h),
          child: Column(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                padding: EdgeInsets.all(2.w),
                decoration: const BoxDecoration(
                  color: Color(0xffDFF5E8),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff12A85A),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_rounded, color: Colors.white, size: 8.w),
                      Container(width: 5.w, height: 0.3.h, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.5.h),
              Text(
                isCheckIn
                    ? LanguageProvider.translate('scan', 'checked_in_success')
                    : LanguageProvider.translate('scan', 'checked_out_success'),
                textAlign: TextAlign.center,
                style: TextStyleClass.normalStyle(
                  color: const Color(0xff363C42),
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.09),
                      blurRadius: 22,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 11.w,
                          height: 11.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF3F9),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Center(
                            child: Text(
                              '#',
                              style: TextStyleClass.headStyle(
                                color: AppColor.defaultColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.5.w),
                        Expanded(
                          child: _SuccessValue(
                            label: LanguageProvider.translate(
                              'scan',
                              'user_id',
                            ),
                            value: invitation.documentId,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF3F9),
                            borderRadius: BorderRadius.circular(2.5.w),
                          ),
                          child: Text(
                            invitation.areaNames.isEmpty
                                ? '-'
                                : invitation.areaNames,
                            style: TextStyleClass.smallStyle(
                              color: AppColor.defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const Divider(height: 1, color: Color(0xffE8ECEF)),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: _SuccessInfo(
                            icon: Icons.schedule_rounded,
                            label: isCheckIn ? LanguageProvider.translate('scan', 'checked_in_time',) :
                            LanguageProvider.translate('scan', 'checked_out_time',),
                            value: convertDateToTime(transactionDate),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: _SuccessInfo(
                            icon: Icons.calendar_month_outlined,
                            label: isCheckIn
                                ? LanguageProvider.translate(
                                    'scan',
                                    'checked_in_date',
                                  )
                                : LanguageProvider.translate(
                                    'scan',
                                    'checked_out_date',
                                  ),
                            value: convertDateToString(transactionDate),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _returnToDashboard(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.defaultColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 1.7.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                  child: Text(
                    LanguageProvider.translate('scan', 'return_dashboard'),
                    style: TextStyleClass.normalStyle(
                      color: Colors.white,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _returnToDashboard(BuildContext context) async {
    final completeDataProvider = context.read<CompleteDataProvider>();
    final visitorsProvider = context.read<VisitorsProvider>();

    await Future.wait([
      completeDataProvider.getDataReady(),
      visitorsProvider.refreshQuickOverview(),
    ]);
    visitorsProvider.clear();

    if (context.mounted) {
      Navigator.maybePop(context);
    }
  }
}

class _SuccessValue extends StatelessWidget {
  final String label;
  final String value;

  const _SuccessValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleClass.captionStyle(color: const Color(0xff89939B)),
        ),
        SizedBox(height: 0.4.h),
        Text(
          value.isEmpty ? '-' : value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyleClass.normalStyle(
            color: AppColor.defaultColor,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _SuccessInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SuccessInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 9.w,
          height: 9.w,
          decoration: BoxDecoration(
            color: const Color(0xffEAF3F9),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Icon(icon, color: AppColor.defaultColor, size: 4.5.w),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _SuccessValue(label: label, value: value),
        ),
      ],
    );
  }
}
