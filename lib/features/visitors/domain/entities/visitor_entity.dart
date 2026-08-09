class VisitorTransactionEntity {
  final String fullName;
  final String documentId;
  final String cardNumber;
  final String? visitorImage;
  final String? documentImage;
  final String? areaName;
  final DateTime registrationDate;
  final DateTime expiryDate;
  final String transactionType;
  final String transactionCreatedUserId;
  final String createdUserName;
  final num status;
  final DateTime createDate;
  final bool isSuccess;
  final String? phoneNumber;
  final String? companyName;
  final String? unitName;
  final String statusValue;

  const VisitorTransactionEntity({
    required this.fullName,
    required this.documentId,
    required this.cardNumber,
    required this.visitorImage,
    required this.documentImage,
    required this.registrationDate,
    required this.expiryDate,
    required this.transactionType,
    required this.transactionCreatedUserId,
    required this.createdUserName,
    required this.status,
    required this.areaName,
    required this.createDate,
    required this.isSuccess,
    required this.phoneNumber,
    required this.companyName,
    required this.unitName,
    required this.statusValue,
  });

  bool get isCheckIn => transactionType == 'in';
}
