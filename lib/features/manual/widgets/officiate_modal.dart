import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import '../data/models/officiating_category.dart';

class OfficiateModal extends StatelessWidget {
  const OfficiateModal({super.key, required this.onTap});
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: OfficiatingCategory.categoryList.length,
      itemBuilder: (context, index) => ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: AppColor.whiteColor,
        onTap: () => onTap(OfficiatingCategory.categoryList[index].id),
        title: TitleText(
          text: OfficiatingCategory.categoryList[index].ceremony,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
