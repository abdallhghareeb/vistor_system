import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../history/presentation/provider/check_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';

class CheckButtonWidget extends StatelessWidget {
  const CheckButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CheckProvider checkerProvider = Provider.of<CheckProvider>(context);

    return InkWell(
      customBorder: const CircleBorder(),

      onTap: (){
        checkerProvider.checkInAndOut();
      },
      child: Container(width: 45.w,height: 45.w,
        decoration: BoxDecoration(
          color: AppColor.defaultColor,
          boxShadow: [
            BoxShadow(offset: Offset(0, 4),blurRadius: 16,spreadRadius: 0,color: Color(0xff5182EF)),
          ],
          shape: BoxShape.circle,
        ),
        child:Column(
          children: [
            SizedBox(height: 2.h,),
            Container(width: 10.w,height: 10.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Images.fingerPrint,))
              ),
            ),
            SizedBox(height: 1.5.h,),
            Text(LanguageProvider.translate("buttons",checkerProvider.canCheckIn() ?"check_in" : "check_out"),
              style: TextStyleClass.normalStyle(color: Colors.white).copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: 2.5.h,),
            Text(checkerProvider.getAuctionTimeLeft().isNotEmpty ?checkerProvider.getAuctionTimeLeft() : "00:00:00",
              style: TextStyleClass.
              smallStyle(color:checkerProvider.getAuctionTimeLeft().isNotEmpty ? Color(0xffF48282) : Colors.white).
              copyWith(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
