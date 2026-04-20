import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/dialog/update_dialog.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../pages/intro_page.dart';
import 'select_domain_provider.dart';

class SplashProvider extends ChangeNotifier {
  int index = 0;
  List<Map> intro = [
    {"title": "title1", "body": "body1", "image": Images.onboarding1},
    {"title": "title2", "body": "body2", "image": Images.onboarding2},
    // {"title": "title3", "body": "body3", "image": Images.onboarding3},
  ];

  String getLastIndex() {
    if (index == intro.length - 1) {
      return "start";
    } else {
      return "continue";
    }
  }

  void startApp() async {
    // isEndAnimation= true;
    // var settingsProvider = Provider.of<SettingsProvider>(Constants.globalContext(), listen: false);
    // SettingsEntity? settings = settingsProvider.settingsEntity;
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // if (int.parse(packageInfo.buildNumber) < settings!.version) {
    //   await updateDialog(settings.mustUpdate);
    //   if (settings.mustUpdate) {
    //     return;
    //   }
    // }
    bool intro = sharedPreferences.getBool('intro') ?? false;
    String? foundDomain = sharedPreferences.getString('domain');
    if (!intro) {
      navPARU(const IntroPage());
    } else {
      if (foundDomain == null) {
        Provider.of<SelectDomainProvider>(
          Constants.globalContext(),
          listen: false,
        ).goToSelectDomainPage();
      } else {
        await ApiHandel.getInstance.init();
        AuthProvider authProvider = Provider.of<AuthProvider>(
          Constants.globalContext(),
          listen: false,
        );
        String? login = sharedPreferences.getString('token');
        if (login != null) {
          authProvider.getProfile(fromSplash: true);
        } else {
          authProvider.goToLoginPage();
        }
      }
    }
  }

  void incrementSelect() {
    if (index == intro.length - 1) {
      return Provider.of<SelectDomainProvider>(
        Constants.globalContext(),
        listen: false,
      ).goToSelectDomainPage();
    }
    index++;
    notifyListeners();
  }

  void decrementSelect() {
    index--;
    notifyListeners();
  }

  Widget skipIntro() {
    return InkWell(
      onTap: () {
        Provider.of<SelectDomainProvider>(
          Constants.globalContext(),
          listen: false,
        ).goToSelectDomainPage();
      },
      child: Row(
        children: [
          Container(
            height: 8.h,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: Text(
                LanguageProvider.translate("buttons", "skip"),
                style: TextStyleClass.smallStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
