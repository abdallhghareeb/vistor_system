import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/tab_entity.dart';
import '../entities/user_entity.dart';

abstract class UserRepo{
  Future<Either<DioException,UserEntity>> register(Map<String,dynamic> data);
  Future<Either<DioException,UserEntity>> login(Map<String,dynamic> data);
  Future<Either<DioException,UserEntity>> getProfile(Map<String, dynamic> data);
  Future<Either<DioException,UserEntity>> updateProfile(Map<String, dynamic> data);
  Future<Either<DioException,String>> verifyOTP(Map<String,dynamic> data);
  Future<Either<DioException,String>> resetPassword(Map<String,dynamic> data);
  Future<Either<DioException,String>> refreshToken(Map<String,dynamic> data);
  Future<Either<DioException,String>> forgotPassword(Map<String,dynamic> data);
  Future<Either<DioException,bool>> logout(Map<String,dynamic> data);
  Future<Either<DioException,bool>> deleteProfile(Map<String,dynamic> data);
  Future<Either<DioException,TabEntity>> getTabsInfo(Map<String,dynamic> data);
  Future<Either<DioException,bool>> changePassword(Map<String,dynamic> data);
}