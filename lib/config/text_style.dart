import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextStyleClass {
  static TextStyle displayStyle({Color? color}) {
    return _style(size: 30.sp, color: color);
  }

  static TextStyle largeTitleStyle({Color? color}) {
    return _style(size: 26.sp, color: color);
  }

  static TextStyle headStyle({Color? color}) {
    return _style(size: 20.sp, color: color);
  }

  static TextStyle semiHeadStyle({Color? color}) {
    return _style(size: 18.sp, color: color);
  }

  static TextStyle normalStyle({Color? color}) {
    return _style(size: 16.sp, color: color);
  }

  static TextStyle smallStyle({Color? color}) {
    return _style(size: 14.sp, color: color);
  }

  static TextStyle captionStyle({Color? color}) {
    return _style(size: 12.sp, color: color);
  }

  static TextStyle labelStyle({Color? color}) {
    return _style(size: 11.sp, color: color);
  }

  static TextStyle microStyle({Color? color}) {
    return _style(size: 10.sp, color: color);
  }

  static TextStyle buttonStyle({Color? color}) {
    return normalStyle(color: color);
  }

  static TextStyle textFieldStyle({Color? color}) {
    return smallStyle(color: color);
  }

  static TextStyle _style({required double size, Color? color}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: size,
      fontFamily: 'Poppins',
    );
  }
}
