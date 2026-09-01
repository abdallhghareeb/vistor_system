import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/text_style.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
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
    if (AuthProvider.isGuestMode()) {
      sharedPreferences.remove('guest_mode');
      Provider.of<SelectDomainProvider>(
        Constants.globalContext(),
        listen: false,
      ).goToSelectDomainPage();
      return;
    }
    var settingsProvider = Provider.of<SettingsProvider>(
      Constants.globalContext(),
      listen: false,
    );
    await settingsProvider.mobileVersion();

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // if (int.parse(packageInfo.buildNumber) < int.parse(settingsProvider.version)) {
    //   await updateDialog(true);
    //   if (true) {
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
      sharedPreferences.setBool("intro", true);
      return Provider.of<SelectDomainProvider>(
        Constants.globalContext(),
        listen: false,
      ).goToSelectDomainPage();
    }
    // if (index == intro.length - 1) {
    //   Provider.of<AuthProvider>(Constants.globalContext(), listen: false,).goToLoginPage();
    //   sharedPreferences.setBool("intro", true);
    // }
    if (index < intro.length - 1) {
      index++;
    }
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
                LanguageProvider.translate("intro", "skip"),
                style: TextStyleClass.smallStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
