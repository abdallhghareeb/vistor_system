import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/pagination_class.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/my_work_entity.dart';
import '../../domain/usecases/history_usecases.dart';
import '../widgets/filter_dialog_widget.dart';

class HistoryProvider extends ChangeNotifier implements PaginationClass {

  bool isDay=true;
  Map<String, dynamic> month= {};
  List<Map<String, dynamic>> months = [];
  HistoryUsecases historyUsecases;
  HistoryProvider(this.historyUsecases);
  void changeMonth({required Map<String, dynamic> month}){
    this.month = month;
    notifyListeners();
    navPop();
    refresh();
  }

  void changeFilterView({required bool isDay}){
    this.isDay = isDay;
    notifyListeners();
  }

  void showFilterDialog(){
    months = getMonthsList();
    showModalBottomSheet(
        context: Constants.globalContext(),
        backgroundColor: Colors.white,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36),),),
        builder: (context) {
          return FilterDialogWidget();
        }
    );
  }

  MyWorkEntity? myWorkEntity;
  Future<void> getMyWork() async {
    Map<String,dynamic> data = {};
    Either<DioException,MyWorkEntity> result = await historyUsecases.getMyWorkData(data);
    result.fold((l) {
     showToast(l.message??"");
    }, (r) async {
      myWorkEntity = r;
      notifyListeners();
    });
  }

  void changeDateRange({required DateTime start,required DateTime end}){
    navPop();
    month['startDate'] = start;
    month['endDate'] = end;
    notifyListeners();
    refresh();
  }
  List<AttendanceEntity>? attendances;
  Future<void> getAttendanceHistory() async {
    Map<String,dynamic> data = {};
    data['page'] = pageIndex;
    data['startDate'] = month['startDate'] ?? convertDateToStringYMD(DateTime.now());
    data['endDate'] = month['endDate']?? convertDateToStringYMD(DateTime.now());
    data['limit'] = 20;
    Either<DioException,List<AttendanceEntity>> result = await historyUsecases.getAttendanceHistory(data);
    result.fold((l) {
      showToast(l.message??"");
    }, (r) async {
        pageIndex++;
        attendances ??= [];
        attendances?.addAll(r);
        if (r.isEmpty) {
          paginationFinished = true;
          notifyListeners();
        }
      paginationStarted = false;
      notifyListeners();
    });
  }

  void refresh() {
    clear();
    getAttendanceHistory();
  }
  void clear() {
    attendances = null;
    paginationStarted = false;
    paginationFinished = false;
    pageIndex = 1;
    notifyListeners();
  }

  @override
  int pageIndex = 1;

  @override
  bool paginationFinished = false;

  @override
  bool paginationStarted = false;
  ScrollController controller = ScrollController();
  @override
  void pagination() {
    controller.addListener(() async {
      if (controller.position.atEdge && controller.position.pixels > 50) {
        if (!paginationFinished && !paginationStarted && attendances != null && attendances!.isNotEmpty) {
          paginationStarted = true;
          notifyListeners();
          await getAttendanceHistory();
        }
      }
    });
  }


  List<Map<String, dynamic>> getMonthsList() {
    List<String> months = [
      "jan", "feb", "mar", "apr", "may", "jun",
      "jul", "aug", "sep", "oct", "nov", "dec",
    ];

    List<Map<String, dynamic>> result = [];

    for (int i = 0; i < months.length; i++) {
      int monthNumber = i + 1;
      DateTime start = DateTime(DateTime.now().year, monthNumber, 1);
      DateTime end = DateTime(DateTime.now().year, monthNumber + 1, 0);

      result.add({
        "title": months[i],
        "startDate": start,
        "endDate": end,
      });
    }

    return result;
  }

}