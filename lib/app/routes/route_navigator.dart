import 'package:flutter/material.dart';

routeNavigator(BuildContext context, String routeName, {dynamic arguments}) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

routeAndRemoveNavigator(BuildContext context, String routeName,
    {dynamic arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      routeName, (Route<dynamic> route) => false,
      arguments: arguments);
}

popBack<T extends Object?>(BuildContext context, [T? result]) async {
  Navigator.pop(context, result);
}
