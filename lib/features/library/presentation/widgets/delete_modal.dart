import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/buttons/app_primary_button.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal(
      {super.key, required this.onCancle, required this.onDelete});
  final VoidCallback onCancle;
  final VoidCallback onDelete;

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
            const TitleText(
              text: AppString.deleteNote,
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
                    backgroundColor: AppColor.grey.withOpacity(.3),
                    color: AppColor.blackColor,
                  )),
                  const Gap(16),
                  Expanded(
                      child: PrimaryButton(
                    text: AppString.delete,
                    onPressed: onDelete,
                    backgroundColor: AppColor.redColor,
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
