import 'package:flutter/material.dart';
import '../../../app/theme/app_string.dart';
import '../text/description_text.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DescriptionText(text: AppString.errorText),
        if (error != null) DescriptionText(text: error!),
      ],
    ));
  }
}
