import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/visitor_entity.dart';
import '../../domain/repositories/visitors_repo.dart';
import '../data_sources/remote.dart';

class VisitorsRepoImpl implements VisitorsRepo {
  final VisitorsRemoteDataSource visitorsRemoteDataSource;

  const VisitorsRepoImpl(this.visitorsRemoteDataSource);

  @override
  Future<Either<DioException, List<VisitorTransactionEntity>>>
  getAllTransactions(Map<String, dynamic> data) async {
    return visitorsRemoteDataSource.getAllTransactions(data);
  }
}
