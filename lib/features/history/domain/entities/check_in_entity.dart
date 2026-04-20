class CheckEntity{
  final String id;
  final String employeeId;
  final String employeeName;
  final String eventType;
  final String timestamp;
  final String location;
  final MatchedZoneEntity? matchedZone;
  final bool pendingApproval;
  final String? approvalId;
  final bool hasActiveZones;
  CheckEntity({required this.id, required this.employeeId, required this.employeeName,
    required this.eventType, required this.timestamp, required this.location,
    required this.matchedZone, required this.pendingApproval,
    required this.approvalId, required this.hasActiveZones});
}
class MatchedZoneEntity{
  final String id;
  final String name;
  MatchedZoneEntity({required this.id, required this.name});
}