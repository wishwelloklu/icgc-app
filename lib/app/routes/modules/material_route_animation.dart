import 'package:flutter/material.dart';

class MaterialRouteAnimation extends PageRouteBuilder {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  MaterialRouteAnimation({
    required this.builder,
    required this.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          settings: settings,
          transitionDuration:
              const Duration(milliseconds: 300), // Adjust duration as needed
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Define the scale animation with a smooth curve
    final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
    );

    return ScaleTransition(
      scale: scaleAnimation,
      child: child,
    );
  }
}
