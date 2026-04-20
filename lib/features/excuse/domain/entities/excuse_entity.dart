class ExcuseEntity {
  final String id;
  final String employeeId;
  final String excuseType;
  final String date;
  final String reason;
  final String? attachmentPath;
  final String status;
  final String createdBy;
  final String? approvedBy;
  final String? approvedAt;
  final String createdAt;
  final EmployeeEntity employee;
  ExcuseEntity({required this.id, required this.employeeId, required this.excuseType,
    required this.date, required this.reason, required this.attachmentPath,
    required this.status, required this.createdBy, required this.approvedBy,
    required this.approvedAt, required this.createdAt, required this.employee});
}

class EmployeeEntity {
  final String id;
  final String name;
  final String department;
  final UserEntity user;
  EmployeeEntity({required this.id, required this.name, required this.department, required this.user});
}

class UserEntity {
  final String id;
  UserEntity({required this.id});
}
