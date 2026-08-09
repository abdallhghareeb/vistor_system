class ScanEntity {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String documentId;
  final String cardNumber;
  final String areaNames;
  final dynamic areaId;
  final String qrLink;
  final int invitDocType;
  final String name;
  final String visitorImage;
  final DateTime? registrationDate;
  final DateTime? expiryDate;
  final DateTime? createDate;
  final int status;
  final String visitType;
  final String? customVisitType;
  final String createdUserId;
  final String createdUserName;
  final String? lastUpdatedUserId;
  final String? updatedUserName;
  final bool isSuccess;
  final String documentImage;
  final String? transactionType;
  final String? company;
  final String statusValue;

  const ScanEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.documentId,
    required this.cardNumber,
    required this.areaNames,
    this.areaId,
    required this.qrLink,
    required this.invitDocType,
    required this.name,
    required this.visitorImage,
    this.registrationDate,
    this.expiryDate,
    this.createDate,
    required this.status,
    required this.visitType,
    this.customVisitType,
    required this.createdUserId,
    required this.createdUserName,
    this.lastUpdatedUserId,
    this.updatedUserName,
    required this.isSuccess,
    required this.documentImage,
    this.transactionType,
    this.company,
    required this.statusValue,
  });
}
