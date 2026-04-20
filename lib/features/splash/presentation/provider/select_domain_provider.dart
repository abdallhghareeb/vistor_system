import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../auth/domain/usecases/user_usecases.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../pages/select_domain_page.dart';

class SelectDomainProvider extends ChangeNotifier {
  String? domain;
  final UserUseCases userUseCases;
  TextEditingController codeController = TextEditingController();
  SelectDomainProvider(this.userUseCases);

  Future getDomain()async{
    Map<String, dynamic> data = {};
    data['code'] = codeController.text;
    loading();
    Either<DioException, String> login = await userUseCases.getDomain(data);
    navPop();
    login.fold((l)  {
      showToast(l.response?.data['error']??l.message ??"Something went wrong");
    }, (r) async {
      domain = r;
      saveDomain();
    });
  }



  void goToSelectDomainPage(){
    navP(SelectDomainPage());
  }


  void saveDomain()async{
    sharedPreferences.setString('domain', domain!);
    await ApiHandel.getInstance.init();
    Provider.of<AuthProvider>(Constants.globalContext(), listen: false).guestButton();
  }

  void removeDomain()async{
    sharedPreferences.remove('domain');
    navPARU(SelectDomainPage());

  }

}