import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_animation_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/history_provider.dart';
import '../widgets/single_history_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key,});
  @override
  Widget build(BuildContext context) {
    HistoryProvider historyProvider= Provider.of<HistoryProvider>(context,);
    historyProvider.pagination();
    return SafeArea(
      child: Scaffold(backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(title: Text(LanguageProvider.translate("home", "history")),),
        body: Container(width: 100.w,height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Provider.of<HistoryProvider>(context,listen: false).showFilterDialog();
                },
                child: Container(padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                    decoration: BoxDecoration(
                        color: Colors.transparent,border: Border.all(color: Color(0xff9CA1AA),width: 1),
                        borderRadius: BorderRadius.circular(32)
                    ),
                    child: Text(LanguageProvider.translate("history", "filter"),
                      style: TextStyleClass.smallStyle(color: AppColor.labelTextColor),)),
              ),
              SizedBox(height: 2.h,),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    historyProvider.refresh();
                  },
                  child: SingleChildScrollView(
                    controller: historyProvider.controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Builder(builder: (context) {
                      if(historyProvider.attendances==null){
                        return Center(child: LoadingAnimationWidget(gif: LottiePaths.loading, width: 20.w, height: 5.h));
                      }else if(historyProvider.attendances!.isEmpty){
                        return Center(child: EmptyAnimation(title: "", gif: LottiePaths.noSearch));
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              runSpacing: 2.h,
                              children: List.generate(historyProvider.attendances!.length, (index) {
                              return SingleHistoryWidget(attendance: historyProvider.attendances![index],);
                            },),),
                            if(historyProvider.paginationStarted) LoadingWidget(),
                          ],
                        ),
                      );
                    },),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
