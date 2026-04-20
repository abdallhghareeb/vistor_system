import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

void showToast(String text,{Color? color,String? title}) {
  final materialBanner = MaterialBanner(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 2,

    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100.h * 0.3,
        minHeight: 80,
        minWidth: 50.w,
        maxWidth: 100.w
      ),
      child: AwesomeSnackbarContent(
        title: LanguageProvider.translate('error', title??'error'),
        message: text.replaceAll('\n', "\n----------------------------------------------\n"),
        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.warning,
        messageTextStyle: TextStyleClass.smallStyle(color: Colors.white),
        titleTextStyle: TextStyleClass.smallStyle(color: Colors.white),
        color: color??AppColor.defaultColor,
        // to configure for material banner
        inMaterialBanner: true,
      ),
    ),
    actions: const [SizedBox.shrink(),],
  );

  ScaffoldMessenger.of(Constants.globalContext())
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);
  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(Constants.globalContext()).hideCurrentMaterialBanner();
  });


}