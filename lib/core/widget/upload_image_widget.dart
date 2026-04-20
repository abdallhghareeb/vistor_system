import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/auth/presentation/providers/complete_data_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../helper_function/image.dart';
import 'svg_widget.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key, required this.fromAuth});
  final bool fromAuth ;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<CompleteDataProvider>(context);
    return InkWell(
      onTap: () async {
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Stack(
              children: [
                Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(color: AppColor.defaultColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: authProvider.image==null? BoxFit.fill:BoxFit.cover,

                        image: authProvider.showUserImage()
                    )
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        XFile? image = await chooseImage();
                        if (image != null) {
                          authProvider.updateImage(image);
                        }
                      },
                      child:  Container(padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,color: Color(0xffF0F1F2)
                        ),
                          child: SvgWidget(svg: Images.edit,width:Constants.isTablet?5.w: 7.w,))),
                ),
              ],
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            LanguageProvider.translate('home', 'guest'),
            style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
          ),

          Text(
            LanguageProvider.translate('settings', 'id').replaceFirst("*id*", "id"),
            style: TextStyleClass.normalStyle(color: Color(0xff6B7280)),
          ),
        ],
      ),
    );
  }
}


