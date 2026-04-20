import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../history/presentation/provider/check_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
// import '../../../settings/presentation/provider/settings_provider.dart';
import '../provider/location_provider.dart';

class BottomMapSheetWidget extends StatelessWidget {
  const BottomMapSheetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of(context);
    // SettingsProvider settingsProvider = Provider.of(context);
    // final distance = locationProvider.calculateDistanceInMeters(locationProvider.lat??0, locationProvider.lng??0,
    //   settingsProvider.zones.last.latitude.toDouble(), settingsProvider.zones.last.longitude.toDouble(),);
    CheckProvider checkerProvider = Provider.of<CheckProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.smallWhite,width: 0.5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 100.w,height: 3.h,
                child: Stack(alignment: Alignment.center,
                  children: [
                    Container(width: 100.w,height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.smallWhite,width: 0.5),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                      ),
                    ),
                    // Text("$distance",),
                    Container(
                      width: 20.w,
                      height: 0.2.h,
                      decoration: BoxDecoration(
                        color: AppColor.smallWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Color(0xff1A46A7),
                        border: Border.all(color: AppColor.smallWhite,width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LanguageProvider.translate("location",locationProvider.didInsideZone()??false? "inside_work" : "outside_work"),
                                  style: TextStyleClass.normalStyle(color: Colors.white).copyWith(fontWeight: FontWeight.bold),),
                                Text(LanguageProvider.translate("location",locationProvider.didInsideZone()??false? "inside_work_des" : "outside_work_des"),
                                  style: TextStyleClass.smallStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          Container(width: 12.w,height: 12.w,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(locationProvider.didInsideZone()??false? Images.insideZone : Images.outsideZone),fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    ButtonWidget(height: 5.h,onTap: (){
                      checkerProvider.checkInAndOut();
                    }, text:checkerProvider.canCheckIn() ?"check_in_now" : "check_out_now"),
                    SizedBox(height: 2.h,),
                    ButtonWidget(height: 5.h,onTap: (){
                      locationProvider.getCurrentLocation();
                    }, text: "refresh_location",borderColor: AppColor.defaultColor,color: Colors.white,
                    textStyle: TextStyleClass.buttonStyle(color: AppColor.defaultColor),),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
            ],
          ),
        ),
      ),
    );
  }
}
