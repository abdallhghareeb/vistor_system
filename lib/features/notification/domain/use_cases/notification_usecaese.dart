import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/notification_entity.dart';
import '../repositories/notification_repo.dart';

class NotificationUseCases {
  NotificationRepo notificationRepo;

  NotificationUseCases(this.notificationRepo);

  Future<Either<DioException, List<NotificationEntity>>> getNotifications(
    Map<String, dynamic> data,
  ) async {
    return await notificationRepo.getNotifications(data);
  }

  Future<Either<DioException, num>> unreadCount(
    Map<String, dynamic> data,
  ) async {
    return await notificationRepo.unreadCount(data);
  }

  Future<Either<DioException, bool>> read(Map<String, dynamic> data) async {
    return await notificationRepo.read(data);
  }

  Future<Either<DioException, bool>> readAll(Map<String, dynamic> data) async {
    return await notificationRepo.readAll(data);
  }

  Future<Either<DioException, bool>> registerDevice(
    Map<String, dynamic> data,
  ) async {
    return await notificationRepo.registerDevice(data);
  }

  Future<Either<DioException, bool>> unRegisterDevice(Map<String, dynamic> data,) async {
    return await notificationRepo.unRegisterDevice(data);
  }

}
