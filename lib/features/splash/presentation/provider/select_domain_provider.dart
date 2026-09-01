import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitor/features/language/presentation/provider/language_provider.dart';
import 'package:visitor/features/settings/presentation/provider/settings_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../auth/domain/usecases/user_usecases.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/complete_data_provider.dart';
import '../../../main/presentation/provider/main_page_provider.dart';
import '../../../visitors/presentation/providers/visitors_provider.dart';
import '../pages/select_domain_page.dart';

class SelectDomainProvider extends ChangeNotifier {
  String? domain;
  final UserUseCases userUseCases;
  TextEditingController codeController = TextEditingController();
  SelectDomainProvider(this.userUseCases);

  Future getDomain() async {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(
      Constants.globalContext(),
      listen: false,
    );
    loading();
    await settingsProvider.mobileVersion();
    navPop();
    if (settingsProvider.correctDomain) {
      final inputDomain = codeController.text.trim();
      final cleanDomain = inputDomain.replaceAll(RegExp(r'/+$'), '');
      domain = '$cleanDomain/';
      saveDomain();
    } else {
      showToast(LanguageProvider.translate("auth", "invalid_domain"));
    }
  }

  void goToSelectDomainPage() {
    navP(SelectDomainPage());
  }

  void saveDomain() async {
    sharedPreferences.setString('domain', domain!);
    Constants.domain = sharedPreferences.getString('domain') ?? "";
    await ApiHandel.getInstance.init();
    Provider.of<AuthProvider>(
      Constants.globalContext(),
      listen: false,
    ).goToLoginPage();
  }

  void continueAsGuest() {
    final context = Constants.globalContext();
    Provider.of<AuthProvider>(context, listen: false).startGuestSession();
    Provider.of<CompleteDataProvider>(
      context,
      listen: false,
    ).setGuestHomeData();
    Provider.of<VisitorsProvider>(
      context,
      listen: false,
    ).setGuestQuickOverview();
    Provider.of<MainProvider>(
      context,
      listen: false,
    ).goToMainPage(fromSplash: false);
  }

  void exitGuest() {
    sharedPreferences.remove('guest_mode');
    Provider.of<AuthProvider>(
      Constants.globalContext(),
      listen: false,
    ).rebuild();
    navPARU(const SelectDomainPage());
  }

  void removeDomain() async {
    sharedPreferences.remove('domain');
    navPARU(SelectDomainPage());
  }
}
