import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/visitors_provider.dart';
import 'visitor_date_picker_sheet.dart';

class VisitorsFilterSheet extends StatelessWidget {
  const VisitorsFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VisitorsProvider>();

    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Container(
                width: 10.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: const Color(0xffD8D8D8),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              LanguageProvider.translate('visitors', 'filter_by'),
              style: TextStyleClass.normalStyle(
                color: AppColor.defaultBlackColor,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _DateFilterField(
                    label: LanguageProvider.translate('visitors', 'date_from'),
                    date: provider.dateFrom,
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => VisitorDatePickerSheet(
                        initialDate: provider.dateFrom,
                        maximumDate: provider.dateTo,
                        onApply: provider.selectDateFrom,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _DateFilterField(
                    label: LanguageProvider.translate('visitors', 'date_to'),
                    date: provider.dateTo,
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => VisitorDatePickerSheet(
                        initialDate: provider.dateTo,
                        minimumDate: provider.dateFrom,
                        onApply: provider.selectDateTo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    label: 'today',
                    selected:
                        provider.selectedDatePreset == VisitorDatePreset.today,
                    onTap: () =>
                        provider.selectDatePreset(VisitorDatePreset.today),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _FilterButton(
                    label: 'this_week',
                    selected:
                        provider.selectedDatePreset ==
                        VisitorDatePreset.thisWeek,
                    onTap: () =>
                        provider.selectDatePreset(VisitorDatePreset.thisWeek),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _FilterButton(
                    label: 'this_month',
                    selected:
                        provider.selectedDatePreset ==
                        VisitorDatePreset.thisMonth,
                    onTap: () =>
                        provider.selectDatePreset(VisitorDatePreset.thisMonth),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    label: 'check_in',
                    selected: provider.selectedStatuses.contains(
                      VisitorStatus.checkedIn,
                    ),
                    onTap: () => provider.toggleStatus(VisitorStatus.checkedIn),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _FilterButton(
                    label: 'check_out',
                    selected: provider.selectedStatuses.contains(
                      VisitorStatus.checkedOut,
                    ),
                    onTap: () =>
                        provider.toggleStatus(VisitorStatus.checkedOut),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: provider.resetFilters,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.defaultColor,
                      side: BorderSide(color: AppColor.defaultColor),
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                    child: Text(
                      LanguageProvider.translate('buttons', 'reset_all'),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      provider.applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.defaultColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                    child: Text(
                      '${LanguageProvider.translate('buttons', 'apply_filters')} '
                      '(${provider.selectedFilterCount})',
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateFilterField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateFilterField({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = date == null
        ? null
        : '${date!.day}-${date!.month}-${date!.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleClass.normalStyle(
            color: AppColor.defaultBlackColor,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 0.8.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(2.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.4.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD7DEE3)),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    formattedDate ??
                        LanguageProvider.translate('visitors', 'select_date'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleClass.normalStyle(
                      color: formattedDate == null
                          ? const Color(0xff9CA1AA)
                          : AppColor.defaultBlackColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColor.defaultColor,
                  size: 4.5.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? AppColor.defaultColor : Colors.white,
        foregroundColor: selected ? Colors.white : AppColor.defaultColor,
        side: BorderSide(
          color: selected ? AppColor.defaultColor : const Color(0xffCBD5DC),
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
      ),
      child: Text(
        LanguageProvider.translate('visitors', label),
        maxLines: 1,
        style: TextStyleClass.smallStyle(
          color: selected ? Colors.white : AppColor.defaultColor,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
