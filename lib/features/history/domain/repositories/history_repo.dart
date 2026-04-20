import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/attendance_entity.dart';
import '../entities/check_in_entity.dart';
import '../entities/my_work_entity.dart';

abstract class HistoryRepo{
  Future<Either<DioException,MyWorkEntity>> getMyWorkData(Map<String,dynamic> data);
  Future<Either<DioException,CheckEntity>> checkOut(Map<String,dynamic> data);
  Future<Either<DioException,CheckEntity>> checkIn(Map<String,dynamic> data);
  Future<Either<DioException,List<AttendanceEntity>>> getAttendanceHistory(Map<String,dynamic> data);
}