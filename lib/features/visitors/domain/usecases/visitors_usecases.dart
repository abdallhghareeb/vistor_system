import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/visitor_entity.dart';
import '../repositories/visitors_repo.dart';

class VisitorsUseCases {
  final VisitorsRepo visitorsRepo;

  const VisitorsUseCases(this.visitorsRepo);

  Future<Either<DioException, List<VisitorTransactionEntity>>>
  getAllTransactions(Map<String, dynamic> data) async {
    return visitorsRepo.getAllTransactions(data);
  }
}
