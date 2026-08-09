import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
  required super.userId, required super.token, required super.email,
    required super.status, required super.accountStatus, required super.emailConfirmed,
    required super.phoneNumber, required super.username,
    required super.isActive, required super.pictureUrl});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      accountStatus: data['accountStatus'],
      email: data['email']??"",
      status: data['status'],
      emailConfirmed: convertDataToBool(data['emailConfirmed']),
      isActive: convertDataToBool(data['isActive']),
      phoneNumber: data['phoneNumber'],
      username: data['username'],
      pictureUrl: data['pictureUrl'],
      userId: data['userId'],
      token: data['token'],
    );
  }
}

