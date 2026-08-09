import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_color.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/usecases/user_usecases.dart';
import '../pages/forget_password_page.dart';
import '../widgets/change_password_successfully_widget.dart';
import '../widgets/new_password_widget.dart';
import 'otp_provider.dart';

class ResetPasswordProvider extends ChangeNotifier {
  List<TextFieldModel> resetPasswordInputs = [];
  List<TextFieldModel> newPasswordInputs = [];
  final UserUseCases userUseCases;
  ResetPasswordProvider(this.userUseCases);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeFormKey = GlobalKey<FormState>();

  void goToForgetPasswordPage() {
    resetPasswordInputs = [
      TextFieldModel(
        key: "email",
        controller: TextEditingController(),
        textInputType: TextInputType.emailAddress,
        validator: (value) => validateEmailORUser(value),
        label: "emailOrUserName",
        next: false,
      ),
    ];
    navP(ForgetPasswordPage());
  }

  void showCreateNewPasswordDialog() {
    showModalBottomSheet(
      context: Constants.globalContext(),
      backgroundColor: AppColor.backgroundColor,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      builder: (context) {
        return NewPasswordWidget();
      },
    );
  }

  void showPasswordChangedDialog() {
    showModalBottomSheet(
      context: Constants.globalContext(),
      backgroundColor: AppColor.backgroundColor,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      builder: (context) {
        return ChangePasswordSuccessfullyWidget();
      },
    );
  }

  Future forgotPassword({bool isResend = false}) async {
    Map<String, dynamic> data = {};
    for (var element in resetPasswordInputs) {
      data[element.key ?? ""] = element.controller.text;
    }
    loading();
    Either<DioException, String> login = await userUseCases.forgotPassword(data,);
    navPop();
    login.fold(
      (l) {
        showToast(l.response?.data['error'] ?? l.response?.data['message'] ??
            l.message ?? LanguageProvider.translate('error', 'error'),);
      },
      (r) async {
        OtpProvider otpProvider = Provider.of(
          Constants.globalContext(),
          listen: false,
        );
        if (!isResend) {
          otpProvider.showVerificationWidgetDialog();
        }
      },
    );
  }

  Future resetPassword() async {
    ResetPasswordProvider resetPasswordProvider = Provider.of(
      Constants.globalContext(),
      listen: false,
    );
    OtpProvider otpProvider = Provider.of(
      Constants.globalContext(),
      listen: false,
    );
    Map<String, dynamic> data = {};
    data['resetCode'] = otpProvider.otpController.text;
    data['email'] =
        resetPasswordProvider.resetPasswordInputs.first.controller.text;
    for (var element in newPasswordInputs) {
      data[element.key ?? ""] = element.controller.text;
    }

    loading();
    Either<DioException, String> login = await userUseCases.resetPassword(data);
    navPop();
    login.fold(
      (l) {
        showToast(l.response?.data['error'] ?? l.response?.data['message'] ??
            l.message ?? LanguageProvider.translate('error', 'error'),);
      },
      (r) async {
        navPop();
        showPasswordChangedDialog();
      },
    );
  }
}
