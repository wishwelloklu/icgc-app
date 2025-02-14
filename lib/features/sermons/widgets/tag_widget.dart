import 'package:flutter/material.dart';
import 'package:icgc/app/utils/screen_size.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.tag,
    required this.color,
    required this.background,
    this.avatar,
  });
  final String tag;
  final Color color;
  final Color background;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Chip(
        padding: EdgeInsets.zero,
        side: BorderSide.none,
        backgroundColor: background,
        avatar: avatar,
        label: Text(
          tag,
          style: TextStyle(fontSize: isTablet ? 15 : 10, color: color),
        ));
  }
}
