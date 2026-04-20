import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'app_color.dart';

ThemeData defaultTheme = ThemeData(
    useMaterial3: false,
    primaryColor: AppColor.defaultColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
    unselectedWidgetColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: checkboxThemeData,
    dividerColor: Colors.transparent,
    radioTheme: radioThemeData,
    appBarTheme: appBarTheme,
    fontFamily: "Poppins",
    splashColor: Colors.transparent);

AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.transparent,
    centerTitle: true,
    foregroundColor: Colors.black,
    elevation: 0,
    systemOverlayStyle: lightBarColor(),
    // toolbarHeight: 6.h,
    titleTextStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16.sp, color: AppColor.defaultColor),);

EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h);

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    fillColor: WidgetStateProperty.all<Color>(Colors.transparent),
    checkColor: WidgetStateProperty.all<Color>(AppColor.defaultColor),
    overlayColor: WidgetStateProperty.all<Color>(AppColor.defaultColor),
    visualDensity: VisualDensity.compact);

RadioThemeData radioThemeData = RadioThemeData(
  fillColor: WidgetStateProperty.all(AppColor.defaultColor),
);

TabBarTheme tabBarTheme = TabBarTheme(labelColor: AppColor.defaultColor, indicatorSize: TabBarIndicatorSize.label, unselectedLabelColor: Colors.grey);

SystemUiOverlayStyle barColor() {
  if (Platform.isAndroid) {
    return const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light, statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.white);
  }
  return SystemUiOverlayStyle.dark;
}

SystemUiOverlayStyle lightBarColor() {
  if (Platform.isAndroid) {
    return const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent
    );
  }
  return SystemUiOverlayStyle.light;
}
