import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../core/presentation/buttons/app_primary_button.dart';
import '../../../../core/presentation/buttons/app_text_button.dart';
import '../../../../core/presentation/text/title_text.dart';

class MarkModal extends StatelessWidget {
  const MarkModal(
      {super.key,
      required this.onCancle,
      required this.onMarkDone,
      required this.isCompleted});
  final VoidCallback onCancle;
  final VoidCallback onMarkDone;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(10),
            TitleText(
              text: isCompleted ? AppString.unMarkDone : AppString.markDone,
              fontSize: 16,
            ),
            const Gap(20),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                      child: AppTextButton(
                    text: AppString.cancel,
                    onPressed: onCancle,
                    backgroundColor: AppColor.grey.withValues(alpha: .3),
                    color: AppColor.blackColor,
                  )),
                  const Gap(16),
                  Expanded(
                      child: PrimaryButton(
                    text: isCompleted ? AppString.unCheck : AppString.check,
                    onPressed: onMarkDone,
                    backgroundColor: AppColor.primaryColor,
                  )),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
