import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/tab_entity.dart';

class TabModel extends TabEntity {
 const TabModel({
    required super.totalInvitation,
    required super.pending,
    required super.entered,
    required super.exited,
    required super.totalTransaction,
  });

  factory TabModel.fromJson(Map<String, dynamic> data) {
    return TabModel(
        entered: convertDataToNum(data['entered']),
        exited: convertDataToNum(data['exited']),
        totalTransaction: convertDataToNum(data['totalTransaction']),
        pending: convertDataToNum(data['pending']),
        totalInvitation: convertDataToNum(data['totalInvitation']),
    );
  }
}

