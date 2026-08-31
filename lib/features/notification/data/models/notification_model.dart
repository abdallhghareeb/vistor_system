import 'package:intl/intl.dart';

import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.title,
    required super.description,
    required super.createdAt,
    required super.isRead,
    required super.id,
  });

  factory NotificationModel.fromJson(Map data) {
    DateTime? date;
    if (data['createDate'] != null) {
      date = DateTime.parse(data['createDate']).toLocal();
    }
    return NotificationModel(
      title: data['title'],
      description: data['body'],
      createdAt: getDiffTime(date ?? DateTime.now()),
      isRead: convertDataToBool(data['isRead']),
      id: data['id'].toString(),
    );
  }
}
