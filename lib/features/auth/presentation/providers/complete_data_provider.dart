import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitor/features/visitors/presentation/providers/visitors_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
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
import '../../../main/presentation/provider/main_page_provider.dart';
import '../../../notification/presentation/provider/notification_provider.dart';
import '../../../settings/presentation/pages/change_password_page.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../../domain/entities/tab_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_usecases.dart';
import '../pages/place_holder_employee_page.dart';
import '../pages/reset_password_page.dart';
import '../pages/update_account_data_page.dart';
import 'auth_provider.dart';

class CompleteDataProvider extends ChangeNotifier {
  XFile? image;
  bool imageUpdated = false;
  bool fromAuthRegister = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateAccountDataFormKey = GlobalKey<FormState>();
  final UserUseCases userUseCases;
  CompleteDataProvider(this.userUseCases);
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  List<TextFieldModel> registerInputs = [];
  AuthProvider authProvider = Provider.of(Constants.globalContext(), listen: false,);

  ImageProvider showUserImage() {
    if (authProvider.userEntity?.pictureUrl != null || image != null) {
      if (image != null) {
        return FileImage(File(image!.path));
      } else {
        return CachedNetworkImageProvider(
          authProvider.userEntity!.pictureUrl!,
        );
      }
    }else{
    return const AssetImage(Images.logo);
    }
  }

  void updateImage(XFile image) {
    imageUpdated = true;
    this.image = image;
    notifyListeners();
  }

  List<TextFieldModel> passwordInputs = [];

  void goToResetPasswordPage() {
    passwordInputs = [
      TextFieldModel(
        key: "currentPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "currentPassword",
        onShownTap: () {
          registerInputs.firstWhere((element) => element.key == "currentPassword").obscureText =
          !registerInputs.firstWhere((element) => element.key == "currentPassword").obscureText;
          notifyListeners();
        },
        next: true,
      ),
      TextFieldModel(
        key: "password",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "newPassword",
        onShownTap: () {
          registerInputs.firstWhere((element) => element.key == "password").obscureText =
          !registerInputs.firstWhere((element) => element.key == "password").obscureText;
          notifyListeners();
        },
        next: false,
      ),
    ];
    navP(const ResetPasswordPage());
  }

  void goToRegisterPage() async{
    loading();
    await Provider.of<AuthProvider>(Constants.globalContext(),listen: false).getProfile(fromLogin: true);
    navPop();

    image = null;
    imageUpdated = false;
    registerInputs = [
      TextFieldModel(
        key: "username",
        label: "username",
        controller: TextEditingController(
          text: authProvider.userEntity?.username ?? "",
        ),
        // validator: (value) => validateName(value),
        hint: "username",
        readOnly: true,
      ),
      TextFieldModel(
        key: "Id",
        label: "employeeId",
        readOnly: true,
        controller: TextEditingController(
          text: authProvider.userEntity?.userId ?? "",
        ),
        // validator: (value) => validateName(value),
        hint: "employeeId",
      ),
      TextFieldModel(
        key: "email",
        label: "email",
        controller: TextEditingController(
          text: authProvider.userEntity?.email ?? "",
        ),
        textInputType: TextInputType.emailAddress,
        hint: "email",
        readOnly: true,
        next: false,
      ),
      TextFieldModel(
        key: "PhoneNumber",
        label: "phone",
        controller: TextEditingController(
          text: authProvider.userEntity?.phoneNumber ?? "",
        ),
        textInputType: TextInputType.number,
        // validator: (value) => validatePhone(value),
        next: true,
        hint: "phone",
      ),
    ];
    navP(
      const UpdateAccountDataPage(),
      then: (s) {
        fromAuthRegister = false;
      },
    );
  }

