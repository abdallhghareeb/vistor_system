import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../models/scan_model.dart';

class ScanRemoteDataSource {
  final ApiHandel apiHandel;

  const ScanRemoteDataSource(this.apiHandel);

  Future<Either<DioException, ScanModel>> getInvitationByCardNumber(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('invitation/getbycardnumber', data);
    return response.fold((l) => Left(l), (r) {
      return Right(ScanModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, bool>> createTransaction(
    Map<String, dynamic> data,
  ) async {
    final response = await apiHandel.post('transaction/create', data);
    return response.fold(Left.new, (_) => const Right(true));
  }
}
