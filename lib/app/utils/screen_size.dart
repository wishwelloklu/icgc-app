import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum DeviceScreenSize {
  small,
  medium,
  large,
}

class ScreenSizeHelper {
  final BuildContext context;
  const ScreenSizeHelper(this.context);
  DeviceScreenSize get determineTabletScreenSize {
    final mediaQuery = MediaQuery.sizeOf(context);
    final width = mediaQuery.width;
    final height = mediaQuery.height;

    // Calculate the diagonal size using Pythagorean theorem
    final diagonal = sqrt(width * width + height * height);

    switch (diagonal) {
      case < 1000:
        return DeviceScreenSize.small;
      case < 1110.0:
        return DeviceScreenSize.medium;
      default:
        return DeviceScreenSize.large;
    }
  }

  DeviceScreenSize get determineDeviceScreenSize {
    final mediaQuery = MediaQuery.sizeOf(context);
    final width = mediaQuery.width;

    switch (width) {
      case >= 1024:
        return DeviceScreenSize.large;
      case >= 600:
        return DeviceScreenSize.medium;
      default:
        return DeviceScreenSize.small;
    }
  }

  bool get isTablet => Hive.box<bool>('device').values.first;
  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;
}
