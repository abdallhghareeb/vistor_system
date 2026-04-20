import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/notification/presentation/provider/notification_provider.dart';
import '../constants/constants.dart';
import '../models/local_notifications.dart';

Future notificationsFirebase()async{
  FirebaseMessaging.onMessage.listen((event) async{
    if(event.notification!=null){
      appNotifications(event.notification!,payload: event.data,fromWhereClicked: 1);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) async{

    if(event.notification!=null){
      appNotifications(event.notification!,click: false,fromWhereClicked: 2,
          payload: event.data);
    }
  });
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      sound: true, badge: false, alert: true,criticalAlert: true,provisional: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {

  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {

  } else {

  }
}


void appNotifications(RemoteNotification data2,
    {bool click = false,bool start = false,Map? payload,required int fromWhereClicked})async {
  bool showNotificationLocal = true;
  NotificationProvider notificationProvider=Provider.of<NotificationProvider>(Constants.globalContext(),listen: false);
  notificationProvider.unReadNum+=1;

  if(click&&AuthProvider.isLogin()&&fromWhereClicked==2){
    clickNoti(jsonEncode(payload));
    NotificationLocalClass.notificationsPlugin.cancelAll();
  }
  if(showNotificationLocal&&AuthProvider.isLogin()&&!click){
    NotificationLocalClass.showNoti(title: data2.title??"", body: data2.body??"", payload: jsonEncode(payload));
  }

}