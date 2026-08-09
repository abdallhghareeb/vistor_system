import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/auth/presentation/providers/complete_data_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../helper_function/image.dart';

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
              ],
            ),
          ),
          SizedBox(height: 0.5.h),
          InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              XFile? image = await chooseImage();
              if (image != null) {
                authProvider.updateImage(image);
              }
            },
            child: Text(LanguageProvider.translate('auth', 'upload_image'),
              style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
            ),
          ),
        ]
      ),
    );
  }
}


