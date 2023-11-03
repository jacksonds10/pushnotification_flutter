import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({Key? key}) : super(key: key);
  static const route ='/notificationpage';

  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)?.settings.arguments;
    final RemoteMessage message = ModalRoute.of(context)?.settings.arguments as RemoteMessage;


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 174, 216, 255),
      appBar: AppBar(
        title: const Text('Novidades'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text('${message.notification?.title}'),
            Text('${message.notification?.body}'),
            Text('${message.data}'),
          //  Text('${message.data}')
          ],
        ),
      ),
    );
  }
}
