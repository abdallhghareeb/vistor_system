import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../../../settings/presentation/provider/settings_provider.dart';
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
  final UserUseCases userUseCases;
  CompleteDataProvider(this.userUseCases);

  List<TextFieldModel> registerInputs = [];
  AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);

  ImageProvider showUserImage() {
    // if (authProvider.userEntity?.image != null || image != null) {
    //   if (image != null) {
    //     return FileImage(File(image!.path));
    //   } else {
    //     return CachedNetworkImageProvider(
    //       authProvider.userEntity!.image,
    //     );
    //   }
    // }else{
      return const AssetImage(Images.logo);
    // }
  }

  void updateImage(XFile image) {
    imageUpdated = true;
    this.image = image;
    notifyListeners();
  }

  List<TextFieldModel> passwordInputs=[];

  void goToResetPasswordPage(){
    passwordInputs=[
      TextFieldModel(
        key: "currentPassword",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "currentPassword",
        onShownTap : (){
          registerInputs.firstWhere((element) => element.key=="currentPassword",).obscureText=
          !registerInputs.firstWhere((element) => element.key=="currentPassword",).obscureText;
          notifyListeners();
        },
        next: true,),
      TextFieldModel(
        key: "password",
        controller: TextEditingController(),
        textInputType: TextInputType.visiblePassword,
        validator: (value) => validatePassword(value),
        label: "newPassword",
        onShownTap : (){
          registerInputs.firstWhere((element) => element.key=="password",).obscureText=
          !registerInputs.firstWhere((element) => element.key=="password",).obscureText;
          notifyListeners();
        },
        next: false,),
    ];
    navP(const ResetPasswordPage());

  }

  void goToRegisterPage(){
    image = null;
    imageUpdated = false;
    registerInputs = [
      TextFieldModel(
          key: "fullName",
          label: "full_name",
          controller: TextEditingController(text: authProvider.userEntity?.user?.fullName??""),
          // validator: (value) => validateName(value),
          hint: "full_name"),
      TextFieldModel(
          key: "id",
          label: "employeeId",readOnly: true,
          controller: TextEditingController(text: authProvider.userEntity?.user?.employeeCode??""),
          // validator: (value) => validateName(value),
          hint: "employeeId"),
      TextFieldModel(
        key: "email",
        label: "email",
        controller: TextEditingController(text: authProvider.userEntity?.user?.email??""),
        textInputType: TextInputType.emailAddress,
        hint: "email",readOnly:true,
        next: false,
      ),
      TextFieldModel(
          key: "mobileNumber",
          label: "phone",
          controller: TextEditingController(text: authProvider.userEntity?.user?.mobileNumber??""),
          textInputType: TextInputType.number,
          // validator: (value) => validatePhone(value),
          next: true,
          hint: "phone"
          ),
    ];
      navP(const UpdateAccountDataPage(),then: (s){
        fromAuthRegister = false;
      });
  }

  void submitRegisterForm() {
    String nameError = '';

    if (image ==null) {
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

  void successLogin({required UserEntity userEntity, bool fromSplash = false,}) async {
    MainProvider  mainProvider= Provider.of<MainProvider>(Constants.globalContext(), listen: false);
    NotificationProvider  notificationProvider= Provider.of<NotificationProvider>(Constants.globalContext(), listen: false);
    if(authProvider.userEntity !=null && !fromSplash ){
      authProvider.userEntity =userEntity;
      mainProvider.rebuild();
    }else{
      authProvider.userEntity =userEntity;
      if(userEntity.token!=null){
        sharedPreferences.setString('token', userEntity.token!);
        ApiHandel.getInstance.updateHeader(userEntity.token!);
      }
      if(userEntity.user?.employee !=null || userEntity.user?.employeeId !=null){
        mainProvider.goToMainPage(fromSplash: fromSplash);
      }else{
        gotoPlaceHolderEmployeePage();
      }
    }
    notificationProvider.registerDevice();
  }

  void gotoPlaceHolderEmployeePage(){
    navPARU(const PlaceHolderEmployeePage());
  }

  bool checkEditPhone(){
    AuthProvider authProvider=Provider.of(Constants.globalContext(),listen: false);

    return (authProvider.userEntity?.user?.mobileNumber !=
        registerInputs.firstWhere((element) => element.key=="phone",).controller.text &&
        registerInputs.firstWhere((element) => element.key=="phone",).controller.text.isNotEmpty);
  }

  void updateProfileButton({required bool updatePassword}) async {
    Map<String, dynamic> data = {};
    if(updatePassword){
      for (var element in passwordInputs) {
        data[element.key??""] = element.controller.text;
      }
    }else{
      for (var element in registerInputs) {
        if(element.controller.text != '' && element.key != "email"&& element.key != "id"){
          data[element.key??""] = element.controller.text;
        }
      }
    }
    loading();
    Either<DioException, UserEntity> login = await userUseCases.updateProfile(data);
    navPop();
    login.fold((l) {
      showToast(l.message!);
    }, (r) async {
      AuthProvider authProvider = Provider.of(Constants.globalContext(),listen: false);
      authProvider.userEntity?.user?.mobileNumber = r.user?.mobileNumber;
      authProvider.userEntity?.user?.fullName = r.user?.fullName;
      authProvider.userEntity?.user?.email = r.user?.email??"";
      authProvider.userEntity?.user?.mobileNumber = r.user?.mobileNumber;
      Provider.of<LanguageProvider>(Constants.globalContext(), listen: false).rebuild();
      Provider.of<SettingsProvider>(Constants.globalContext(), listen: false).rebuild();
      Provider.of<MainProvider>(Constants.globalContext(), listen: false).rebuild();
      successDialog(then: () {navPU();});
      notifyListeners();
    });
  }

  String titleText(){
    return fromAuthRegister ? "confirm_your_info": "edit_profile";
  }

}
