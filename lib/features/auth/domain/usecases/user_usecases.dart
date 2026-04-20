import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repo.dart';

class UserUseCases{

  UserRepo userRepo;
  UserUseCases(this.userRepo);

  Future<Either<DioException, String>> forgotPassword(Map<String, dynamic> data) async{
    return await  userRepo.forgotPassword(data);
  }

  Future<Either<DioException, String>> refreshToken(Map<String, dynamic> data) async{
    return await  userRepo.refreshToken(data);
  }

  Future<Either<DioException, String>> verifyOTP(Map<String, dynamic> data) async{
    return await  userRepo.verifyOTP(data);
  }

  Future<Either<DioException, UserEntity>> login(Map<String, dynamic> data) async{
    return await  userRepo.login(data);
  }

  Future<Either<DioException, UserEntity>> getProfile(Map<String, dynamic> data) async{
    return await  userRepo.getProfile(data);
  }

  Future<Either<DioException, bool>> logout(Map<String, dynamic> data) async{
    return await  userRepo.logout(data);
  }

  Future<Either<DioException, UserEntity>> register(Map<String, dynamic> data) async{
    return await  userRepo.register(data);
  }

  Future<Either<DioException, UserEntity>> updateProfile(Map<String, dynamic> data) async{
    return await  userRepo.updateProfile(data);
  }

  Future<Either<DioException, String>> resetPassword(Map<String, dynamic> data) async{
    return await  userRepo.resetPassword(data);
  }

  Future<Either<DioException, String>> getDomain(Map<String, dynamic> data) async{
    return await  userRepo.getDomain(data);
  }

  Future<Either<DioException, bool>> deleteProfile(Map<String, dynamic> data) async{
    return await  userRepo.deleteProfile(data);
  }


}