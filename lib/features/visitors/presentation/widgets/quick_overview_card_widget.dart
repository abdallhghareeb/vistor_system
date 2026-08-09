import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/visitor_entity.dart';
import '../providers/visitors_provider.dart';

class QuickOverviewCardWidget extends StatelessWidget {
  final VisitorTransactionEntity transaction;

  const QuickOverviewCardWidget({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final checkedIn = transaction.isCheckIn;
    final color = checkedIn ? const Color(0xff16A34A) : const Color(0xffEF4444);

    return InkWell(
      onTap: (){
        Provider.of<VisitorsProvider>(context, listen: false).showVisitWidget(transaction);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.5.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 11.w,
              height: 11.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Icon(
                checkedIn ? Icons.login_rounded : Icons.logout_rounded,
                color: color,
                size: 5.5.w,
              ),
            ),
            SizedBox(width: 2.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleClass.smallStyle(
                      color: const Color(0xff4B5258),
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    convertDateTimeToStringDMY(transaction.createDate),
                    style: TextStyleClass.smallStyle(
                      color: const Color(0xff75808A),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                LanguageProvider.translate(
                  'visitors',
                  checkedIn ? 'check_in' : 'check_out',
                ),
                style: TextStyleClass.smallStyle(
                  color: color,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
