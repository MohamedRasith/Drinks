import 'package:flutter/material.dart';

class Globals {
  const Globals._();

  // static String? idToken;
  // static String? fcmToken;
  // static String? deviceId;

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static BuildContext get context => navigatorKey.currentContext!;
}
