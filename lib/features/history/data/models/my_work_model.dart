import '../../../../core/helper_function/convert.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/my_work_entity.dart';

class MyWorkModel extends MyWorkEntity{
  MyWorkModel({required super.employee, required super.hoursSummary, required super.todayAttendance});

  factory MyWorkModel.fromJson(Map<String, dynamic> json) {
    return MyWorkModel(
      employee: EmployeeModel.fromJson(json['employee']),
      hoursSummary: HoursSummaryModel.fromJson(json['hoursSummary']),
      todayAttendance:json['todayAttendance'] !=null? TodayAttendanceModel.fromJson(json['todayAttendance']) :null,
    );
  }
}
class HoursSummaryModel extends HoursSummary{
  HoursSummaryModel({required super.today, required super.thisWeek, required super.thisMonth});

  factory HoursSummaryModel.fromJson(Map<String, dynamic> json) {
    return HoursSummaryModel(
      today: convertDataToNum(json['today']),
      thisWeek: convertDataToNum(json['thisWeek']),
      thisMonth:convertDataToNum(json['thisMonth']) ,
    );
  }
}
class TodayAttendanceModel extends TodayAttendance {
  TodayAttendanceModel({required super.status, required super.checkInTime, required super.checkOutTime,
    required super.workTime, required super.overTime, required super.isLate, required super.isOffDay,
    required super.offDayReason, required super.date});

  factory TodayAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TodayAttendanceModel(
      status: json['status'],
      checkInTime: json['checkInTimeLocal'],
      checkOutTime: json['checkOutTimeLocal'],
      workTime: json['workTime'],
      overTime: json['overTime'],
      isLate: json['isLate'],
      isOffDay: json['isOffDay'],
      offDayReason: json['offDayReason'],
      date: json['date'],
    );
  }
}