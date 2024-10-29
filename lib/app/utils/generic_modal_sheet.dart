import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_raduis.dart';
import 'package:icgc/app/theme/app_spacer.dart';
import 'package:icgc/app/theme/app_text_style.dart';

import 'svg_icon.dart';

Future showGenericModalSheet(
    {required Widget child,
    required BuildContext context,
    bool isDismissible = false,
    isScrollControlled = true,
    VoidCallback? returnFunction,
    VoidCallback? onBackButton,
    Color? background,
    required String title,
    bool showBackIcon = false,
    bool useMagin = false,
    bool showCloseIcon = true,
    bool showNoIcon = false,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) async {
  showModalBottomSheet(
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.normal),
      ),
    ),
    enableDrag: false,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: useMagin
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16)
            : EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: background ?? AppColor.pageBackground,
          borderRadius: BorderRadius.vertical(
              top: const Radius.circular(AppRadius.normal),
              bottom: useMagin
                  ? const Radius.circular(AppRadius.normal)
                  : Radius.zero),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Container(
              padding: EdgeInsets.all(
                  useMagin ? AppPadding.medium : AppPadding.normal),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.normal),
                ),
              ),
              child: Row(
                mainAxisAlignment: showNoIcon
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (!showNoIcon)
                    InkWell(
                      onTap: onBackButton,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: showBackIcon ? null : Colors.transparent,
                        ),
                      ),
                    ),
                  Text(
                    title,
                    style: AppTextStyle.appTitle(
                      fontWeight: FontWeight.w700,
                      size: AppFontSize.bodyLarge,
                      color: AppColor.blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!showNoIcon)
                    InkWell(
                      onTap:
                          showCloseIcon ? () => Navigator.pop(context) : null,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.cancel),
                      ),
                    ),
                ],
              ),
            ),
            if (!useMagin) AppSpacer.verticalSpace(height: 16),
            child,
            AppSpacer.verticalSpace(height: 24),
          ],
        ),
      );
    },
  ).then((value) {
    if (returnFunction != null) {
      returnFunction();
    }
  });
}
