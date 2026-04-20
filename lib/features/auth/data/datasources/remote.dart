import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiHandel apiHandel;
  AuthRemoteDataSource(this.apiHandel);

  Future<Either<DioException, UserModel>> register(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Authentication/SignUp', data);
    return response.fold((l) {
      return  Left(l);
    }, (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException,String>> verifyOTP(Map<String,dynamic> data)async{
    var response = await apiHandel.post('Authentication/VerifyOTP',data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['message']);
    });
  }

  Future<Either<DioException,String>> resetPassword(Map<String,dynamic> data)async{
    var response = await apiHandel.post('Authentication/ResetPassword',data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['message']);
    });
  }

  Future<Either<DioException, UserModel>> getProfile(Map<String, dynamic> data) async {
    var response = await apiHandel.get('Authentication/GetProfile',data);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, String>> refreshToken(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Authentication/RefreshToken', data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['data']['token']);
    });
  }

  Future<Either<DioException, UserModel>> login(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Authentication/MobileLogin', data);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, UserModel>> updateProfile(Map<String, dynamic> data) async {
    var response = await apiHandel.put('Authentication/UpdateProfile', data);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, String>> forgotPassword(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Authentication/ForgotPassword', data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['message']);
    });
  }

  Future<Either<DioException, bool>> logout(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Authentication/Logout', data);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, String>> getDomain(Map<String, dynamic> data) async {
    String id= data['code'];
    data.remove('code');
    var response = await apiHandel.getForDomain('/api/company/code/$id', data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['data']['url']);
    });
  }

  Future<Either<DioException, bool>> deleteProfile(Map<String, dynamic> data) async {
    var response = await apiHandel.delete('Authentication/DeleteProfile', data);
    return response.fold((l) => Left(l), (r) {
      return Right(true);
    });
  }


}
