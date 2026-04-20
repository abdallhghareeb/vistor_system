import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/attendance_entity.dart';

class SingleHistoryWidget extends StatelessWidget {
  const SingleHistoryWidget({super.key, required this.attendance});
  final AttendanceEntity attendance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.smallWhite),
      ),
      child: Column(
        children: [
          Row(children: [
            Container(width: 1.w,height: 3.h,
              decoration: BoxDecoration(color: Color(0xff1A46A7),
                borderRadius: BorderRadius.circular(16)
              ),
            ),
            SizedBox(width: 2.w,),
            Text(convertDateTimeToHistoryForm(DateTime.parse(attendance.date)),style: TextStyleClass.normalStyle().copyWith(fontWeight: FontWeight.w500),),
          ],),
          SizedBox(height: 1.h,),
          Row(spacing: 2.w,
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                          decoration: BoxDecoration(
                              color: Color(0xffE9EFFD),borderRadius: BorderRadius.circular(4)
                          ),
                          child: SvgWidget(svg: Images.status,width: 4.w,)),
                      SizedBox(width: 1.w,),
                      Text(LanguageProvider.translate("history", "status"),
                        style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),),
                    ],),
                    SizedBox(height: 1.h,),
                    Text(LanguageProvider.translate("history", attendance.status),
                      style: TextStyleClass.captionStyle(color: Color(0xff149443)).copyWith(fontWeight: FontWeight.w500),),

                  ],
                ),

              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: Color(0xffE8F6ED),borderRadius: BorderRadius.circular(4)
                          ),
                          child: SvgWidget(svg: Images.presence,width: 4.w,)),
                      SizedBox(width: 1.w,),
                      Text(LanguageProvider.translate("history", "presence"),
                        style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),),
                    ],),
                    SizedBox(height: 1.h,),
                    Text(attendance.checkInTime !=null ?attendance.checkInTime!: "--",
                      style: TextStyleClass.captionStyle(),),
                  ],
                ),

              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                          decoration: BoxDecoration(
                              color: Color(0xffFDECEC),borderRadius: BorderRadius.circular(4)
                          ),
                          child: SvgWidget(svg: Images.exit,width: 4.w,)),
                      SizedBox(width: 1.w,),
                      Text(LanguageProvider.translate("history", "exit"),
                        style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),),
                    ],),
                    SizedBox(height: 1.h,),
                    Text(attendance.checkOutTime !=null ?attendance.checkOutTime! : "--",style: TextStyleClass.captionStyle(),),

                  ],
                ),

              ),

            ],
          ),
          SizedBox(height: 1.h,),

          Container(width: 100.w,height: 0.3.h,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),color: Color(0xffBBCFF9),
          ),),
          SizedBox(height: 1.h,),

          Row(spacing: 1.w,
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                          decoration: BoxDecoration(
                              color: Color(0xffE7F6FD),borderRadius: BorderRadius.circular(4)
                          ),
                          child: SvgWidget(svg: Images.workTime,width: 4.w,)),
                      SizedBox(width: 1.w,),
                      Expanded(child: Text(LanguageProvider.translate("history", "work_time"),
                        style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),)),
                    ],),
                    SizedBox(height: 1.h,),

                    Text(attendance.workTime??"--",style: TextStyleClass.captionStyle(),),

                  ],
                ),

              ),
              // Expanded(
              //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(children: [
              //         Container(
              //             padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
              //             decoration: BoxDecoration(
              //                 color: Color(0xffFFFAEC),borderRadius: BorderRadius.circular(4)
              //             ),
              //             child: SvgWidget(svg: Images.overTime,width: 4.w,)),
              //         SizedBox(width: 1.w,),
              //         Expanded(child: Text(LanguageProvider.translate("history", "over_time"),
              //           style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),)),
              //       ],),
              //       SizedBox(height: 1.h,),
              //
              //       Text("5:00-6:00",style: TextStyleClass.captionStyle(),),
              //     ],
              //   ),
              //
              // ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(backgroundColor:attendance.totalWorkMinutes!>2222? Color(0xff6B7280):Colors.grey ,radius: 10.sp,),
                      SizedBox(width: 1.w,),
                      Text(LanguageProvider.translate("history", "note"),
                        style: TextStyleClass.captionStyle(color: AppColor.labelTextColor),),
                    ],),
                    SizedBox(height: 1.h,),

                    Container(padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.1.h),
                        decoration: BoxDecoration(
                          color: Color(0xffFDECEC),border: Border.all(color:attendance.isLate? Colors.red:Colors.grey ,width: 2),
                          borderRadius: BorderRadius.circular(32)
                        ),
                        child: Text(LanguageProvider.translate("history",attendance.isLate? "late" :"NA"),
                          style: TextStyleClass.captionStyle(color: attendance.isLate? Colors.red:Colors.grey)
                              .copyWith(fontWeight: FontWeight.bold),)),

                  ],
                ),

              ),

            ],
          ),

        ]
      ),
    );
  }
}