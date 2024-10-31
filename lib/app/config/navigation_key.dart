import 'package:flutter/material.dart';

final appContext = AppNavigatorKeys.instance.navigatorKey.currentContext;

class AppNavigatorKeys {
  AppNavigatorKeys._privateContructor();

  static AppNavigatorKeys instance = AppNavigatorKeys._privateContructor();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
}
