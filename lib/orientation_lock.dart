import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrientationLock extends StatelessWidget {
  final Widget child;

  const OrientationLock({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double shortestSide = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        if (shortestSide >= 600) {
          Hive.box<bool>('device').put('device', true);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          Hive.box<bool>('device').put('device', false);
          // Phone: allow all orientations (or customize as needed).
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        }

        // Return the child widget (usually your MaterialApp) unmodified.
        return child;
      },
    );
  }
}
