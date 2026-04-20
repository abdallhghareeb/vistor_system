import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';

class SingleStatusWidget extends StatelessWidget {
  const SingleStatusWidget({super.key, required this.status});
  final Map<String,dynamic> status;
  @override
  Widget build(BuildContext context) {
    return Container(width: 45.w,
      decoration: BoxDecoration(color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0,30),color: Color(0xffA7A7A7).withAlpha((0.3*255).round()),
              spreadRadius: 0,blurRadius: 60),
        ]
      ),
      child: Column(
        children: [
          SizedBox(height: 1.h,),
          Container(padding: EdgeInsets.all(0.1.w),width: 10.w,height: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,color: Color(0xffE9EFFD)
            ),
            child: SvgWidget(svg:status['image'],width: 7.w, ),
          ),
          SizedBox(height: 1.h,),
          Text(LanguageProvider.translate("home", status['title']),style: TextStyleClass.captionStyle(color: Color(0xff3B3F46)),),
          SizedBox(height: 0.5.h,),
          Text(LanguageProvider.translate("home", status['value']),style: TextStyleClass.smallStyle(color: status['color']),),
          SizedBox(height: 0.5.h,),
        ],
      ),
    );
  }
}
