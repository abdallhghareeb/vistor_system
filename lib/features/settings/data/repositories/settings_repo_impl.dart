import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/version_entity.dart';
import '../../domain/repositories/settings_repo.dart';
import '../datasources/remote.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsRemoteDataSource settingsRemoteDataSource;

  SettingsRepoImpl(this.settingsRemoteDataSource);

  @override
  Future<Either<DioException, VersionEntity>> mobileVersion() async {
    return settingsRemoteDataSource.mobileVersion();
  }
}
