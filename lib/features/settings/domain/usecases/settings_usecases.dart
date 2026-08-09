import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/version_entity.dart';
import '../repositories/settings_repo.dart';

class SettingsUseCases {
  SettingsRepo settingsRepo;

  SettingsUseCases(this.settingsRepo);

  Future<Either<DioException, VersionEntity>> mobileVersion() async {
    return settingsRepo.mobileVersion();
  }
}
