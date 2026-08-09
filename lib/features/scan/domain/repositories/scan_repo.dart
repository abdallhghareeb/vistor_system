import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/scan_entity.dart';

abstract class ScanRepo {
  Future<Either<DioException, ScanEntity>> getInvitationByCardNumber(
    Map<String, dynamic> data,
  );

  Future<Either<DioException, bool>> createTransaction(
    Map<String, dynamic> data,
  );
}
