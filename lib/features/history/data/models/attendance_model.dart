import 'package:intl/intl.dart';
import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  AttendanceModel({required super.id, required super.date, required super.status,
    required super.checkInTime, required super.checkOutTime, required super.workTime,
    required super.isLate,
    required super.totalWorkMinutes, required super.checkInEvent, required super.checkOutEvent});

  factory AttendanceModel.fromJson(Map<String, dynamic> data) {
    DateTime ?checkOutTime;
    DateTime ?checkInTime;

    if(data['checkInDateTimeLocal'] !=null){
      checkInTime = DateFormat("MM/dd/yyyy, HH:mm:ss").parse(data['checkInDateTimeLocal']).toLocal();
    }
    if(data['checkOutDateTimeLocal'] !=null){
      checkOutTime = DateFormat("MM/dd/yyyy, HH:mm:ss").parse(data['checkOutDateTimeLocal']).toLocal();
    }
    return AttendanceModel(
      id: data['id'],
      date: data['date'],
      status: data['status'],
      checkInTime:checkInTime!=null? convertDateToTime(checkInTime) :null,
      checkOutTime:checkOutTime!=null? convertDateToTime(checkOutTime) :null,
      isLate: convertDataToBool(data['isLate']),
      workTime: data['workTime'],
      totalWorkMinutes: convertStringToInt(data['totalWorkMinutes']),
      checkInEvent: data['checkInEvent'] == null ? null : EventModel.fromJson(data['checkInEvent']),
      checkOutEvent: data['checkOutEvent'] == null ? null : EventModel.fromJson(data['checkOutEvent']),
    );
  }
}

class EventModel extends EventEntity {
  EventModel({required super.timestamp,required super.location,required super.confidence,required super.source});
  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      timestamp: data['timestamp'],
      location: data['location'],
      confidence: data['confidence'],
      source: data['source'],
    );
  }
}


