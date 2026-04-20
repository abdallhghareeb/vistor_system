import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.requiresPasswordChange,
    required super.invitationToken,
    required super.token, required super.message,
    required super.requiredWorkTime,
    required super.user, required super.refreshToken,
    required super.attendance,
    required super.todayWorkTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      requiresPasswordChange: convertDataToBool(data['requiresPasswordChange']),
      invitationToken: data['invitationToken'],
      message: data['message'], token: data['token'],
      user: data['user'] != null ? UserDataModel.fromJson(data['user']) : null,
      refreshToken: data['invitationToken'],
      requiredWorkTime: data['requiredWorkTime'],
      attendance: data['lastAttendance'] != null ?
      LastAttendanceModel.fromJson(data['lastAttendance']) : null,
      todayWorkTime: data['todayWorkTime'] != null ?
      TodayWorkTimeModel.fromJson(data['todayWorkTime']) : null,
    );
  }
}

class UserDataModel extends UserDataEntity {
  UserDataModel({
    required super.id,
    required super.email,
    required super.employeeId,
    required super.username,
    required super.employeeCode,
    required super.roles, required super.status, required super.fullName,
    required super.mobileNumber, required super.profileImagePath,
    required super.employee,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> data) {
    return UserDataModel(
      id: data['id'],
      email: data['email'],
      employeeId: data['employeeId'],
      username: data['username'],
      employeeCode: data['employeeCode'],
      roles: List<String>.from(data['roles'] ?? []),
      status: data['status'],
      fullName: data['fullName'],
      mobileNumber: data['mobileNumber'],
      profileImagePath: data['profileImagePath'],
      employee: data['employee'] != null ? EmployeeModel.fromJson(data['employee']) : null,

    );
  }
}

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required super.id,
    required super.name,
    required super.personId,
    required super.department,
    required super.position,
    required super.profileImagePath,
    required super.employeeCode,
    required super.shift,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> data) {
    return EmployeeModel(
      id: data['id'],
      name: data['name'],
      personId: data['personId'],
      department: data['department'],
      position: data['position'],
      employeeCode: data['employeeCode'],
      profileImagePath: data['profileImagePath'],
      shift: data['shift'] != null ? EmployeeShiftModel.fromJson(data['shift']) : null,
    );
  }
}

class EmployeeShiftModel extends EmployeeShiftEntity {
  EmployeeShiftModel({
    required super.id,
    required super.name,
    required super.startTime,
    required super.endTime,
    required super.workDays,
    required super.graceMinutes,
  });

  factory EmployeeShiftModel.fromJson(Map<String, dynamic> json) {
    return EmployeeShiftModel(
      id: json['id'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      workDays: List<int>.from(json['workDays'] ?? []),
      graceMinutes: json['graceMinutes'],
    );
  }
}

class AttendanceModel extends SingleCheck {
  AttendanceModel({
    required super.id,
    required super.eventType,
    required super.timestamp,
    required super.location,
    required super.source,
    required super.latitude,
    required super.longitude,
    required super.confidence,
    required super.requiresApproval,
  });
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      eventType: json['eventType'],
      timestamp: json['timestamp'],
      location: json['location'],
      source: json['source'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      confidence: json['confidence'],
      requiresApproval: json['requiresApproval'],
    );
  }
}

class LastAttendanceModel extends LastAttendance{
  LastAttendanceModel({required super.checkIn,required super.checkOut,});
  factory LastAttendanceModel.fromJson(Map<String, dynamic> json) {
    return LastAttendanceModel(
      checkIn:json['lastCheckIn'] != null ? AttendanceModel.fromJson(json['lastCheckIn']) : null,
      checkOut:json['lastCheckOut'] != null ? AttendanceModel.fromJson(json['lastCheckOut']) : null,
    );
  }
}

class TodayWorkTimeModel extends TodayWorkTime{
  TodayWorkTimeModel({
    required super.workTime,
    required super.totalMinutes,
    required super.status,
    required super.checkInTime,
    required super.checkOutTime,
    required super.isLate,
    required super.overTime,
  });
  factory TodayWorkTimeModel.fromJson(Map<String, dynamic> json) {
    return TodayWorkTimeModel(
      workTime: json['workTime'],
      totalMinutes: json['totalMinutes'],
      status: json['status'],
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'],
      isLate: json['isLate'],
      overTime: convertDataToNum(json['overTime']),
    );
  }
}