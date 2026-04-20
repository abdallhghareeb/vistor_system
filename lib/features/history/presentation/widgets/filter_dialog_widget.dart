import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/history_provider.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryProvider historyProvider =Provider.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      width: 8.w,
                      height: 0.5.h,
                      decoration: BoxDecoration(
                        color: AppColor.smallWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h,),

              Text(LanguageProvider.translate("history", "filter_by"),
                style: TextStyleClass.normalStyle(color: AppColor.defaultColor).
                copyWith(fontWeight: FontWeight.bold),),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      historyProvider.changeFilterView(isDay: true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: historyProvider.isDay? AppColor.defaultColor : null,
                          border: Border.all(color:! historyProvider.isDay? Color(0xffBBBEC5):Colors.transparent)
                      ),
                      child: Row(
                        children: [
                          SvgWidget(svg: Images.check,width: 3.w,color:historyProvider.isDay? Colors.green:Color(0xffBBBEC5),),
                          SizedBox(width: 2.w,),
                          Text(LanguageProvider.translate("history", "days"),
                            style: TextStyleClass.smallStyle(color:!historyProvider.isDay? Color(0xffBBBEC5):Colors.white,).
                            copyWith(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  InkWell(
                    onTap: (){
                      historyProvider.changeFilterView(isDay: false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: !historyProvider.isDay? AppColor.defaultColor : null,
                          border: Border.all(color: historyProvider.isDay? Color(0xffBBBEC5):Colors.transparent)
                      ),
                      child: Row(
                        children: [
                          SvgWidget(svg: Images.check,width: 3.w,color:!historyProvider.isDay? Colors.green:Color(0xffBBBEC5),),
                          SizedBox(width: 2.w,),
                          Text(LanguageProvider.translate("history", "month"),
                            style: TextStyleClass.smallStyle(color:historyProvider.isDay? Color(0xffBBBEC5):Colors.white,).
                            copyWith(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              if(historyProvider.isDay)
                SizedBox(width: 100.w,height: 30.h,
                  child: SfDateRangePicker(
                  onSelectionChanged: (s){
                    if(s.value.endDate !=null){
                      historyProvider.changeDateRange(start: s.value.startDate,end: s.value.endDate);
                    }
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                  showNavigationArrow: true,
                  view:DateRangePickerView.month,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3)),
                  ),
                  ),
                ),
              if(!historyProvider.isDay)
                SizedBox(width: 100.w,height: 30.h,
                  child: Wrap(
                    children: List.generate(historyProvider.months.length, (index) {
                      return InkWell(
                        onTap: (){
                          historyProvider.changeMonth(month: historyProvider.months[index]);
                        },
                        child: Container(width: 30.w,height: 6.h,
                          padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:historyProvider.months[index] == historyProvider.month? AppColor.defaultColor :null
                          ),
                          child: Center(
                            child: Text(LanguageProvider.translate("months", historyProvider.months[index]['title']),
                              style: TextStyleClass.smallStyle(color:
                              historyProvider.months[index] == historyProvider.month? Colors.white:Colors.black).
                              copyWith(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      );
                    },),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
