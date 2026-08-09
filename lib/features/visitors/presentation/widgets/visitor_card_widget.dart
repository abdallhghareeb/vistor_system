import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/core/helper_function/convert.dart';
import 'package:visitor/features/visitors/presentation/providers/visitors_provider.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/visitor_entity.dart';

class VisitorCardWidget extends StatelessWidget {
  final VisitorTransactionEntity visitor;

  const VisitorCardWidget({required this.visitor, super.key});

  @override
  Widget build(BuildContext context) {
    final isCheckedIn = visitor.isCheckIn;
    final statusColor = isCheckedIn
        ? const Color(0xff16A34A)
        : const Color(0xffEF4444);

    return InkWell(
      onTap: (){
        Provider.of<VisitorsProvider>(context, listen: false).showVisitWidget(visitor);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.1.h),
        decoration: BoxDecoration(
          color: const Color(0xffF8F9F9),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(color: const Color(0xffF0F2F3)),
        ),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.defaultColor.withValues(alpha: 0.15),
                ),
              ),
              child: ClipOval(
                child:
                    visitor.visitorImage != null &&
                        visitor.visitorImage!.isNotEmpty
                    ? Image.network(
                        visitor.visitorImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _VisitorFallback(name: visitor.fullName);
                        },
                      )
                    : _VisitorFallback(name: visitor.fullName),
              ),
            ),
            SizedBox(width: 2.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    visitor.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleClass.normalStyle(
                      color: AppColor.defaultBlackColor,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 0.4.h),
                  Row(
                    children: [
                      Container(
                        width: 1.5.w,
                        height: 1.5.w,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 1.2.w),
                      Flexible(
                        child: Text(
                          '${LanguageProvider.translate('visitors', isCheckedIn ? 'last_check_in' : 'last_check_out')}: '
                          '${convertDateTimeToStringDMY(visitor.createDate)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleClass.captionStyle(
                            color: const Color(0xff8A949B),
                          ).copyWith(fontSize: 12.5.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.2.w, vertical: 0.6.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                LanguageProvider.translate(
                  'visitors',
                  isCheckedIn ? 'check_in' : 'check_out',
                ),
                style: TextStyleClass.smallStyle(
                  color: statusColor,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisitorFallback extends StatelessWidget {
  final String name;

  const _VisitorFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffEAF3F9),
      child: Center(
        child: Text(
          name.isEmpty ? 'V' : name[0].toUpperCase(),
          style: TextStyleClass.labelStyle(
            color: AppColor.defaultColor,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
