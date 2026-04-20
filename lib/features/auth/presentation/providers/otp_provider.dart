import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/custom_snack_bar.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../domain/usecases/user_usecases.dart';
import '../widgets/verification_widget.dart';
import 'reset_password_provider.dart';

class OtpProvider extends ChangeNotifier {
  String? hashedCode;
  TextEditingController otpController = TextEditingController();
  final UserUseCases userUseCases;
  OtpProvider(this.userUseCases);

  void submitChangePasswordOtpForm() {
    String nameError = '';

    if (otpController.text.isEmpty) {
      nameError = "${validateOtp(otpController.text)}";
    }
    if (nameError.isEmpty) {
    } else {
      errorSnackBar(title: nameError.trim());
    }
  }

  // void checkCode({required bool login}) async {
  //   ResetPasswordProvider resetPasswordProvider = Provider.of(Constants.globalContext(),listen: false);
  //   Map<String, dynamic> data = {};
  //   data['code'] = otpController.text;
  //   data['emailOrUsername'] = resetPasswordProvider.resetPasswordInputs.first.controller.text;
  //   loading();
  //   Either<DioException, String> confirmCode = await userUseCases.sendOtp(data);
  //   navPop();
  //   confirmCode.fold((l) {
  //     showToast(l.response?.data['error']??l.message ??"Something went wrong");
  //   }, (r) async {
  //     timer?.cancel();
  //     sharedPreferences.setString('token',r?.token??"");
  //     if(login){
  //       CompleteDataProvider completeDataProvider = Provider.of(Constants.globalContext(), listen: false);
  //       sharedPreferences.setString("login_from","user");
  //       completeDataProvider.successLogin(userEntity: r!);
  //     }else{
  //       successDialog(then: () {navPop();});
  //     }
  //   });
  // }


  String otpNumber = '';
  String? otpPhoneCode = '';
  bool isLogin=false;
  void verifyOTP()async{
    ResetPasswordProvider resetPasswordProvider = Provider.of(Constants.globalContext(),listen: false);
    Map<String, dynamic> data = {};
    data['otp'] = otpController.text;
    data['emailOrUsername'] = resetPasswordProvider.resetPasswordInputs.first.controller.text;
    loading();
    Either<DioException, String> login = await userUseCases.verifyOTP(data);
    navPop();
    login.fold((l)  {
      showToast(l.response?.data['error']??l.message ??"Something went wrong");
    }, (r) async {
      navPop();
      navPop();
      resetPasswordProvider.showCreateNewPasswordDialog();
    });
  }

  void showVerificationWidgetDialog(){
    otpController = TextEditingController();
    showModalBottomSheet(
        context: Constants.globalContext(),
        backgroundColor: AppColor.backgroundColor,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36),),),
        isScrollControlled: true,
        builder: (context) {
          return VerificationWidget();
        });
  }

}
