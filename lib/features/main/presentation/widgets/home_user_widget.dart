import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context);

    return Padding(
      padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
      child: Row(
        children: [
          Container(width:10.w,height: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(fit: BoxFit.cover,
                  image: authProvider.userEntity?.user?.profileImagePath != null ?
                  CachedNetworkImageProvider(authProvider.userEntity!.user!.profileImagePath!):AssetImage(Images.logo)),
              border: Border.all(color: Colors.white,width: 2),
            ),
          ),
          SizedBox(width: 2.w,),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(authProvider.userEntity?.user?.fullName??"",style: TextStyleClass.normalStyle(color: Colors.white),),
                Text(authProvider.userEntity?.user?.employee?.position??"",style: TextStyleClass.smallStyle(color: Colors.white),),
              ],
            ),
          ),
          SizedBox(width: 2.w,),
          InkWell(
            onTap: (){
              notificationProvider.goToNotificationPage();
            },
            child: Badge(
              label: Text("${notificationProvider.unReadNum}",),

              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration:BoxDecoration(
                    color: Color(0xff5182EF),shape: BoxShape.circle
                ),
                child: SvgWidget(svg: Images.notifications,width: 6.w,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
