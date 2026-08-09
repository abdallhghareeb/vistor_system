import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/scan_repo.dart';
import '../data_sources/remote.dart';
import '../models/scan_model.dart';

class ScanRepoImpl implements ScanRepo {
  final ScanRemoteDataSource remoteDataSource;

  const ScanRepoImpl(this.remoteDataSource);

  @override
  Future<Either<DioException, ScanModel>> getInvitationByCardNumber(
    Map<String, dynamic> data,
  ) {
    return remoteDataSource.getInvitationByCardNumber(data);
  }

  @override
  Future<Either<DioException, bool>> createTransaction(
    Map<String, dynamic> data,
  ) {
    return remoteDataSource.createTransaction(data);
  }
}
