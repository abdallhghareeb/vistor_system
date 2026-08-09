import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/version_model.dart';

class SettingsRemoteDataSource {
  final ApiHandel apiHandel;
  SettingsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, VersionModel>> mobileVersion() async {
    var response = await apiHandel.get('MobileVersion');
    return response.fold((l) => Left(l), (r) {
      return Right(VersionModel.fromJson(r.data['data']));
    });
  }
}
