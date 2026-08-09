import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/visitor_entity.dart';

class VisitorTransactionModel extends VisitorTransactionEntity {
  const VisitorTransactionModel({
    required super.fullName,
    required super.documentId,
    required super.cardNumber,
    required super.visitorImage,
    required super.documentImage,
    required super.registrationDate,
    required super.expiryDate,
    required super.transactionType,
    required super.areaName,
    required super.transactionCreatedUserId,
    required super.createdUserName,
    required super.status,
    required super.createDate,
    required super.isSuccess,
    required super.phoneNumber,
    required super.companyName,
    required super.unitName,
    required super.statusValue,
  });

  factory VisitorTransactionModel.fromJson(Map<String, dynamic> data) {
    return VisitorTransactionModel(
      fullName: data['fullName'] ?? '',
      documentId: data['documentId'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      visitorImage: data['visitorImage'],
      documentImage: data['documentImage'],
      registrationDate: DateTime.parse(data['registrationDate']),
      expiryDate: DateTime.parse(data['expiryDate']),
      transactionType: data['transactionType'] ?? '',
      transactionCreatedUserId: data['transactionCreatedUserId'] ?? '',
      createdUserName: data['createdUserName'] ?? '',
      status: convertDataToNum(data['status']),
      createDate: DateTime.parse(data['createDate']),
      isSuccess: convertDataToBool(data['isSuccess']),
      phoneNumber: data['phoneNumber'],
      areaName: data['areaName'],
      companyName: data['companyName'],
      unitName: data['unitName'],
      statusValue: data['statusValue'] ?? '',
    );
  }
}
