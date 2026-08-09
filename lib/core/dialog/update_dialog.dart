import 'package:flutter/cupertino.dart';
import 'package:store_redirect/store_redirect.dart';
import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../helper_function/navigation.dart';

Future updateDialog(bool mustLogin) async {
  await showCupertinoModalPopup<void>(
    context: Constants.globalContext(),
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        LanguageProvider.translate('global', 'new_update'),
        style: TextStyleClass.normalStyle(),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () async {
            StoreRedirect.redirect(
              androidAppId: Constants.packageName,
              iOSAppId: Constants.appId,
            );
          },
          child: Text(
            LanguageProvider.translate('global', 'update_now'),
            style: TextStyleClass.normalStyle(color: AppColor.defaultColor),
          ),
        ),
        // if (!mustLogin)
        //   CupertinoDialogAction(
        //     onPressed: () async {
        //       navPop();
        //     },
        //     child: Text(
        //       LanguageProvider.translate('buttons', 'cancel'),
        //       style: TextStyleClass.normalStyle(),
        //     ),
        //   ),
      ],
    ),
  );
}
