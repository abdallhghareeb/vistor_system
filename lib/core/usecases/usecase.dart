import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UseCase<Type, Params> {
  Future<Either<DioException, Type>> call();
}
