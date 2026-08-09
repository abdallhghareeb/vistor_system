import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/version_entity.dart';

abstract class SettingsRepo {
  Future<Either<DioException, VersionEntity>> mobileVersion();
}
