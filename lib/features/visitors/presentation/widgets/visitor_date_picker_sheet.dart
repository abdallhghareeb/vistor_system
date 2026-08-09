import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../language/presentation/provider/language_provider.dart';

class VisitorDatePickerSheet extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onApply;

  const VisitorDatePickerSheet({
    required this.initialDate,
    required this.onApply,
    super.key,
  });

  @override
  State<VisitorDatePickerSheet> createState() => _VisitorDatePickerSheetState();
}

class _VisitorDatePickerSheetState extends State<VisitorDatePickerSheet> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: const Color(0xffD8D8D8),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: 25.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.mdy,
                initialDateTime: selectedDate,
                minimumDate: DateTime(2020),
                maximumDate: DateTime(2035),
                onDateTimeChanged: (date) => selectedDate = date,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(selectedDate);
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
                child: Text(LanguageProvider.translate('buttons', 'apply')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
