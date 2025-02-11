import 'dart:math';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../core/data/models/color_model.dart';

ColorModel get generateColor {
  final darkerColors =
      Colors.primaries.where((color) => color.computeLuminance() < .2).toList();
  if (darkerColors.isEmpty) {
    throw Exception("No dark colors found with the given threshold.");
  }
  final color = darkerColors[Random().nextInt(darkerColors.length)];
  final colorModel = ColorModel(
    alpha: color.a,
    red: color.r,
    green: color.g,
    blue: color.b,
  );
  return colorModel;
}

Color darkenColor(Color color, [double amount = 0.2]) {
  final hsl = HSLColor.fromColor(color);
  final darkened = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return darkened.toColor();
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
