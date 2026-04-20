import '../../domain/entities/excuse_entity.dart';

class ExcuseModel extends ExcuseEntity {
  ExcuseModel({required super.id, required super.employeeId, required super.excuseType,
    required super.date, required super.reason, required super.attachmentPath,
    required super.status, required super.createdBy, required super.approvedBy,
    required super.approvedAt, required super.createdAt, required super.employee});

  factory ExcuseModel.fromJson(Map<String, dynamic> data) {
    return ExcuseModel(
      id: data['id'],
      employeeId: data['employeeId'],
      excuseType: data['excuseType'],
      date: data['date'],
      reason: data['reason'],
      attachmentPath: data['attachmentPath'],
      status: data['status'],
      createdBy: data['createdBy'],
      approvedBy: data['approvedBy'],
      approvedAt: data['approvedAt'],
      createdAt: data['createdAt'],
      employee: EmployeeModel.fromJson(data['employee']),
    );
  }
}

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({required super.id, required super.name, required super.department, required super.user});

  factory EmployeeModel.fromJson(Map<String, dynamic> data) {
    return EmployeeModel(
      id: data['id'],
      name: data['name'],
      department: data['department'],
      user: UserModel.fromJson(data['user']),
    );
  }
}

class UserModel extends UserEntity {
  UserModel({required super.id});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
    );
  }
}
