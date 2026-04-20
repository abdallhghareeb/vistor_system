import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/history_repo.dart';
import '../datasources/remote.dart';
import '../models/attendance_model.dart';
import '../models/check_model.dart';
import '../models/my_work_model.dart';

class HistoryRepoImpl implements HistoryRepo {
  final HistoryRemoteDataSource authRemoteDatasource;

  HistoryRepoImpl(this.authRemoteDatasource);

  @override
  Future<Either<DioException, MyWorkModel>> getMyWorkData(Map<String, dynamic> data) async {
    return await authRemoteDatasource.getMyWorkData(data);
  }
  @override
  Future<Either<DioException, List<AttendanceModel>>> getAttendanceHistory(Map<String, dynamic> data) async {
    return await authRemoteDatasource.getAttendanceHistory(data);
  }

  @override
  Future<Either<DioException, CheckModel>> checkIn(Map<String, dynamic> data) async {
    return await authRemoteDatasource.checkIn(data);
  }

  @override
  Future<Either<DioException, CheckModel>> checkOut(Map<String, dynamic> data) async {
    return await authRemoteDatasource.checkOut(data);
  }

}
