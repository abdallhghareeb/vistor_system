import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/notification_entity.dart';

abstract class NotificationRepo{
  Future<Either<DioException,List<NotificationEntity>>> getNotifications(Map<String,dynamic> data);
  Future<Either<DioException,num>> unreadCount(Map<String,dynamic> data);
  Future<Either<DioException,bool>> read(Map<String,dynamic> data);
  Future<Either<DioException,bool>> readAll(Map<String,dynamic> data);
  Future<Either<DioException,bool>> registerDevice(Map<String,dynamic> data);
}
