import 'package:flutter/material.dart';
import 'package:push/pages/home_page.dart';
import 'package:push/pages/notificacaopage.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => const HomePage(),
    '/notificacao': (_) => const NotificacaoPage(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
