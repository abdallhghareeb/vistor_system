import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../config/app_color.dart';
import '../providers/otp_provider.dart';

class CustomOTPFieldWidget extends StatelessWidget {
  const CustomOTPFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OtpProvider otpProvider = Provider.of(context,listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          cursorColor: Colors.black38,
          enablePinAutofill: true,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          separatorBuilder: (context, position) => Column(
            children: [
              Container(
                width: 10,
                height: 7.h,
                color: Colors.grey.shade100,
              ),
            ],
          ),
          pinTheme: PinTheme(
            borderRadius: BorderRadius.circular(12),
            selectedColor: AppColor.defaultColor,
            // selectedFillColor: Colors.white,
            activeColor: AppColor.defaultColor,
            inactiveColor: AppColor.labelTextColor,
            shape: PinCodeFieldShape.box,
            fieldHeight:5.8.h,
            fieldWidth: 12.w,
            activeFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            errorBorderColor: Colors.transparent,
          ),
          animationDuration: const Duration(milliseconds: 300),
          // backgroundColor: Colors.white,
          enableActiveFill: true,
          controller: otpProvider.otpController,
          onCompleted: (v) {},
        ),
      ),
    );
  }
}
