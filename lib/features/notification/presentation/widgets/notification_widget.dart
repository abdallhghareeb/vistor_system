import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/notification_entity.dart';
import '../provider/notification_provider.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notificationEntity});
  final NotificationEntity notificationEntity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<NotificationProvider>(context,listen: false).
        goToNotificationDetailsPage(title: notificationEntity.title, data: notificationEntity.description,id: notificationEntity.id);
      },
      child: Container(
        width: 100.w,
        color: notificationEntity.isRead? null:Color(0xffE9EFFD),
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
        child: Column(
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 6.w,
                //   backgroundImage: CachedNetworkImageProvider(userImage),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   padding: EdgeInsets.all(6),
                //   child: Image.asset(Images.breezeLogo,width: 10.w,height: 10.w,color: AppColor.defaultColor,),
                // ),
                // SizedBox(width: 3.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(notificationEntity.title,maxLines: 1,style: TextStyleClass.smallStyle(),)),
                          SizedBox(width: 3.w,),
                          Text(notificationEntity.createdAt,style: TextStyleClass.captionStyle(),maxLines: 1,),
                        ],
                      ),
                      SizedBox(height: 0.5.h,),
                      Text(notificationEntity.description,style: TextStyleClass.smallStyle(color: Colors.black54),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              ],
            ),
            // Divider(color: Colors.grey.shade400,),
          ],
        ),
      ),
    );
  }
}
