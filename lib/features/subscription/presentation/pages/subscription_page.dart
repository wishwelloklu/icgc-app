import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/subscription/data/model/subscription_model.dart';
import 'package:icgc/features/subscription/presentation/widgets/sub_card.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Gap(20),
            const TitleText(
              text: AppString.choosePlan,
              fontSize: AppFontSize.titleLarge,
              textAlign: TextAlign.center,
            ),
            const DescriptionText(
              text: AppString.saveText,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: SubscriptionModel.subList.length,
              separatorBuilder: (context, index) => const Gap(20),
              itemBuilder: (context, index) => SubCard(
                subscription: SubscriptionModel.subList[index],
                onTap: () =>
                    routeAndRemoveNavigator(context, AppRoutes.wrapper),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
