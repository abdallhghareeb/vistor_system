import 'package:flutter/material.dart';

import '../helper_function/prefs.dart';

class Constants{
  // static const String baseUri = 'https://attedix-96784e636bb5.herokuapp.com/';
  static  String baseUri = sharedPreferences.getString('domain')??"";
  static  String domain = '$baseUri/api/';
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static const String appId = '';
  static const String packageName = '';
  static bool isTablet = false;
  static BuildContext globalContext(){
    return navState.currentContext!;
  }
}


