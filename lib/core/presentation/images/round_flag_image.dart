import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_padding.dart';

class RoundFlagImage extends StatelessWidget {
  final String flagImage;
  final double? size;
  const RoundFlagImage({super.key, required this.flagImage, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        width: size ?? AppPadding.buttonIcon,
        height: size ?? AppPadding.buttonIcon,
        'icons/flags/png100px/$flagImage.png',
        package: 'country_icons',
        fit: BoxFit.cover,
      ),
    );
  }
}
