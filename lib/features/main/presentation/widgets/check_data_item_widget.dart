import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class CheckDataItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const CheckDataItemWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final color = Color(item['color'] as int);

    return Container(
      width: 34.w,
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LanguageProvider.translate('home', item['title']),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleClass.smallStyle(color: const Color(0xff8A9299)),
          ),
          SizedBox(height: 0.7.h),
          Row(
            children: [
              Text(
                item['num'].toString(),
                style: TextStyleClass.smallStyle(
                  color: color,
                ).copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 1.5.w),
              Expanded(
                child: Text(
                  LanguageProvider.translate('home', item['sub_title']),
                  maxLines: 1,
                  style: TextStyleClass.smallStyle(color: color),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
