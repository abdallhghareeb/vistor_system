import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/confirm_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/location.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../excuse/presentation/provider/add_excuse_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../location/presentation/provider/location_provider.dart';
import '../../../main/presentation/provider/main_page_provider.dart';
import '../../../settings/presentation/pages/permissions_page.dart';
import '../../../splash/presentation/provider/connection_provider.dart';
import '../../domain/entities/check_in_entity.dart';
import '../../domain/usecases/history_usecases.dart';

class CheckProvider extends ChangeNotifier {
  HistoryUsecases historyUsecases;
  CheckProvider(this.historyUsecases);
  CheckEntity? checkEntity;
  AuthProvider authProvider = Provider.of<AuthProvider>(Constants.globalContext(),listen: false);
  LocationProvider locationProvider = Provider.of<LocationProvider>(Constants.globalContext(),listen: false);

  Future<void> checkIn({bool proceedOutsideZone =false}) async {
    if(isMockLocation) {
      showToast(color: Color(0xffEC5454),LanguageProvider.translate("error", "try_again_gps"),
        title:LanguageProvider.translate("error", "fake_gps"), );
      return;
    }
    Map<String,dynamic> data = {};
    data['employeeId'] = authProvider.userEntity?.user?.employeeId;
    data['latitude'] = locationProvider.lat;
    data['longitude'] = locationProvider.lng;
    data['proceedOutsideZone'] = proceedOutsideZone;
    loading();
    Either<DioException,CheckEntity> result = await historyUsecases.checkIn(data);
    navPop();
    result.fold((l) {
      showToast(l.message??"");
    }, (r) async {
      checkEntity = r;
      authProvider.getProfile();
      notifyListeners();
    });
  }
  Future<void> checkOut({bool proceedOutsideZone =false}) async {
    if(isMockLocation) {
      showToast(color: Color(0xffEC5454),LanguageProvider.translate("error", "try_again_gps"),
        title:LanguageProvider.translate("error", "fake_gps"), );
      return;
    }
    Map<String,dynamic> data = {};
    data['employeeId'] = authProvider.userEntity?.user?.employeeId;
    data['latitude'] = locationProvider.lat;
    data['longitude'] = locationProvider.lng;
    data['proceedOutsideZone'] = proceedOutsideZone;
    loading();
    Either<DioException,CheckEntity> result = await historyUsecases.checkOut(data);
    navPop();
    result.fold((l) {
      showToast(l.message??"");
    }, (r) async {
      checkEntity = r;
      authProvider.getProfile();
      notifyListeners();
    });
  }
  Timer? timer;

  void stopTimer(){
    timer?.cancel();
  }

  void startTimer() {
    timer?.cancel();
    MainProvider mainProvider =  Provider.of(Constants.globalContext(),listen: false);
    timer = Timer.periodic(const Duration(seconds: 1), (e){
      mainProvider.rebuild();
      notifyListeners();
    });
  }

  String getAuctionTimeLeft() {
    DateTime checkIn = DateTime.tryParse(authProvider.userEntity?.attendance?.checkIn?.timestamp ?? "",) ?? DateTime.now();
    DateTime checkOut = DateTime.tryParse(authProvider.userEntity?.attendance?.checkOut?.timestamp ?? "",) ?? DateTime.now();

    Duration diff = checkOut.difference(checkIn);

    if (diff.isNegative) return "00:00:00";

    int totalSeconds = diff.inSeconds;
    if (authProvider.userEntity?.todayWorkTime != null && authProvider.userEntity?.attendance?.checkOut == null) {
      String work = authProvider.userEntity!.todayWorkTime!.workTime??"00:00:00";
      List<String> arr = work.split(":");
      int prevHours = int.tryParse(arr[0]) ?? 0;
      int prevMinutes = int.tryParse(arr[1]) ?? 0;
      int prevSeconds = int.tryParse(arr[2]) ?? 0;
      totalSeconds += prevHours * 3600 + prevMinutes * 60 + prevSeconds;
    }
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    if (hours == 0 && minutes == 0 && seconds == 0) return "00:00:00";

    String hourString = hours > 0 ? "${hours.toString().padLeft(2, '0')}:" : "";
    String minutesString = "${minutes.toString().padLeft(2, '0')}:";
    String secondsString = seconds.toString().padLeft(2, '0');

    if(authProvider.userEntity?.attendance?.checkOut != null){
      return authProvider.userEntity?.todayWorkTime?.workTime??"00:00:00";
    }else{
      return "$hourString$minutesString$secondsString";
    }

  }

  bool canCheckIn(){
    if((authProvider.userEntity?.attendance?.checkIn == null) ||
        (authProvider.userEntity?.attendance?.checkOut != null) ){
      return true;
    }else{
      return false;

    }
  }


  void checkInAndOut(){
    ConnectivityProvider connectivityProvider= Provider.of(Constants.globalContext(),listen: false);
    if (!(sharedPreferences.getBool("location")??false) || !connectivityProvider.isGpsEnabled) {
      showToast(LanguageProvider.translate("validation", "allow_location_first"));
      navP(PermissionsPage());

      return;
    }else{
      if(locationProvider.didInsideZone()??false){
        if(canCheckIn()){
          Provider.of<MainProvider>(Constants.globalContext(),listen: false).showInsideZoneDialog();
        }else{
          Provider.of<AddExcuseProvider>(Constants.globalContext(),listen: false).showApplyExcuseDialog();
        }
      }else{
        showToast(LanguageProvider.translate("validation", "out_zone"));
        confirmDialog( LanguageProvider.translate("home", "out_zone"),
            LanguageProvider.translate("buttons", "confirm"), () {
              if((authProvider.userEntity?.attendance!=null && authProvider.userEntity?.attendance?.checkIn==null) ||
                  (authProvider.userEntity?.attendance!=null && authProvider.userEntity?.attendance?.checkOut!=null)){
                checkIn(proceedOutsideZone: true);
              }else{
                checkOut(proceedOutsideZone: true);
              }
            });
      }
    }


  }

}