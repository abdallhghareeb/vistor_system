import '../../../auth/domain/entities/user_entity.dart';

class MyWorkEntity{
  final EmployeeEntity employee;
  final HoursSummary hoursSummary;
  final TodayAttendance? todayAttendance;
  MyWorkEntity({required this.employee, required this.hoursSummary, required this.todayAttendance});
}
class HoursSummary {
  final num today;
  final num thisWeek;
  final num thisMonth;
  HoursSummary({required this.today, required this.thisWeek, required this.thisMonth});
}

class TodayAttendance {
  final String status;
  final String? checkInTime;
  final String ?checkOutTime;
  final String? workTime;
  final String? overTime;
  final bool isLate;
  final bool isOffDay;
  final String? offDayReason;
  final String? date;
  TodayAttendance({required this.status, required this.checkInTime, required this.checkOutTime,
    required this.workTime, required this.overTime, required this.isLate, required this.isOffDay,
    required this.offDayReason, required this.date});
}

