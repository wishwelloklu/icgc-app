import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';

import '../../../app/theme/app_string.dart';
import '../../../app/utils/screen_size.dart';
import '../buttons/app_text_button.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key, required this.onDelete, required this.text});
  final VoidCallback onDelete;
  final String text;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: width *
            (isTablet
                ? isPortrait
                    ? .6
                    : .5
                : .8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              Text(
                text,
                style: AppTextStyle.appTitle(color: AppColor.descriptionColor),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      text: AppString.deleteContact,
                      onPressed: onDelete,
                      backgroundColor: const Color.fromARGB(41, 239, 68, 68),
                      color: AppColor.redColor,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: AppTextButton(
                      text: AppString.cancel,
                      onPressed: () => popBack(context),
                      backgroundColor: const Color(0xFFF5F3FF),
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
