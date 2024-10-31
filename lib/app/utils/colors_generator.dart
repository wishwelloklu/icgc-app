import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomDarkerPrimaryColor({double threshold = 0.5}) {
  final darkerColors = Colors.primaries
      .where((color) => color.computeLuminance() < threshold)
      .toList();
  if (darkerColors.isEmpty) {
    throw Exception("No dark colors found with the given threshold.");
  }
  return darkerColors[Random().nextInt(darkerColors.length)];
}
