import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class EmptyAnimation extends StatelessWidget {
  const EmptyAnimation({super.key,  this.width,  this.height, required this.title, required this.gif, this.aboveText});
  final double? width;
  final double? height;
  final String title;
  final String gif;
  final bool? aboveText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        if(aboveText !=null &&aboveText!)
          Text(
            LanguageProvider.translate("empty", title),style: TextStyleClass.headStyle(),
          ),
        SizedBox(height: 1.h,),
        Lottie.asset(gif, fit: BoxFit.cover,width:width,height:height ),
        SizedBox(height: 1.h,),
        if(aboveText ==null)
          Text(
          LanguageProvider.translate("empty", title),style: TextStyleClass.headStyle(),
        ),
      ],
    );
  }
}
