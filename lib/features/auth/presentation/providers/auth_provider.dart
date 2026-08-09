import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/confirm_dialog.dart';
import '../../../../core/dialog/custom_snack_bar.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_usecases.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import 'complete_data_provider.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? userEntity;
  Timer? _refreshTimer;
  Map<String, dynamic> decodedToken = {};
  String token = '123';
  final UserUseCases userUseCases;
  AuthProvider(this.userUseCases);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

  void rebuild() {
    notifyListeners();
  }

  static bool isLogin() {
    return sharedPreferences.getString('token') != null;
  }

  Future getProfile({bool fromSplash = false}) async {
    Map<String, dynamic> data = {};
    Either<DioException, UserEntity> login = await userUseCases.getProfile(
      data,
    );
    login.fold(
      (l) {
        showToast(l.message ?? LanguageProvider.translate('error', 'error'));
        goToLoginPage();
      },
      (r) async {
        Provider.of<CompleteDataProvider>(Constants.globalContext(), listen: false,)
            .successLogin(userEntity: r, fromSplash: fromSplash);
        notifyListeners();
      },
    );
  }

  bool isGuest() {
    return userEntity == null;
  }

  void guestButton() {
    sharedPreferences.setBool('intro', true);
    Provider.of<AuthProvider>(
      Constants.globalContext(),
      listen: false,
    ).goToLoginPage();
  }

  List<TextFieldModel> loginInputs = [];
  List<TextFieldModel> registerInputs = [];

  void submitLoginForm() {
    String nameError = '';

    for (var element in loginInputs) {
      if (element.controller.text.isEmpty) {
        String? error = element.validator!(element.controller.text);
        if (error != null && error.isNotEmpty) {
          nameError += '$error\n';
        }
      }
    }
    if (nameError.isEmpty) {
    } else {
      errorSnackBar(title: nameError.trim());
    }
  }

  void startRefreshTimer(String? token) {
    const duration = Duration(minutes: 59);
    _refreshTimer = Timer.periodic(duration, (timer) {
      refreshToken(token: token);
    });
  }

  void stopRefreshTimer() {
    _refreshTimer?.cancel();
  }

  Future refreshToken({String? token}) async {
    Map<String, dynamic> data = {};
    data['token'] = token;
    Either<DioException, String> refreshToken = await userUseCases.refreshToken(
      data,
    );
    refreshToken.fold((l) {}, (r) async {
      userEntity?.token = r;
      ApiHandel.getInstance.updateHeader(r);
      sharedPreferences.setString('token', r);
    });
  }

  Future loginButton({bool fromSplash = false, bool fromJWT = false}) async {
    Map<String, dynamic> data = {};
    // if(sharedPreferences.getString("phone") !=null) {
    //   loginInputs.firstWhere((element) => element.key == 'phone').controller =
    //       TextEditingController(text: sharedPreferences.getString("phone"));
    // }
    for (var element in loginInputs) {
      data[element.key ?? ""] = element.controller.text;
    }
    if (!fromSplash) loading();
    Either<DioException, UserEntity> login = await userUseCases.login(data);
    login.fold(
      (l) {
        if (!fromSplash) navPop();
        if (fromSplash) {
          sharedPreferences.remove("phone");
          // navPARU(LoginPage());
        } else {
          showToast(l.response?.data['message']??l.message);
        }
      },
      (r) async {
        Provider.of<CompleteDataProvider>(
          Constants.globalContext(),
          listen: false,
        ).successLogin(userEntity: r, fromSplash: fromSplash);
      },
    );
  }

  void logout() async {
    if (isGuest()) {
      successLogout();
    } else {
      Map<String, dynamic> data = {};
      // AccessTokenFireBase accessTokenGetter = AccessTokenFireBase();
      // String token = await accessTokenGetter.getAccessToken();
      token = await FirebaseMessaging.instance.getToken() ?? "123";
      data['token'] = token;
      userUseCases.logout(data);
      Provider.of<NotificationProvider>(Constants.globalContext(), listen: false,).unregisterDevice();
      successLogout();
    }
  }

  void deleteAccount() async {

    Either<DioException, bool> login = await userUseCases.deleteProfile({'id': userEntity?.userId});
    login.fold((l) {
        showToast(l.message!);
    }, (r) async {
        successLogout();
        notifyListeners();
      },
    );
  }

  void confirmDeleteAccount() {
    confirmDialog(
      LanguageProvider.translate('settings', "delete_account_dialog"),
      LanguageProvider.translate('buttons', "delete_account"),
      () {
        deleteAccount();
      },
    );
  }

  void confirmLogoutAccount() {
    confirmDialog(
      LanguageProvider.translate('settings', "logout_dialog"),
      LanguageProvider.translate('buttons', "logout"),
      () {
        logout();
      },
    );
  }

  void goToLoginPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoarding', true);
    loginInputs = [
      TextFieldModel(
        key: "username",
        controller: TextEditingController(),
        textInputType: TextInputType.text,
        validator: (value) => validateEmailORUser(value),
        label: "username",
        hint: "login_username",
        next: true,
      ),
      TextFieldModel(
        key: "password",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "password",
        hint: "login_pass",
        onShownTap: () {
          loginInputs
              .firstWhere((element) => element.key == "password")
              .obscureText = !loginInputs
              .firstWhere((element) => element.key == "password")
              .obscureText;
          notifyListeners();
        },
        obscureText: true,
        next: false,
      ),
    ];
    sharedPreferences.remove('token');
    navPARU(const LoginPage());
  }

  void goToRegisterPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoarding', true);
    registerInputs = [
      TextFieldModel(
        key: "Username",
        controller: TextEditingController(),
        textInputType: TextInputType.text,
        validator: (value) => validateName(value),
        label: "username",
        next: true,
      ),

      TextFieldModel(
        key: "Email",
        controller: TextEditingController(),
        textInputType: TextInputType.emailAddress,
        validator: (value) => validateEmail(value),
        label: "email",
        next: true,
      ),
      // TextFieldModel(
      //   key: "PhoneNumber",
      //   controller: TextEditingController(),
      //   textInputType: TextInputType.text,
      //   validator: (value) => validatePhone(value),
      //   label: "phone",
      //   next: true,),
      // TextFieldModel(
      //   key: "fullName",
      //   controller: TextEditingController(),
      //   textInputType: TextInputType.text,
      //   validator: (value) => validateName(value),
      //   label: "full_name",
      //   next: true,),
      TextFieldModel(
        key: "PhoneNumber",
        controller: TextEditingController(),
        textInputType: TextInputType.phone,
        validator: (value) => validatePhone(value),
        label: "phone",
        next: true,
      ),
      TextFieldModel(
        key: "password",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "password",
        onShownTap: () {
          registerInputs
              .firstWhere((element) => element.key == "password").obscureText = !registerInputs
              .firstWhere((element) => element.key == "password").obscureText;
          notifyListeners();
        },
        next: true,
      ),
      TextFieldModel(
        key: "ConfirmPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "confirm_password",
        onShownTap: () {
          registerInputs
              .firstWhere((element) => element.key == "ConfirmPassword").obscureText = !registerInputs
              .firstWhere((element) => element.key == "ConfirmPassword").obscureText;
          notifyListeners();
        },
        next: false,
      ),
    ];
    navP(const RegisterPage());
  }

  void successLogout() {
    userEntity = null;
    sharedPreferences.remove('token');
    goToLoginPage();
  }

  String code = "+20";
  Future registerButton() async {
    Map<String, dynamic> data = {};
    for (var element in registerInputs) {
      data[element.key ?? ""] = element.controller.text;
    }
    // data.remove("confirm_password");
    CompleteDataProvider completeDataProvider =Provider.of(Constants.globalContext(),listen: false);
    if(completeDataProvider.image != null){
      data['Image'] =await MultipartFile.fromFile(completeDataProvider.image!.path);

    }
    data['Roles'] = "Operator";
    loading();
    Either<DioException, UserEntity> login = await userUseCases.register(data);
    navPop();
    login.fold(
      (l) {
        showToast(l.response?.data['error'] ?? l.response?.data['message'] ??
            l.message ?? LanguageProvider.translate('error', 'error'),);
      },
      (r) async {
        successDialog(
          then: () {
            goToLoginPage();
          },
        );
      },
    );
  }

  void submitRegisterForm() {
    String nameError = '';

    for (var element in registerInputs) {
      if (element.controller.text.isEmpty) {
        String? error = element.validator!(element.controller.text);
        if (error != null && error.isNotEmpty) {
          nameError += '$error\n';
        }
      }
    }

    if (registerInputs
            .firstWhere((element) => element.key == "password")
            .controller
            .text !=
        registerInputs.last.controller.text) {
      showToast(LanguageProvider.translate("validation", "password_not_match"));
    }

    if (nameError.isEmpty) {
    } else {
      errorSnackBar(title: nameError.trim());
    }
  }
}
