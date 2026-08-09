import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/tab_model.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiHandel apiHandel;
  AuthRemoteDataSource(this.apiHandel);

  Future<Either<DioException, UserModel>> register(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post(
      'auth/register',
      data,
      isFormData: true,
    );

    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(UserModel.fromJson(r.data['data']));
      },
    );
  }

  Future<Either<DioException, String>> verifyOTP(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('Authentication/VerifyOTP', data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['message']);
    });
  }

  Future<Either<DioException, String>> resetPassword(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('auth/reset-password', data);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['message']);
    });
  }


  Future<Either<DioException, bool>> changePassword(
      Map<String, dynamic> data,
      ) async {
    var response = await apiHandel.post('auth/change-password', data);
    return response.fold((l) => Left(l), (r) {
      return Right(true);
    });
  }


  Future<Either<DioException, UserModel>> getProfile(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('user/getUserProfile', data);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, String>> refreshToken(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('auth/GenrateNewToken', {});
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['data']['token']);
    });
  }

  Future<Either<DioException, UserModel>> login(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('auth/sign-in', data);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, UserModel>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('user/UpdateUser', data,isFormData: true);
    return response.fold((l) => Left(l), (r) {
      return Right(UserModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, String>> forgotPassword(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('auth/forget-password', data);
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

  Future<Either<DioException, bool>> deleteProfile(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('user/delete', data);
    return response.fold((l) => Left(l), (r) {
      return Right(true);
    });
  }

  Future<Either<DioException, TabModel>> getTabsInfo(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('dashboard/TabsInfo', data);
    return response.fold((l) => Left(l), (r) {
      return Right(TabModel.fromJson(r.data['data']));
    });
  }
}
