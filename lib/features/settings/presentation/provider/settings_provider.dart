import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/zone_entity.dart';
import '../../domain/usecases/settings_usecases.dart';
import '../pages/settings_content_page.dart';
import 'permissions_provider.dart';

class SettingsProvider extends ChangeNotifier {
  List<Map<String,dynamic>> generalSettings=[];
  List<Map<String,dynamic>> supportSettings=[];
  List<ZoneEntity> zones=[];
  void prepareData(){
    generalSettings = [
      {
        "title":"account",
        "description":"account_des",
        "onTap":(){
          Provider.of<CompleteDataProvider>(Constants.globalContext(), listen: false).goToRegisterPage();
        },
      },
      {
        "title":"permissions",
        "description":"permissions_des",
        "onTap":(){
          Provider.of<PermissionsProvider>(Constants.globalContext(), listen: false).goToPermissionsPage();
        },
      },
      {
        "title":"changeLanguage",
        "description":"changeLanguage_des",
        "onTap":(){
          Provider.of<LanguageProvider>(Constants.globalContext(), listen: false).showLanguageDialog();
        },
      },
      {
        "title":"deleteAccount",
        "description":"deleteAccount_des",
        "onTap":(){
          Provider.of<AuthProvider>(Constants.globalContext(), listen: false).confirmDeleteAccount();

        },
      },
      {
        "title":"logout",
        "description":"logout_des",
        "onTap":(){
          Provider.of<AuthProvider>(Constants.globalContext(), listen: false).confirmLogoutAccount();
        },
      },
    ];
    supportSettings = [
      // {
      //   "title":"customer_service",
      //   "description":"customer_service_des",
      //   "onTap":(){},
      // },
      {
        "title":"about_us",
        "description":"about_us_des",
        "content":aboutUsContent(),
        "onTap":(){
          Map<String,dynamic> element =supportSettings.firstWhere((element) => element["title"] == "about_us");
          goToSettingsContentPage(element:element);
        },
      },
      {
        "title":"terms",
        "description":"terms_des",
        "content":termsContent(),
        "onTap":(){
          Map<String,dynamic> element =supportSettings.firstWhere((element) => element["title"] == "terms");
          goToSettingsContentPage(element:element);
        },
      },
      {
        "title":"privacy",
        "description":"privacy_des",
        "content":privacyContent(),
        "onTap":(){
          Map<String,dynamic> element =supportSettings.firstWhere((element) => element["title"] == "privacy");
          goToSettingsContentPage(element:element);
        },
      },

    ];

  }

  void goToSettingsContentPage({required Map<String, dynamic> element}){
    navP(SettingsContentPage(element: element));
  }

  SettingsProvider(this.settingsUseCases);
  SettingsUseCases settingsUseCases;
  Future getZones() async {
    Either<DioException, List<ZoneEntity>> login = await settingsUseCases.getZones();
    login.fold((l) {
      // navPop();
      showToast(l.message ?? "");
    }, (r) async {
      zones = r;
      notifyListeners();
    });
  }
  void rebuild() {
    notifyListeners();
  }

  String aboutUsContent(){
    return LanguageProvider.translate("settings", "about_us_content");
  }

  String termsContent(){
    return LanguageProvider.translate("settings", "terms_content");
  }
  String privacyContent(){
    return LanguageProvider.translate("settings", "privacy_content");
  }
}
