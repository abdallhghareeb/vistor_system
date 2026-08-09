import 'package:flutter/material.dart';


class Constants{
  static  String baseUri = "http://egytest.ddns.net:8644";
  static  String domain = '$baseUri/api/v1/';
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static const String appId = '';
  static const String packageName = '';
  static bool isTablet = false;
  static BuildContext globalContext(){
    return navState.currentContext!;
  }
}


