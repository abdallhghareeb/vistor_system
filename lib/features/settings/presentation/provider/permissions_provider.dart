import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../location/presentation/provider/location_provider.dart';
import '../../../main/presentation/provider/main_page_provider.dart';
import '../../../splash/presentation/provider/connection_provider.dart';
import '../pages/permissions_page.dart';

class PermissionsProvider extends ChangeNotifier {
  List<Map<String,dynamic>> permissionsList =[];

  void goToPermissionsPage(){
    assignList();
    navP(PermissionsPage());
  }
  Future<void> assignList()async{
    permissionsList = [
      {
        "title":"camera",
        "description":"camera_des",
        "image":Images.camera,
        "allow":sharedPreferences.getBool("camera") ??false,
      },
      {
        "title":"location",
        "description":"location_des",
        "image":Images.location,
        "allow":sharedPreferences.getBool("location") ??false,
      },
      // {
      //   "title":"nfc",
      //   "description":"nfc_des",
      //   "image":Images.nfcSettings,
      //   "allow":sharedPreferences.getBool("nfc") ??false,
      // },

    ];
    notifyListeners();
  }
  void changeAllowElement(Map<String,dynamic> permission){
    int index = permissionsList.indexWhere((element) => element['title']==permission['title']);
    Map<String,dynamic> element=permissionsList[index];
    element['allow'] = !element['allow'];
    sharedPreferences.setBool("${permission['title']}", element['allow']);

    if(permission['title']=="location" && element['allow']){
      LocationProvider locationProvider = Provider.of<LocationProvider>(Constants.globalContext(), listen: false);
      locationProvider.getCurrentLocation();
    }
    notifyListeners();
  }
  void rebuild(){
    notifyListeners();
  }
}
