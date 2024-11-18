import 'dart:math';

import 'package:flutter/material.dart';

enum TabletScreenSize {
  small,
  medium,
  large,
}

class ScreenSizeHelper {
  static TabletScreenSize determineTabletScreenSize(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final width = mediaQuery.width;
    final height = mediaQuery.height;

    // Calculate the diagonal size using Pythagorean theorem
    final diagonal = sqrt(width * width + height * height);

    // Categorize based on diagonal size in logical pixels
    // print('diagonal $width');
    // print('diagonal $height');
    print('diagonal $diagonal');
    switch (diagonal) {
      case < 1000:
        return TabletScreenSize.small;
      case < 1110.0:
        return TabletScreenSize.medium;
      default:
        return TabletScreenSize.large;
    }
  }
}
