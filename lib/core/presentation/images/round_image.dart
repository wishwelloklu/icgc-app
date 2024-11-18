import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';

class RoundImage extends StatelessWidget {
  final String? imageString;
  final double? imageSize;
  final Color? background;
  final double padding;
  const RoundImage({
    super.key,
    required this.imageString,
    this.imageSize = 45,
    this.background = AppColor.whiteColor,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(padding),
        width: imageSize,
        height: imageSize,
        child: Image.asset(
          imageString ?? '',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
