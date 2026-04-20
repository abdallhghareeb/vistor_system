import 'package:intl/intl.dart';

import '../../../../core/helper_function/convert.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity{
  NotificationModel({required super.title, required super.description, required super.createdAt, required super.isRead, required super.id});


  factory NotificationModel.fromJson(Map data){
    DateTime? date;
    if(data['createdAtLocal'] !=null){
      date = DateFormat("MM/dd/yyyy, HH:mm:ss").parse(data['createdAtLocal']).toLocal();

    }
    return NotificationModel(title: data['title'], description: data['message'],
        createdAt:getDiffTime(date??DateTime.now()), isRead: convertDataToBool(data['isRead']), id: data['id'].toString());
  }
}
