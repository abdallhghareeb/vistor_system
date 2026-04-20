class UserEntity {
  String? token;
  String? refreshToken;
  num? expiresIn;
  bool requiresPasswordChange;
  String? invitationToken;
  UserDataEntity? user;
  LastAttendance? attendance;
  String? message;
  String? requiredWorkTime;
  TodayWorkTime? todayWorkTime;
  UserEntity({
    required this.requiresPasswordChange,
    required this.refreshToken,
    required this.invitationToken,
    required this.token,
    required this.todayWorkTime,
    required this.user,
    required this.requiredWorkTime,
    required this.message,
    required this.attendance,
  });
}

class UserDataEntity {
  String id;
  String email;
  String? username;
  String? employeeId;
  List<String>? roles;
  String? status;
  String? fullName;
  String? employeeCode;
  String? mobileNumber;
  String? profileImagePath;
  EmployeeEntity? employee;

  UserDataEntity({
    required this.id,
    required this.email,
    required this.employeeId,
    required this.username,
    required this.roles,
    required this.status,
    required this.employeeCode,
    required this.fullName,
    required this.mobileNumber,
    required this.profileImagePath,required this.employee
  });
}

class EmployeeEntity {
  String id;
  String name;
  String? personId;
  String department;
  String position;
  String? employeeCode;
  String? profileImagePath;
  EmployeeShiftEntity? shift;

  EmployeeEntity({
    required this.id,
    required this.name,
    required this.personId,
    required this.department,
    required this.position,
    required this.employeeCode,
    required this.profileImagePath,
    required this.shift,
  });
}

class EmployeeShiftEntity {
  String id;
  String name;
  String startTime;
  String endTime;
  List<int> workDays;
  int graceMinutes;

  EmployeeShiftEntity({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.workDays,
    required this.graceMinutes,
  });}

class SingleCheck{
  final String id;
  final String? eventType;
  final String? timestamp;
  final String? location;
  final String? source;
  final double? latitude;
  final double? longitude;
  final int? confidence;
  final bool? requiresApproval;

  const SingleCheck( {
    required this.id,
    required this.eventType,
    required this.timestamp,
    required this.location,
    required this.source,
    required this.latitude,
    required this.longitude,
    required this.confidence,required this.requiresApproval,
  });
}
class LastAttendance {
  SingleCheck? checkIn ;
  SingleCheck? checkOut ;
  LastAttendance({required this.checkIn, required this.checkOut});
}

class TodayWorkTime {
String? workTime;
num? totalMinutes;
String? status;
String? checkInTime;
String? checkOutTime;
bool? isLate;
num? overTime;
TodayWorkTime({required this.workTime, required this.totalMinutes, required this.status, required this.checkInTime,
  required this.checkOutTime, required this.isLate, required this.overTime});
}
