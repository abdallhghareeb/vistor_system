import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/excuse_repo.dart';
import '../datasources/remote.dart';
import '../models/excuse_model.dart';

class ExcuseRepoImpl implements ExcuseRepo {
  final ExcuseRemoteDataSource excuseRemoteDataSource;

  ExcuseRepoImpl(this.excuseRemoteDataSource);

  @override
  Future<Either<DioException, ExcuseModel>> createExcuse(Map<String, dynamic> data) async {
    return await excuseRemoteDataSource.createExcuse(data);
  }

  @override
  Future<Either<DioException, List<ExcuseModel>>> getMyExcuse(Map<String, dynamic> data) async {
    return await excuseRemoteDataSource.getMyExcuse(data);
  }
}
