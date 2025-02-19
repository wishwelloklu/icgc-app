import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_string.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../library/data/models/collections.dart';

class OfficiatingList extends StatelessWidget {
  const OfficiatingList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper(context).determineTabletScreenSize;
    final isSmallTablet = screenSize == DeviceScreenSize.medium;
    final data = ModalRoute.settingsOf(context)?.arguments as dynamic;
    final isList = data is List;
    if (isList) {
      final namingList = data as List<OfficiatingType>;
      return Scaffold(
        backgroundColor: AppColor.pageBackground,
        appBar: AppBar(title: const TitleText(text: AppString.namingCeremony)),
        body: Align(
          alignment: isSmallTablet ? Alignment.center : Alignment.topCenter,
          child: Column(
            mainAxisAlignment: isSmallTablet
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (isSmallTablet) ...[
                const TitleText(text: 'Select a naming ceremony type'),
                const Gap(20),
              ],
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: namingList.length,
                separatorBuilder: (context, index) => const Gap(5),
                itemBuilder: (context, index) => ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  tileColor: AppColor.lightColor,
                  onTap: () => routeNavigator(
                      context, AppRoutes.nameVariableInserting,
                      arguments: namingList[index].text),
                  title: TitleText(
                    text: namingList[index].text,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
