import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../models/visitor_model.dart';

class VisitorsRemoteDataSource {
  final ApiHandel apiHandel;

  const VisitorsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<VisitorTransactionModel>>>
  getAllTransactions(Map<String, dynamic> data) async {
    var response = await apiHandel.get('report/AllTransactionReport', data);

    return response.fold((l) => Left(l), (r) {
      List<VisitorTransactionModel> list = [];
      for (var item in r.data['data']['data']) {
        list.add(VisitorTransactionModel.fromJson(item));
      }
      return Right(list);
    });
  }
}
