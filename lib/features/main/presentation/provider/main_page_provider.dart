import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../visitors/presentation/pages/visitors_page.dart';
import '../../../visitors/presentation/providers/visitors_provider.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../pages/home_page.dart';
import '../pages/main_page.dart';

class MainProvider extends ChangeNotifier {
  List<Map<String, dynamic>> systemStatus = [];

  final List<Widget> bottomWidget = [
    const HomePage(),
    const VisitorsPage(),
    const SettingsPage(),
  ];

  List<Map<String, dynamic>> items = [
    {"image": Images.home, "title": "home"},
    {"image": Images.visitors, "title": "visitors"},
    {"image": Images.settings, "title": "settings"},
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
    previousIndex = 6;
    this.index = index;
    notifyListeners();

    if (index == 0) {}
    if (index == 1) {
      VisitorsProvider visitorsProvider = Provider.of<VisitorsProvider>(
        Constants.globalContext(),
        listen: false,
      );
      if (visitorsProvider.visitors == null) {
        visitorsProvider.getVisitors();
      }
    }
    if (index == 2) {
      Provider.of<SettingsProvider>(
        Constants.globalContext(),
        listen: false,
      ).prepareData();
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

  void goToMainPage({required bool fromSplash}) async {
    index = 0;
    previousIndex = index;
    navPARU(const MainPage());
    // successDialog(msg: fromSplash ? "have_nice_day" : "sign_in");
  }
}
