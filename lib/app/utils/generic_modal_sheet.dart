import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/app_color.dart';
import '../theme/app_raduis.dart';
import '../theme/app_spacer.dart';

Future<T?> showGenericModalSheet<T>(
    {required Widget child,
    required BuildContext context,
    bool isDismissible = false,
    bool removeDrop = false,
    bool showHanlde = true,
    bool isScrollControlled = true,
    VoidCallback? returnFunction,
    VoidCallback? onBackButton,
    Color? background,
    bool useMagin = false,
    bool showCloseIcon = true,
    bool showNoIcon = false,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) async {
  return await showModalBottomSheet(
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.small),
      ),
    ),
    enableDrag: true,
    isDismissible: isDismissible,
    useRootNavigator: true,
    isScrollControlled: isScrollControlled,
    backgroundColor: Colors.transparent,
    barrierColor: removeDrop ? const Color.fromARGB(42, 0, 0, 0) : null,
    context: context,
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    ),
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
            const Gap(10),
            if (!useMagin && showHanlde)
              Container(
                width: 100,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.grey),
              ),
            if (!useMagin) AppSpacer.verticalSpace(height: 16),
            child,
            AppSpacer.verticalSpace(height: 24),
          ],
        ),
      );
    },
  );
}
