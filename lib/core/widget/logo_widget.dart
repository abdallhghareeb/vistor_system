import 'package:flutter/material.dart';
import '../constants/images.dart';

class LogoWidget extends StatelessWidget {
  final double? width,height;
  final BoxFit? fit;
  const LogoWidget({this.height,this.width,super.key, this.fit});
  @override
  Widget build(BuildContext context) {
    return Image.asset(Images.logo,width: width,height: height,fit: fit??BoxFit.contain,);
  }
}
