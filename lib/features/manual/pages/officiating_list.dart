import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/library/data/models/collections.dart';

class OfficiatingList extends StatelessWidget {
  const OfficiatingList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.settingsOf(context)?.arguments as dynamic;
    final isList = data is List;
    if (isList) {
      final namingList = data as List<OfficiatingType>;
      return Scaffold(
        backgroundColor: AppColor.pageBackground,
        appBar: AppBar(title: const TitleText(text: AppString.namingCeremony)),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: namingList.length,
          separatorBuilder: (context, index) => const Gap(5),
          itemBuilder: (context, index) => ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            tileColor: AppColor.whiteColor,
            onTap: () => routeNavigator(
                context, AppRoutes.nameVariableInserting,
                arguments: namingList[index].text),
            title: TitleText(
              text: namingList[index].text,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
