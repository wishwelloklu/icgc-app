import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child:
          const Icon(Icons.chevron_left, size: 30.0, color: AppColor.darkColor),
    );
  }
}
