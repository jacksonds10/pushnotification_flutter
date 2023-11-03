import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push/main.dart';
import 'package:push/pages/notificacaopage.dart';
import 'package:push/rotas.dart';

Future<void>mensagemBackgroud(RemoteMessage message) async{
  print('Title:${message.notification?.title}');
  print('Body:${message.notification?.body}');
  print('Payload:${message.data}');

}

class FirebaseApi {
final _firebaseMessaging = FirebaseMessaging.instance;

final _androidChannel = const AndroidNotificationChannel(
  'high_importance_chanel',
  'High Inportance Notifications',
  description: 'This chanell is used for importance notification',
  importance: Importance.max,
  enableVibration: true,
  );
  final _localNotificacao = FlutterLocalNotificationsPlugin();



void handleMessage(RemoteMessage? message){
  if (message == null) return;
  navigatorKey.currentState?.pushNamed(NotificacaoPage.route,
  arguments:message,
  );
}

Future initLocalNotificacao() async {
    const iOS =IOSInitializationSettings();
    const android =AndroidInitializationSettings('@drawable/ic_launcher');

    const settings = InitializationSettings(android: android, iOS: iOS);
    
    await _localNotificacao.initialize(
      settings,
      onSelectNotification: (payload){
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      handleMessage(message);
      }
    );
    final platform = _localNotificacao.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);

}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(mensagemBackgroud);
  FirebaseMessaging.onMessage.listen((message){
    final notificacao = message.notification;
    if (notificacao == null) return;
    _localNotificacao.show(
      notificacao.hashCode,
      notificacao.title,
      notificacao.body,
      NotificationDetails(
        android:AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.toMap())
    );

  });

}
  Future<void> initNotifications() async {
    await  _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token:$fcmToken');

  initPushNotifications();
  initLocalNotificacao();
  }

}