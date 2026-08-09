import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:visitor/core/helper_function/convert.dart';

import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/visitor_entity.dart';

class InvitationDetailsWidget extends StatelessWidget {
  const InvitationDetailsWidget({super.key, required this.transaction});
  final VisitorTransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.5.h),

            Row(
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    _VisitorAvatar(
                      imageUrl: transaction.visitorImage,
                      name: transaction.fullName,
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xff16A34A),
                    ),
                  ],
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.fullName.isEmpty
                            ? LanguageProvider.translate(
                          'visitors',
                          'visitor',
                        )
                            : transaction.fullName,
                        style: TextStyleClass.normalStyle(
                          color: const Color(0xff27313A),
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 0.3.h),
                      Row(
                        children: [
                          Container(
                            width: 1.8.w,
                            height: 1.8.w,
                            decoration: BoxDecoration(
                              color: transaction.isCheckIn ? const Color(0xff16A34A) : const Color(0xffEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Text(transaction.isCheckIn
                                ? LanguageProvider.translate('visitors', 'check_in')
                                : LanguageProvider.translate('visitors', 'check_out'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleClass.normalStyle(
                                color: transaction.isCheckIn ? const Color(0xff16A34A) : const Color(0xffEF4444),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                if(transaction.areaName !=null && transaction.areaName!.isNotEmpty)...[
                  Expanded(
                    child: _VisitorInfo(
                      label: LanguageProvider.translate('scan', 'host_name'),
                      value: transaction.areaName??"",
                    ),
                  ),
                  SizedBox(width: 4.w),
                ],
                Expanded(
                  child: _VisitorInfo(
                    label: LanguageProvider.translate('scan', 'date'),
                    value: convertDateTimeToStringDMY(transaction.createDate),
                  ),
                ),

              ],
            ),
            SizedBox(height: 1.5.h),
          ],
        ),
      ),
    );
  }
}

class _VisitorAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const _VisitorAvatar({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        color: const Color(0xffEAF3F9),
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
        image: hasImage ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover) : null,
      ),
      child: hasImage
          ? null
          : Center(
            child: Text(
                    name.isEmpty ? 'V' : name.substring(0, 1).toUpperCase(),
                    style: TextStyleClass.normalStyle(
            color: AppColor.defaultColor,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
          ),
    );
  }
}

class _VisitorInfo extends StatelessWidget {
  final String label;
  final String value;

  const _VisitorInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
        color: const Color(0xffF6F8FA),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
          ),
          SizedBox(height: 0.6.h),
          Text(
            value.isEmpty ? '-' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleClass.normalStyle(
              color: const Color(0xff3C454D),
            ).copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
