// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/data/models/side_nave_item_model.dart';
import 'package:icgc/core/presentation/nav/side_nave_item.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.pages,
    required this.currentIndex,
    required this.onTap,
    required this.child,
  });

  final int currentIndex;
  final List<Widget> pages;
  final void Function(int) onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sideNavItems = [
      SideNaveItemModel(
        text: 'Home',
        icon: AppImages.home,
      ),
      SideNaveItemModel(
        text: 'Manual',
        icon: AppImages.books,
      ),
      SideNaveItemModel(
        text: 'Sermons',
        icon: AppImages.sermons,
      ),
      SideNaveItemModel(
        text: 'Declaration',
        icon: AppImages.declaration,
      ),
      SideNaveItemModel(
        text: 'More',
        icon: AppImages.more,
      ),
    ];

    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.sizeOf(context).width * .3,
          color: AppColor.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Column(
            children: [
              const Gap(20),
              Row(
                children: [
                  Image.asset(
                    AppImages.logoIcon,
                    scale: 3.5,
                  ),
                  const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: AppString.churchName,
                        maxLine: 4,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                    ],
                  ))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sideNavItems.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == currentIndex;
                    final item = sideNavItems[index];
                    return InkWell(
                      onTap: () => onTap(index),
                      child: SideNaveItem(
                        text: item.text,
                        icon: item.icon,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
