import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';

class RoundCachedImage extends StatelessWidget {
  final String imageString;
  final double imageSize;
  final String placeholder;
  final Color? bgColor;
  final BoxShape shape;
  const RoundCachedImage({
    super.key,
    required this.imageString,
    this.bgColor,
    this.placeholder = "",
    this.imageSize = AppPadding.profileImage,
    this.shape = BoxShape.circle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.extraSmall),
      decoration: BoxDecoration(
        shape: shape,
        color: bgColor,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          height: imageSize,
          width: imageSize,
          fit: BoxFit.fill,
          errorWidget: (widget, text, error) {
            return Image.asset(
              placeholder,
              fit: BoxFit.fill,
              height: imageSize,
              width: imageSize,
              color: AppColor.whiteColor,
            );
          },
          imageUrl: imageString,
        ),
      ),
    );
  }
}
