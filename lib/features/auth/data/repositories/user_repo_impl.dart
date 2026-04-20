import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/user_repo.dart';
import '../datasources/remote.dart';
import '../models/user_model.dart';

class UserRepoImpl implements UserRepo {
  final AuthRemoteDataSource authRemoteDatasource;

  UserRepoImpl({required this.authRemoteDatasource});

  @override
  Future<Either<DioException, String>> forgotPassword(Map<String, dynamic> data) async {
    return await authRemoteDatasource.forgotPassword(data);
  }

 @override
  Future<Either<DioException, String>> refreshToken(
      Map<String, dynamic> data) async {
    return await authRemoteDatasource.refreshToken(data);
  }

  @override
  Future<Either<DioException, String>> verifyOTP(Map<String, dynamic> data) async{
    return await authRemoteDatasource.verifyOTP(data);
  }

  @override
  Future<Either<DioException, String>> resetPassword(Map<String, dynamic> data) async{
    return await authRemoteDatasource.resetPassword(data);
  }

  @override
  Future<Either<DioException, UserModel>> login(
      Map<String, dynamic> data) async {
    return await authRemoteDatasource.login(data);
  }

  @override
  Future<Either<DioException, UserModel>> getProfile(Map<String, dynamic> data) async {
    return await authRemoteDatasource.getProfile(data);
  }

  @override
  Future<Either<DioException, bool>> logout(Map<String, dynamic> data) async {
    return await authRemoteDatasource.logout(data);
  }

  @override
  Future<Either<DioException, UserModel>> register(
      Map<String, dynamic> data) async {
    return await authRemoteDatasource.register(data);
  }

  @override
  Future<Either<DioException, UserModel>> updateProfile(Map<String, dynamic> data) async {
    return await authRemoteDatasource.updateProfile(data);
  }
  @override
  Future<Either<DioException, String>> getDomain(Map<String, dynamic> data) async {
    return await authRemoteDatasource.getDomain(data);
  }
  @override
  Future<Either<DioException, bool>> deleteProfile(Map<String, dynamic> data) async {
    return await authRemoteDatasource.deleteProfile(data);
  }

}
