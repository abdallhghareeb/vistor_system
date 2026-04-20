import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/zone_entity.dart';
import '../repositories/settings_repo.dart';

class SettingsUseCases {
  SettingsRepo settingsRepo;

  SettingsUseCases(this.settingsRepo);


  Future<Either<DioException, List<ZoneEntity>>> getZones() async {
    return settingsRepo.getZones();
  }


}
