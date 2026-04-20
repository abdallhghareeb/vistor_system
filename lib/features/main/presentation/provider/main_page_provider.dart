import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../history/presentation/pages/history_page.dart';
import '../../../history/presentation/provider/history_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../location/presentation/pages/location_page.dart';
import '../../../location/presentation/provider/location_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';
import '../../../settings/presentation/pages/permissions_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../settings/presentation/provider/permissions_provider.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../../../splash/presentation/provider/connection_provider.dart';
import '../pages/home_page.dart';
import '../pages/main_page.dart';
import '../widgets/fingerprint_failed_widget.dart';
import '../widgets/in_zone_widget.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String,dynamic>> systemStatus=[];

  final List<Widget> bottomWidget = [
    const HomePage(),
    const HistoryPage(),
    const LocationPage(),
    const SettingsPage(),
  ];

  List<Map<String, dynamic>> items = [
    {"image": Images.home,"active_image": Images.activeHome, "title": "home",},
    {"image": Images.history,"active_image": Images.history, "title": "history",},
    {"image": Images.location,"active_image": Images.activeLocation, "title": "location",},
    {"image": Images.settings,"active_image": Images.activeSettings, "title": "settings",},
  ];

  int index = 0;
  int previousIndex = 2;
  Color checkColor(int index) {
    if (this.index == index) {
      return AppColor.defaultColor;
    }
    return Colors.transparent;
  }
  void rebuild() {
    notifyListeners();
  }

  void setIndex(int index) async {
    // if (!AuthProvider.isLogin()) {
    //   showGuestDialog();
    //   return;
    // }
    if (index == 2 && !(sharedPreferences.getBool("location")??false)) {

      showToast(LanguageProvider.translate("validation", "allow_location_first"));
      navP(PermissionsPage());
      return;
    }
    previousIndex = 6;
    this.index = index;
    notifyListeners();

    if (index == 0) {

    }
    if (index == 1) {
      Provider.of<HistoryProvider>(Constants.globalContext(), listen: false).refresh();
    }
    if (index == 3) {
    Provider.of<SettingsProvider>(Constants.globalContext(), listen: false).prepareData();
     }
    await delay(300);
    previousIndex = this.index;
    notifyListeners();
    // } else {
    //   showGuestDialog();
    // }
  }

  Timer? timer;
  void stopTimer() {
    timer?.cancel();
  }

  List<Map<String, dynamic>> homeTypes = [];

  void goToMainPage({required bool fromSplash}) async {
    ConnectivityProvider connectivityProvider= Provider.of<ConnectivityProvider>(Constants.globalContext(),listen: false);
    assignSystemStatusList();
    Provider.of<HistoryProvider>(Constants.globalContext(), listen: false).getMyWork();
    Provider.of<PermissionsProvider>(Constants.globalContext(), listen: false).assignList();
    updateGreeting();
    Timer.periodic(const Duration(minutes: 1), (_) {
     updateGreeting();
    });
    if(!Provider.of<AuthProvider>(Constants.globalContext(), listen: false).isGuest()) {
      if(sharedPreferences.getBool("location")??false){
        LocationProvider locationProvider = Provider.of<LocationProvider>(Constants.globalContext(), listen: false);
        locationProvider.getCurrentLocation( fromSplash: fromSplash);
      }
      connectivityProvider.init();
      connectivityProvider.startListening();

      await Future.wait([
        Provider.of<SettingsProvider>(Constants.globalContext(), listen: false).getZones(),
        Provider.of<NotificationProvider>(Constants.globalContext(),listen: false).unreadCount()
    ]);
    }


    index = 0;
    previousIndex = index;
    navPARU(const MainPage());
    successDialog(msg: fromSplash ? "have_nice_day" : "sign_in");
  }

  void assignSystemStatusList(){
    ConnectivityProvider connectivityProvider= Provider.of<ConnectivityProvider>(Constants.globalContext(),listen: false);
    systemStatus=[
      {"image":Images.gps, "title":"gps", "value":connectivityProvider.isGpsEnabled ?
      "enabled" : "disabled","color":connectivityProvider.hasConnection ? Color(0xff149443) : Colors.red},
      {"image":Images.wifi, "title":"internet", "value":connectivityProvider.hasConnection ? "connected" : "disconnected",
        "color":connectivityProvider.hasConnection ? Color(0xff149443) : Colors.red},
      // {"image":Images.nfc, "title":"nfc", "value":"enable",},
      // {"image":Images.camera, "title":"camera", "value":"required",},
    ];
    notifyListeners();
  }
  String greeting = "";

  void updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      greeting = "morning";
    } else if (hour >= 12 && hour < 17) {
      greeting = "afternoon";
    } else if (hour >= 17 && hour < 21) {
      greeting = "evening";
    } else {
      greeting = "night";
    }

    notifyListeners();
  }
  void changeInternetStatus(){
    ConnectivityProvider connectivityProvider= Provider.of<ConnectivityProvider>(Constants.globalContext(),listen: false);
    systemStatus.firstWhere((element) => element['title']=="internet",)['value'] =
    connectivityProvider.hasConnection ? "connected" : "disconnected";
    systemStatus.firstWhere((element) => element['title']=="internet",)['color'] =
    connectivityProvider.hasConnection ? Color(0xff149443) : Colors.red;
    notifyListeners();
  }
  void changeGpsStatus(){
    ConnectivityProvider connectivityProvider= Provider.of<ConnectivityProvider>(Constants.globalContext(),listen: false);
    Map<String,dynamic> data= systemStatus.firstWhere((element) => element['title']=="gps",);
    data['value'] = connectivityProvider.isGpsEnabled ? "enabled" : "disabled";
    data['color'] = connectivityProvider.isGpsEnabled ? Color(0xff149443) : Colors.red;
    sharedPreferences.setBool("location", connectivityProvider.isGpsEnabled);
    PermissionsProvider permissionsProvider= Provider.of<PermissionsProvider>(Constants.globalContext(), listen: false);
    permissionsProvider.permissionsList.firstWhere((element) => element['title']=="location",)['allow'] = connectivityProvider.isGpsEnabled;
    permissionsProvider.rebuild();

    notifyListeners();
  }


  void showInsideZoneDialog(){
    showModalBottomSheet(
        context: Constants.globalContext(),
        backgroundColor: AppColor.backgroundColor,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36),),),
        builder: (context) {
          return InZoneWidget();
        }
    );
  }


  void showFingerprintFailedDialog(){
    showDialog(
      context: Constants.globalContext(),
      barrierDismissible: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: FingerprintFailedWidget(),
            ),
          ),
        );
      },
    );
  }

}
