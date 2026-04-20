import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/attendance_model.dart';
import '../models/check_model.dart';
import '../models/my_work_model.dart';

class HistoryRemoteDataSource {
  final ApiHandel apiHandel;
  HistoryRemoteDataSource(this.apiHandel);

  Future<Either<DioException, MyWorkModel>> getMyWorkData(Map<String, dynamic> data) async {
    var response = await apiHandel.get('mobile/employee/dashboard', data);
    return response.fold((l) => Left(l), (r) {
      return  Right(MyWorkModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, List<AttendanceModel>>> getAttendanceHistory(Map<String, dynamic> data) async {
    var response = await apiHandel.get('mobile/employee/attendance', data);
    return response.fold((l) => Left(l), (r) {
      List<AttendanceModel> attendanceList = [];
      for (var element in r.data['data']['attendance']) {
        attendanceList.add(AttendanceModel.fromJson(element));
      }
      return  Right(attendanceList);
    });
  }

  Future<Either<DioException, CheckModel>> checkOut(Map<String, dynamic> data) async {
    var response = await apiHandel.post('vistor/CheckOut', data);
    return response.fold((l) => Left(l), (r) {
      return  Right(CheckModel.fromJson(r.data['data']));
    });
  }
  Future<Either<DioException, CheckModel>> checkIn(Map<String, dynamic> data) async {
    var response = await apiHandel.post('vistor/CheckIn', data);
    return response.fold((l) => Left(l), (r) {
      return  Right(CheckModel.fromJson(r.data['data']));
    });
  }




}
