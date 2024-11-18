import 'dart:math';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Color getRandomDarkerPrimaryColor({double threshold = 0.5}) {
  final darkerColors = Colors.primaries
      .where((color) => color.computeLuminance() < threshold)
      .toList();
  if (darkerColors.isEmpty) {
    throw Exception("No dark colors found with the given threshold.");
  }
  return darkerColors[Random().nextInt(darkerColors.length)];
}

Future<Color?> getDominantColor(String path) async {
  ImageProvider imageProvider = AssetImage(path);
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(
    imageProvider,
    size: const Size(200, 200),
  );

  return paletteGenerator.dominantColor?.color;
}
