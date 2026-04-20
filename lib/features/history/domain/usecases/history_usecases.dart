import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/check_in_entity.dart';
import '../entities/my_work_entity.dart';
import '../entities/attendance_entity.dart';
import '../repositories/history_repo.dart';

class HistoryUsecases{

  HistoryRepo historyRepo;
  HistoryUsecases(this.historyRepo);

  Future<Either<DioException, MyWorkEntity>> getMyWorkData(Map<String, dynamic> data) async{
    return await  historyRepo.getMyWorkData(data);
  }
  Future<Either<DioException, List<AttendanceEntity>>> getAttendanceHistory(Map<String, dynamic> data) async{
    return await  historyRepo.getAttendanceHistory(data);
  }

  Future<Either<DioException, CheckEntity>> checkIn(Map<String, dynamic> data) async{
    return await  historyRepo.checkIn(data);
  }

  Future<Either<DioException, CheckEntity>> checkOut(Map<String, dynamic> data) async{
    return await  historyRepo.checkOut(data);
  }
}