import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/excuse_entity.dart';
import '../repositories/excuse_repo.dart';

class ExcuseUsecases{

  ExcuseRepo excuseRepo;
  ExcuseUsecases(this.excuseRepo);

  Future<Either<DioException, ExcuseEntity>> createExcuse(Map<String,dynamic> data){
    return excuseRepo.createExcuse(data);
  }
  Future<Either<DioException, List<ExcuseEntity>>> getMyExcuse(Map<String,dynamic> data){
    return excuseRepo.getMyExcuse(data);
  }

}