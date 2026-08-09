import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../language/presentation/provider/language_provider.dart';

class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({
    super.key,
    required this.title,
    required this.data,
  });
  final String title, data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LanguageProvider.translate("notification", "notification"),
          ),
          elevation: 0,
        ),
        body: Container(
          width: 100.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyleClass.normalStyle()),
                SizedBox(height: 1.h),
                Text(
                  data,
                  style: TextStyleClass.smallStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
