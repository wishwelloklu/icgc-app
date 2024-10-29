import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_raduis.dart';

class TabButton extends StatelessWidget {
  const TabButton({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          // color:color?? AppColor.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(AppRadius.small)),
      child: Tab(text: text),
    );
  }
}
