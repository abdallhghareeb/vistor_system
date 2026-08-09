import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_color.dart';
import '../../config/text_style.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final bool obscureText, autoFocus, otp, readOnly, readOnlyOnly, next, isLabel;
  final TextEditingController controller;
  final double? width, height, verticalPadding, borderRadius, elevation;
  final Widget? prefix, suffix;
  final void Function(String)? onChange;
  final void Function()? onTextTap, onEditingComplete, onSuffixTap;
  final int? maxLines, maxLength, minLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? required;
  final String? counter, hintText, label;
  final Color? color,
      borderColor,
      cursorColor,
      focusedBorder,
      enabledBorder,
      hintColor,
      labelColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;
  const TextFieldWidget({
    this.maxLines,
    this.hintText,
    this.cursorColor,
    this.hintColor,
    this.required,
    required this.controller,
    this.height,
    this.width,
    this.style,
    this.focusedBorder,
    this.enabledBorder,
    this.isLabel = false,
    this.label,
    this.labelColor,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.counter,
    this.autoFocus = false,
    this.keyboardType,
    this.maxLength,
    this.next = true,
    this.obscureText = false,
    this.textAlign,
    this.onChange,
    this.onEditingComplete,
    this.onSuffixTap,
    this.otp = false,
    this.prefix,
    this.readOnly = false,
    this.suffix,
    this.onTextTap,
    this.validator,
    this.verticalPadding,
    super.key,
    this.minLines,
    this.contentPadding,
    this.elevation,
    this.readOnlyOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (verticalPadding ?? 3.h)),
      child: SizedBox(
        child: Column(
          children: [
            Container(
              color: readOnly
                  ? Color(0xffF0F1F2)
                  : labelColor ?? AppColor.backgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (label != null)
                  //   SizedBox(
                  //     width: 2.w,
                  //   ),
                  Text(
                    LanguageProvider.translate('inputs', label!),
                    style: TextStyleClass.smallStyle(
                      color: AppColor.labelTextColor,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (required != null)
                    Icon(Icons.star, color: Colors.red, size: 2.w),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Material(
              borderRadius: BorderRadius.circular(borderRadius ?? 4),
              elevation: elevation ?? 0,
              color: Colors.transparent,
              child: SizedBox(
                width: width ?? 100.w,
                height: height,
                child: TextFormField(
                  textAlign: textAlign ?? TextAlign.start,
                  obscureText: obscureText,
                  onChanged: onChange,
                  controller: controller,
                  // cursorHeight: 25,
                  onTap:
                      onTextTap ??
                      () {
                        TextEditingController c = controller;
                        if (c.selection ==
                            TextSelection.fromPosition(
                              TextPosition(offset: c.text.length - 1),
                            )) {
                          c.selection = TextSelection.fromPosition(
                            TextPosition(offset: c.text.length),
                          );
                        }
                      },
                  minLines: minLines,
                  cursorColor: cursorColor ?? Colors.black,
                  readOnly: readOnly || readOnlyOnly,
                  autofocus: autoFocus,
                  maxLines: maxLines ?? 1,
                  maxLength: maxLength,
                  style: style ?? TextStyleClass.smallStyle(color: Colors.black),
                  validator:
                      validator ??
                      (value) {
                        if (value!.isEmpty) {
                          return LanguageProvider.translate(
                            'validation',
                            'field',
                          );
                        }
                        return null;
                      },
                  onEditingComplete:
                      onEditingComplete ??
                      () {
                        FocusScope.of(context).unfocus();
                        if (next) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                  keyboardType: keyboardType,
                  decoration: inputDecoration(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      counterText: counter ?? "",
      isDense: true,
      counterStyle: TextStyleClass.smallStyle(),
      // labelText: labelText==null?null:LanguageProvider.translate('inputs', labelText!,),
      hintText: hintText == null
          ? null
          : LanguageProvider.translate('inputs', hintText!),
      fillColor: readOnly
          ? Color(0xffF0F1F2)
          : (color ?? AppColor.backgroundColor),
      filled: true,
      labelStyle: TextStyleClass.headStyle(color: const Color(0xff8F8C8C)),
      floatingLabelStyle: TextStyleClass.headStyle(),
      // border: focusedBorder!=null?null:border(borderRadius: borderRadius,color: borderColor,otp: otp),
      border: otp
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor),
            )
          : border(
              borderRadius: borderRadius,
              color: borderColor ?? AppColor.smallWhite,
            ),
      // disabledBorder:border(borderRadius: borderRadius,color: borderColor,otp: otp),
      disabledBorder: otp
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor),
            )
          : border(
              borderRadius: borderRadius,
              color: borderColor ?? AppColor.smallWhite,
            ),
      // focusedBorder: border(borderRadius: borderRadius,color: focusedBorder??borderColor,
      //     borderWidth: focusedBorder==null?0:3,otp: otp),
      focusedBorder: otp
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor),
            )
          : border(
              borderRadius: borderRadius,
              color: borderColor ?? AppColor.smallWhite,
            ),
      enabledBorder: otp
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor),
            )
          : border(
              borderRadius: borderRadius,
              color: borderColor ?? AppColor.smallWhite,
            ),
      // enabledBorder: border(borderRadius: borderRadius,color: enabledBorder??borderColor,otp: otp),
      errorBorder: otp
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor),
            )
          : border(borderRadius: borderRadius, color: Color(0xffEF4444)),
      // errorBorder: border(color: Colors.red,borderRadius: borderRadius,otp: otp),
      focusedErrorBorder: border(
        color: Colors.red,
        borderRadius: borderRadius,
        otp: otp,
      ),
      hoverColor: Colors.grey,
      prefixIcon: prefix,
      hintStyle: TextStyleClass.smallStyle(color: hintColor),
      errorStyle: TextStyleClass.smallStyle(color: Colors.red),
      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      suffixIcon:
          suffix ??
          (onSuffixTap == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    size: 20,
                    color: obscureText ? Colors.grey : AppColor.defaultColor,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )),
    );
  }

  static InputBorder border({
    Color? color,
    double? borderRadius,
    double? borderWidth,
    bool otp = false,
  }) {
    if (otp) {
      return UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color: color ?? Color(0xff8F8C8C),
          width: borderWidth ?? 1,
        ),
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        color: color ?? Color(0xff8F8C8C),
        width: borderWidth ?? 1,
      ),
    );
  }

  static InputDecoration get decoration {
    return InputDecoration(
      isDense: true,
      counterStyle: TextStyleClass.smallStyle(),
      counterText: '',
      fillColor: Colors.white,
      border: border(),
      disabledBorder: border(),
      focusedBorder: border(),
      enabledBorder: border(),
      errorBorder: border(color: Colors.red),
      focusedErrorBorder: border(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: Constants.isTablet ? 1.4.h : 1.7.h,
      ),
    );
  }

  //
  // InputDecoration inputDecoration(){
  //   return InputDecoration(
  //     counterText: counter,
  //     isDense: true,
  //     hintText: isLabel?null:(hintText==null?null:LanguageProvider.translate('inputs', hintText!,)),
  //     labelText: !isLabel?null:(hintText==null?null:LanguageProvider.translate('inputs', hintText!,)),
  //     labelStyle: TextStyleClass.semiStyle(color: Colors.grey),
  //     floatingLabelStyle: TextStyleClass.semiStyle(color: AppColor.defaultColor),
  //     floatingLabelBehavior: isLabel?FloatingLabelBehavior.always:null,
  //     fillColor: color??Color(0xffF8F8F8),
  //     filled: true,
  //     hintStyle: TextStyleClass.smallStyle(color: Colors.grey),
  //     border: focusedBorder!=null?null:border(borderRadius: borderRadius,color: borderColor),
  //     disabledBorder:border(borderRadius: borderRadius,color: borderColor),
  //     focusedBorder: border(borderRadius: borderRadius,color: focusedBorder??borderColor,
  //         borderWidth: focusedBorder==null?0:3),
  //     enabledBorder: border(borderRadius: borderRadius,color: enabledBorder??borderColor),
  //     errorBorder: border(color: Colors.red,borderRadius: borderRadius),
  //     focusedErrorBorder: border(color: Colors.red,borderRadius: borderRadius),
  //     hoverColor: Colors.grey,
  //     prefixIcon: prefix,
  //     contentPadding: contentPadding??EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.6.h),
  //     suffixIcon: suffix??(onSuffixTap==null?null:IconButton(onPressed:onSuffixTap,
  //         icon: Icon(obscureText?Icons.visibility_off_outlined:Icons.visibility,
  //           size: 20,color: obscureText?Colors.grey:AppColor.defaultColor,),
  //         splashColor: Colors.transparent,highlightColor: Colors.transparent)),
  //   );
  // }
  // InputBorder border({Color? color,double? borderRadius,double? borderWidth}){
  //   return OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius??12),
  //     borderSide: BorderSide(color: color??Color(0xffF2F2F2),width: borderWidth??1),);
  // }
}
