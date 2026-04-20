import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/excuse_model.dart';

class ExcuseRemoteDataSource {
  final ApiHandel apiHandel;
  ExcuseRemoteDataSource(this.apiHandel);

  Future<Either<DioException, ExcuseModel>> createExcuse(Map<String, dynamic> data) async {
    var response = await apiHandel.post('Excuse', data);
    return response.fold((l) => Left(l), (r) {
      return  Right(ExcuseModel.fromJson(r.data['data']));
    });
  }
  Future<Either<DioException, List<ExcuseModel>>> getMyExcuse(Map<String, dynamic> data) async {
    var response = await apiHandel.get('Excuse', data);
    return response.fold((l) => Left(l), (r) {
      List<ExcuseModel> list=[];
      for(var element in r.data['data']){
        ExcuseModel.fromJson(element);
      }
      return  Right(list);
    });
  }

}
