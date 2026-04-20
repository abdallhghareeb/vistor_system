import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/excuse_entity.dart';

abstract class ExcuseRepo{
  Future<Either<DioException, ExcuseEntity>> createExcuse(Map<String,dynamic> data);
  Future<Either<DioException, List<ExcuseEntity>>> getMyExcuse(Map<String,dynamic> data);
}