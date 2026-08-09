import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/visitor_entity.dart';

abstract class VisitorsRepo {
  Future<Either<DioException, List<VisitorTransactionEntity>>>
  getAllTransactions(Map<String, dynamic> data);
}
