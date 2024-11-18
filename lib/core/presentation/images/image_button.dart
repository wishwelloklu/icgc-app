import 'package:flutter/material.dart';
import '../../../app/theme/app_padding.dart';

class ImageButton extends StatelessWidget {
  final String imageString;
  final double imageSize;
  final VoidCallback onPressed;
  final double? padding;
  const ImageButton({
    super.key,
    required this.imageString,
    this.imageSize = AppPadding.buttonIcon,
    required this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: padding != null ? EdgeInsets.all(padding!) : EdgeInsets.zero,
        child: ClipOval(
          child: Image.asset(
            width: imageSize,
            height: imageSize,
            imageString,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
