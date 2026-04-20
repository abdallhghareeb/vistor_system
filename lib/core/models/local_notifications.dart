import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/notification/presentation/provider/notification_provider.dart';
import '../../main.dart';
import '../constants/constants.dart';
import '../helper_function/helper_function.dart';

class NotificationLocalClass {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static Future notificationDet()async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'test','c_name',importance: Importance.max,priority: Priority.high,
          showWhen: true,playSound: true,channelShowBadge: true,channelDescription: 'c_des'
      ),
      iOS: DarwinNotificationDetails(

      ),
    );
  }
  static Future showNoti({int? id,required String title,required String body,required String payload})async{
    try{
      notificationsPlugin.show(id??DateTime.now().millisecond, title, body,await notificationDet(),payload: payload);
      delay(2500).then((value) => notificationsPlugin.cancelAll());
    }catch(e){
      print(e);
    }
  }
  static Future init({bool initScheduled = false})async{
    final settings = InitializationSettings(
      android: const AndroidInitializationSettings('logo'),
      iOS: DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          defaultPresentBadge: true,
          onDidReceiveLocalNotification: (id,title,body,pay)async{
            clickNoti(pay!);
          }
      ),
    );
    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (pay)async{

        clickNoti(pay.payload!);
      },
      onDidReceiveBackgroundNotificationResponse: localMessagingBackgroundHandler,
    );
  }
}

void clickNoti(String pay)async {
  NotificationProvider notificationProvider=Provider.of<NotificationProvider>(Constants.globalContext(),listen: false);
  notificationProvider.unReadNum+=1;
  notificationProvider.rebuild();
  notificationProvider.goToNotificationPage();
}