import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/scan_entity.dart';
import '../repositories/scan_repo.dart';

class ScanUseCases {
  final ScanRepo scanRepo;

  const ScanUseCases(this.scanRepo);

  Future<Either<DioException, ScanEntity>> getInvitationByCardNumber(
    Map<String, dynamic> data,
  ) {
    return scanRepo.getInvitationByCardNumber(data);
  }

  Future<Either<DioException, bool>> createTransaction(
    Map<String, dynamic> data,
  ) {
    return scanRepo.createTransaction(data);
  }
}
