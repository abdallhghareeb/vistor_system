
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldModel{
  String? image,key,label,hint,titleText;
  TextInputType? textInputType;
  TextEditingController controller;
  bool next,obscureText,readOnly;
  bool?isLabel,readOnlyOnly;
  String? Function(String?)? validator;
  Widget? suffix,prefix,title;
  void Function()? onTap;
  void Function()? onShownTap;
  ChangeNotifierProvider? provider;
  double? width;
  int? min,max;
  EdgeInsets? contentPadding;
  
  TextFieldModel(
      {this.image,
        this.key,
        this.label,
        this.isLabel,
        this.hint = "",
        this.textInputType,
        this.readOnly = false,
        required this.controller,
        this.next = true,
        this.validator,
        this.readOnlyOnly,
        this.onShownTap,
        this.provider,
        this.onTap,
        this.suffix,
        this.prefix,
        this.title,
        this.titleText,
        this.min,
        this.max,
        this.width,
        this.contentPadding,
        this.obscureText = false});
}