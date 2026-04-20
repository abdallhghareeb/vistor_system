import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/widget/svg_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../location/presentation/provider/location_provider.dart';
import '../provider/main_page_provider.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("${LanguageProvider.translate("home",mainProvider.greeting)} , ${authProvider.userEntity?.user?.fullName??""}",
              maxLines: 1,style: TextStyleClass.smallStyle(color: Colors.white).copyWith(fontWeight: FontWeight.bold),)),
            if(locationProvider.lat != null && (sharedPreferences.getBool("location")??false))
              Row(
                children: [
                  SvgWidget(svg: Images.location,width: 4.w,color: Colors.white,),
                  Text(LanguageProvider.translate("home",(locationProvider.didInsideZone()??false)
                      ? "inside_work" :"outside_work"),
                    style: TextStyleClass.smallStyle(color: Colors.white),),
                ],
              ),
          ],
        ),
        SizedBox(height: 1.h,),
        Text(LanguageProvider.translate("home", "lets"),style: TextStyleClass.smallStyle(color: Colors.white),),
        SizedBox(height: 2.h,),
      ],
    );
  }
}
