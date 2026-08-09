import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/convert.dart';
import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  final ApiHandel apiHandel;
  NotificationRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<NotificationModel>>> getNotifications(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('notification/get-all', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        List<NotificationModel> list = [];
        for (var i in r.data['data']) {
          list.add(NotificationModel.fromJson(i));
        }
        return Right(list);
      },
    );
  }

  Future<Either<DioException, num>> unreadCount(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('notification/unread-count', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(convertDataToNum(r.data['data']['count']));
      },
    );
  }

  Future<Either<DioException, bool>> read(Map<String, dynamic> data) async {
    String id = data['id'];
    data.remove('id');
    var response = await apiHandel.put('notification/mark-as-read/$id', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(true);
      },
    );
  }

  Future<Either<DioException, bool>> readAll(Map<String, dynamic> data) async {
    var response = await apiHandel.put('notification/mark-all-as-read', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(true);
      },
    );
  }

  Future<Either<DioException, bool>> registerDevice(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('notification/register-device-token', data);
    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(true);
      },
    );
  }

  Future<Either<DioException, bool>> unRegisterDevice(
      Map<String, dynamic> data,
      ) async {
    var response = await apiHandel.post('notification/unregister-device-token', data);
    return response.fold(
          (l) {
        return Left(l);
      },
          (r) {
        return Right(true);
      },
    );
  }

}
