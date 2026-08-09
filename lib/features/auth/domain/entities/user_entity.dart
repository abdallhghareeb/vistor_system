import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  String? token;
  String email;
  String? username;
  String? userId;
  bool isActive;
  String?pictureUrl;
  String? accountStatus;
  String? status;
  bool emailConfirmed;
  String? phoneNumber;

  UserEntity({
    required this.userId,
    required this.token,
    required this.email,
    required this.status,
    required this.accountStatus,
    required this.emailConfirmed,
    required this.phoneNumber,
    required this.username,
    required this.isActive,
    required this.pictureUrl,
  });

  @override
  List<Object?> get props => [
        token,
        email,
        username,
        userId,
        isActive,
        pictureUrl,
        accountStatus,
        status,
        emailConfirmed,
        phoneNumber,
      ];
}

