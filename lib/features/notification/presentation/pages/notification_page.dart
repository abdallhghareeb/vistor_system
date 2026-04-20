import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/lottie.dart';
import '../../../../core/widget/empty_animation.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/shimmer_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/notification_provider.dart';
import '../widgets/notification_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of(context,);
    notificationProvider.pagination();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(LanguageProvider.translate("notification", "notification")),
        actions: [
          InkWell(onTap: (){
            notificationProvider.readAll();
          }, child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(LanguageProvider.translate("notification", "read_all",),
                style: TextStyleClass.smallStyle(color: AppColor.defaultColor),),
            ),
          )),
        ],),
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: RefreshIndicator(
            onRefresh: () async {
              notificationProvider.refresh();
            },
            child: Column(
              children: [
                SizedBox(height: 1.h,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: notificationProvider.controller,
                    child: Builder(builder: (context) {
                      if (notificationProvider.notifications == null) {
                        return Column(
                          children: List.generate(8,(index) => ShimmerWidget(width: 100.w, height: 15.h),),
                        );
                      } else if (notificationProvider.notifications!.isEmpty) {
                        return   EmptyAnimation(gif: LottiePaths.noSearch, title: 'no_notification');
                      } else {
                        return Column(
                          children: [
                            Wrap(
                              children: List.generate(notificationProvider.notifications!.length, (index) {
                                return NotificationWidget(notificationEntity: notificationProvider.notifications![index]);
                              }),
                            ),
                            SizedBox(height: 1.h,),
                            if(notificationProvider.paginationStarted) LoadingWidget(),
                            SizedBox(height: 2.h,),

                          ],
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
