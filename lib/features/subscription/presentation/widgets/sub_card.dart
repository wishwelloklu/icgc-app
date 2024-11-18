import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_font_size.dart';
import '../../../../app/theme/app_images.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/theme/app_text_style.dart';
import '../../../../app/utils/svg_icon.dart';
import '../../../../core/presentation/buttons/app_text_button.dart';
import '../../../../core/presentation/text/description_text.dart';
import '../../../../core/presentation/text/title_text.dart';

import '../../data/model/subscription_model.dart';

class SubCard extends StatelessWidget {
  const SubCard({super.key, required this.subscription, required this.onTap});
  final SubscriptionModel subscription;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final isQuarterly = subscription.rate.toLowerCase().contains('quarterly');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.secondaryColor,
            width: .5,
          ),
          color: isQuarterly ? AppColor.primaryColor : null,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleText(
                text: subscription.title,
                maxLine: 10,
                fontSize: AppFontSize.titleMedium,
                textAlign: TextAlign.left,
                color: isQuarterly
                    ? AppColor.secondaryColor
                    : AppColor.primaryColor,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'GHS ${subscription.amount}',
                    style: AppTextStyle.appTitle(
                        fontWeight: FontWeight.w700,
                        color: isQuarterly
                            ? AppColor.whiteColor
                            : AppColor.blackColor)),
                TextSpan(
                    text: ' / ${subscription.rate}',
                    style: AppTextStyle.appDescription(
                        color: isQuarterly
                            ? AppColor.whiteColor
                            : const Color(0xFF8A98AC)))
              ])),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subscription.benefits
                    .map((item) => Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isQuarterly
                                      ? AppColor.secondaryColor
                                      : AppColor.primaryColor),
                            ),
                            const Gap(10),
                            DescriptionText(
                              text: item,
                              color: isQuarterly
                                  ? AppColor.whiteColor
                                  : AppColor.descriptionColor,
                            )
                          ],
                        ))
                    .toList(),
              ),
              const Gap(10),
              AppTextButton(
                text: AppString.subscribe,
                backgroundColor: const Color(0xFFF1F6F5),
                width: 150,
                onPressed: onTap,
              )
            ],
          ),
          // const Gap(10),
          Expanded(
            child: SvgIcon(
              icon: subscription.rate.toLowerCase().contains('monthly')
                  ? AppImages.subBook
                  : subscription.rate.toLowerCase().contains('quarterly')
                      ? AppImages.subBookSecondary
                      : AppImages.subBookYellow,
            ),
          )
        ],
      ),
    );
  }
}
