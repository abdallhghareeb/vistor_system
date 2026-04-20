import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/zone_entity.dart';

abstract class SettingsRepo {
  Future<Either<DioException, List<ZoneEntity>>> getZones();
}
