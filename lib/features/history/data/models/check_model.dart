import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/check_in_entity.dart';

class CheckModel extends CheckEntity{
  CheckModel({required super.id, required super.employeeId, required super.employeeName,
    required super.eventType, required super.timestamp, required super.location,
    required super.matchedZone, required super.pendingApproval,
    required super.approvalId, required super.hasActiveZones,});

  factory CheckModel.fromJson(Map<String, dynamic> json){
    return CheckModel(
      id: json['id'],
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      eventType: json['eventType'],
      timestamp: json['timestamp'],
      location: json['location'],
      matchedZone: json['matchedZone'] != null ? MatchedZoneModel.fromJson(json['matchedZone']) : null,
      pendingApproval: json['pendingApproval'],
      approvalId: json['approvalId'],
      hasActiveZones: convertDataToBool(json['hasActiveZones']),
    );
  }
}
class MatchedZoneModel extends MatchedZoneEntity{
  MatchedZoneModel({required super.id, required super.name});
  factory MatchedZoneModel.fromJson(Map<String, dynamic> json){
    return MatchedZoneModel(
      id: json['id'],
      name: json['name'],
    );
  }
}