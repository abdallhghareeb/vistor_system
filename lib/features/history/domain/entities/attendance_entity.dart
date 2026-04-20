class AttendanceEntity {
  final String id;
  final String date;
  final String status;
  final String? checkInTime;
  final String? checkOutTime;
  final String? workTime;
  final int? totalWorkMinutes;
  final bool isLate;
  final EventEntity? checkInEvent;
  final EventEntity? checkOutEvent;
  AttendanceEntity({required this.id, required this.date, required this.status,
    required this.checkInTime, required this.checkOutTime, required this.workTime,
    required this.isLate,
    required this.totalWorkMinutes, required this.checkInEvent, required this.checkOutEvent});
}

class EventEntity {
  final String timestamp;
  final String location;
  final int confidence;
  final String source;
  EventEntity({required this.timestamp, required this.location, required this.confidence, required this.source});
}


