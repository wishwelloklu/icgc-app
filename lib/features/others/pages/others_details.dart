import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/read_widgets.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/others/data/model/others_model.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';

import '../../../app/theme/app_text_style.dart';
import '../../../core/presentation/buttons/tab_bar_button.dart';

class OthersDetails extends HookWidget {
  const OthersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    final selectedIndex = useState(0);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    var isTablet = ScreenSizeHelper(context).isTablet;
    final theme = ModalRoute.settingsOf(context)?.arguments as OthersModel;

    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return Scaffold(
              extendBody: true,
              body: ReadWidgets(
                title: theme.title,
                child: TabBarView(controller: tabController, children: [
                  Declaration(content: theme.content, isTablet: isTablet),
                  const Center(
                    child: TitleText(text: 'Explanation'),
                  ),
                ]),
              ),
              bottomSheet: TabBar(
                controller: tabController,
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                labelStyle: AppTextStyle.appTitle(
                  fontWeight: FontWeight.w600,
                  size: 18,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColor.primaryColor,
                indicatorWeight: 0,
                indicator: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.zero),
                tabs: [
                  TabButton(text: 'Declaration', isSelected: index == 1),
                  TabButton(text: 'Explanaition', isSelected: index == 0),
                ],
              ));

          //   Row(
          //     // mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TabButton(
          //         tabController: tabController,
          //         text: 'Declaration',
          //         index: 0,
          //         selectedIndex: index,
          //         onTap: () => tabController.animateTo(0),
          //       ),
          //       TabButton(
          //         tabController: tabController,
          //         text: 'Explanaition',
          //         index: 1,
          //         selectedIndex: index,
          //         onTap: () => tabController.animateTo(1),
          //       ),
          //     ],
          //   ),
          // );
        });
  }
}

// class TabButton extends StatelessWidget {
//   const TabButton({
//     super.key,
//     required this.tabController,
//     required this.text,
//     required this.index,
//     required this.selectedIndex,
//     required this.onTap,
//   });

//   final TabController tabController;
//   final String text;
//   final int index;
//   final int selectedIndex;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).floatingActionButtonTheme.backgroundColor;
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           decoration: BoxDecoration(
//               color: index == selectedIndex ? AppColor.primaryColor : color,
//               borderRadius: index == 0
//                   ? const BorderRadius.horizontal(left: Radius.circular(10))
//                   : const BorderRadius.horizontal(right: Radius.circular(10))),
//           child: TitleText(
//               text: text,
//               color: index == selectedIndex
//                   ? Colors.white
//                   : AppColor.primaryColor),
//         ),
//       ),
//     );
//   }
// }

class Declaration extends StatelessWidget {
  const Declaration({
    super.key,
    required this.content,
    required this.isTablet,
  });

  final String content;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FontBloc, FontState>(builder: (context, state) {
      return Center(
        child: SingleChildScrollView(
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: state.fontSize + (isTablet ? 10 : 0),
              fontFamily: state.fontName,
            ),
          ),
        ),
      );
    });
  }
}
