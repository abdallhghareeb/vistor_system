import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../config/text_style.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';

class TopSettingsWidget extends StatelessWidget {
  const TopSettingsWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal:2.w,),
      child: InkWell(
        onTap: (){
          Provider.of<CompleteDataProvider>(context,listen: false).goToRegisterPage();
        },
        child: Consumer<CompleteDataProvider>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1.h,),
                // Container(
                //   width: 30.w,
                //   height: 30.w,
                //   decoration:  BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(color: AppColor.defaultColor),
                //     image: DecorationImage(
                //         image: authProvider.userEntity!=null &&authProvider.userEntity?.image!=null ?
                //         CachedNetworkImageProvider(authProvider.userEntity!.image,errorListener:(p0) {
                //           return ;
                //         },):
                //         const AssetImage(Images.logo),
                //         fit: BoxFit.cover
                //     ),
                //   ),
                // ),
                SizedBox(height: 0.5.h,),
                Text(authProvider.userEntity?.user?.fullName ?? LanguageProvider.translate("home", "guest"),
                  style: TextStyleClass.normalStyle(color: AppColor.defaultColor),),
                Text( LanguageProvider.translate("settings", "id").
                replaceFirst("*id*", "${authProvider.userEntity?.user?.employeeCode??1}"),
                  style: TextStyleClass.smallStyle(color: Color(0xff6B7280)),),
              ],
            );}
        ),
      ),
    );
  }
}
