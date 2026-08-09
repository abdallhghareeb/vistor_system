import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repo.dart';
import '../data_sources/remote.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepoImpl(this.notificationRemoteDataSource);

  @override
  Future<Either<DioException, List<NotificationEntity>>> getNotifications(
    Map<String, dynamic> data,
  ) async {
    return await notificationRemoteDataSource.getNotifications(data);
  }

  @override
  Future<Either<DioException, num>> unreadCount(
    Map<String, dynamic> data,
  ) async {
    return await notificationRemoteDataSource.unreadCount(data);
  }

  @override
  Future<Either<DioException, bool>> read(Map<String, dynamic> data) async {
    return await notificationRemoteDataSource.read(data);
  }

  @override
  Future<Either<DioException, bool>> readAll(Map<String, dynamic> data) async {
    return await notificationRemoteDataSource.readAll(data);
  }

  @override
  Future<Either<DioException, bool>> registerDevice(
    Map<String, dynamic> data,
  ) async {
    return await notificationRemoteDataSource.registerDevice(data);
  }

  @override
  Future<Either<DioException, bool>> unRegisterDevice(
      Map<String, dynamic> data,
      ) async {
    return await notificationRemoteDataSource.unRegisterDevice(data);
  }

}