  void submitRegisterForm() {
    String nameError = '';

    if (image == null) {
      String? error = validateName("");
      nameError += '$error\n';
    }
    for (var element in registerInputs) {
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


  void successLogin({
    required UserEntity userEntity,
    bool fromSplash = false,
  }) async {
    MainProvider mainProvider = Provider.of<MainProvider>(Constants.globalContext(), listen: false,);
    if (authProvider.userEntity != null && !fromSplash) {
      authProvider.userEntity = userEntity;
      mainProvider.rebuild();
    } else {
      authProvider.userEntity = userEntity;
      if (userEntity.token != null) {
        sharedPreferences.setString('token', userEntity.token!);
        ApiHandel.getInstance.updateHeader(userEntity.token!);
      }
      await getDataReady();
      VisitorsProvider visitorsProvider = Provider.of<VisitorsProvider>(Constants.globalContext(), listen: false,);
      visitorsProvider.getQuickOverview();
      mainProvider.goToMainPage(fromSplash: fromSplash);
      // if(userEntity.user?.employee !=null || userEntity.user?.employeeId !=null){
      //   mainProvider.goToMainPage(fromSplash: fromSplash);
      // }else{
      //   gotoPlaceHolderEmployeePage();
      // }
    }
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(Constants.globalContext(), listen: false,);

    notificationProvider.registerDevice();
  }

  void gotoPlaceHolderEmployeePage() {
    navPARU(const PlaceHolderEmployeePage());
  }

  bool checkEditPhone() {
    AuthProvider authProvider = Provider.of(
      Constants.globalContext(),
      listen: false,
    );

    return (authProvider.userEntity?.phoneNumber !=
            registerInputs
                .firstWhere((element) => element.key == "phone")
                .controller
                .text &&
        registerInputs
            .firstWhere((element) => element.key == "phone")
            .controller
            .text
            .isNotEmpty);
  }

  void updateProfileButton({required bool updatePassword}) async {
    Map<String, dynamic> data = {};
    if (updatePassword) {
      for (var element in passwordInputs) {
        data[element.key ?? ""] = element.controller.text;
      }
    } else {
      if(imageUpdated && image is XFile){
        data['Image'] = await MultipartFile.fromFile(image!.path);
      }
      data['Roles']= "Operator";
      for (var element in registerInputs) {
        if (element.controller.text != '') {
          data[element.key ?? ""] = element.controller.text;
        }
      }
    }
    loading();
    Either<DioException,UserEntity> login = await userUseCases.updateProfile(data,);
    navPop();
    login.fold(
      (l) {
        showToast(l.message!);
      },
      (r) async {
        AuthProvider authProvider = Provider.of(
          Constants.globalContext(),
          listen: false,
        );
        authProvider.userEntity = r;
        Provider.of<LanguageProvider>(Constants.globalContext(), listen: false,).rebuild();
        Provider.of<SettingsProvider>(Constants.globalContext(), listen: false,).rebuild();
        Provider.of<MainProvider>(Constants.globalContext(), listen: false,).rebuild();
        successDialog(
          then: () {
            navPU();
          },
        );
        notifyListeners();
      },
    );
  }

  String titleText() {
    return fromAuthRegister ? "confirm_your_info" : "edit_profile";
  }

  List<Map<String, dynamic>>? checkData;
  num totalVisitors = 0;

  Future getDataReady() async {
    Map<String, dynamic> data = {};
    loading();
    Either<DioException, TabEntity> login = await userUseCases.getTabsInfo(data,);
    navPop();
    login.fold(
      (l) {
        checkData = [];
        showToast(l.message!);
      },
      (r) async {
        totalVisitors = r.totalInvitation;
        checkData = [
          {
            "title": "checked_out",
            "num": "${r.exited}",
            "sub_title": "checked_out_des",
            "color": 0xffE35151,
          },
          {
            "title": "checked_in",
            "num": "${r.entered}",
            "sub_title": "checked_in_des",
            "color": 0xff16A34A,
          },
          {
            "title": "expected_visitors",
            "num": "${r.pending}",
            "sub_title": "expected_visitors_des",
            "color": 0xff6B7280,
          },
          {
            "title": "total_transaction",
            "num": "${r.totalTransaction}",
            "sub_title": "total_transaction_des",
            "color": 0xffF59E0B,
          },
        ];
      },
    );
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }


  List<TextFieldModel> changePasswordInputs = [];

  void goToChangePasswordPage(){
    changePasswordInputs = [

      TextFieldModel(
        key: "oldPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "old_password",
        onShownTap: () {
          passwordInputs.firstWhere((element) => element.key == "oldPassword").obscureText =
          !passwordInputs.firstWhere((element) => element.key == "oldPassword").obscureText;
          notifyListeners();
        },
        next: true,
      ),
      TextFieldModel(
        key: "newPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "new_password",
        onShownTap: () {
          passwordInputs.firstWhere((element) => element.key == "newPassword").obscureText =
          !passwordInputs.firstWhere((element) => element.key == "newPassword").obscureText;
          notifyListeners();
        },
        next: false,
      ),
      TextFieldModel(
        key: "confirmPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value){
          String password= changePasswordInputs.firstWhere((element) => element.key == "newPassword").controller.text;
          String confirmPassword= changePasswordInputs.firstWhere((element) => element.key == "confirmPassword").controller.text;

          if (value == null || value.isEmpty) {
            return LanguageProvider.translate("validation", "empty_password");
          }
          if (value.length < 6) {
            return LanguageProvider.translate("validation", "password_min_length");
          }
          if (password != confirmPassword) {
            return LanguageProvider.translate("validation", "confirm_password");
          }

          return null;
        },
        label: "confirm_new_password",
        onShownTap: () {
          changePasswordInputs.firstWhere((element) => element.key == "confirmPassword").obscureText =
          !changePasswordInputs.firstWhere((element) => element.key == "confirmPassword").obscureText;
          notifyListeners();
        },
        next: true,
      ),

    ];

    navP(ChangePasswordPage());
  }

  Future changePassword() async {
    Map<String, dynamic> data = {};
    for(var element in changePasswordInputs){
      data["${element.key}"] = element.controller.text;
    }
    loading();
    Either<DioException, bool> login = await userUseCases.changePassword(data);
    navPop();
    login.fold((l) {
      showToast(l.response?.data['message']?? l.message);
      }, (r) async {
      for(var element in changePasswordInputs){
        element.controller.clear();
      }
      successDialog(then: () {navPop();},);
      },
    );
    notifyListeners();
  }


}
