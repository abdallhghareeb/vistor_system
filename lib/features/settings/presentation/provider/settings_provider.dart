import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitor/core/constants/constants.dart';
import 'package:visitor/core/dialog/snack_bar.dart';
import 'package:visitor/core/helper_function/navigation.dart';
import 'package:visitor/features/settings/presentation/pages/version_page.dart';
import 'package:visitor/features/settings/presentation/pages/web_view.dart';
import '../../domain/entities/version_entity.dart';
import '../../domain/usecases/settings_usecases.dart';
import '../pages/language_page.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsUseCases settingsUseCases;

  SettingsProvider(this.settingsUseCases);

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  String selectedLanguageCode = 'ar';


  void prepareData() {
  }

  void prepareProfile({String? name}) {
    fullNameController.text = name ?? '';
    titleController.clear();
  }

  void prepareLanguage(String code) {
    selectedLanguageCode = code;
  }

  void selectLanguage(String code) {
    selectedLanguageCode = code;
    notifyListeners();
  }

  void rebuild() => notifyListeners();

  @override
  void dispose() {
    fullNameController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void goToPrivacyPage(){
    navP(WebViewPage(title: 'about_avms', link: 'https://avms.egytwins.com/docs/privacy-policy.html'));
  }

  void goToVersionPage(){
    navP(VersionPage());
  }

  void goToLanguagePage(){
    navP(LanguagePage());
  }

  String version = "0.0";
  bool correctDomain= false;
  Future mobileVersion() async {
    Either<DioException, VersionEntity> login = await settingsUseCases.mobileVersion();
    login.fold((l) {
      correctDomain= false;
    }, (r) async {
      if (Platform.isAndroid) {
        version = r.opreatorMobileAndriodVersion;
      } else if (Platform.isIOS) {
        version = r.opreatorMobileIosVersion;
      }
      correctDomain= true;
      notifyListeners();
      },
    );
  }


}
