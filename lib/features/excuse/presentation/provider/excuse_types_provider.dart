import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/drop_down_class.dart';
import '../../../language/presentation/provider/language_provider.dart';
import 'add_excuse_provider.dart';

class ExcuseTypesProvider with ChangeNotifier implements DropDownClass<String>{
  List<String> excuseTypesList =["OTHER","EMERGENCY","PERSONAL","VACATION","SICK_LEAVE"];
  String? excuseType;

  void setData(){
    excuseType = null;
    notifyListeners();
  }

  @override
  String displayedName() {
    return LanguageProvider.translate("home", excuseType ??"");
  }

  @override
  String displayedOptionName(String? type) {
    return LanguageProvider.translate("home", type??"") ;
  }

  @override
  Widget? displayedOptionWidget(String? type) {
    return null;
  }

  @override
  Widget? displayedWidget() {
    return null;
  }

  @override
  List<String> list() {
    return excuseTypesList.reversed.toList();
  }

  @override
  Future onTap(String? data) async{
    excuseType= data;
    AddExcuseProvider addExcuseProvider = Provider.of<AddExcuseProvider>(Constants.globalContext(),listen: false);
    addExcuseProvider.addExcuseFields.firstWhere((element) => element.key=="ExcuseType",).controller.text = data??"";
    notifyListeners();

    notifyListeners();
  }

  @override
  String? selected() {
    return excuseType;
  }

  @override
  value() {
    return excuseType;
  }

  void clear() {
    excuseType = null;
    excuseTypesList.clear();
    notifyListeners();
  }

  @override
  bool require() {
    return false;
  }

  @override
  String? titleName() {
    return "";
  }

}