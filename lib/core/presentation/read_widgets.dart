// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../app/routes/route_navigator.dart';
import '../../app/theme/app_images.dart';
import '../../app/utils/generic_modal_sheet.dart';
import '../../app/utils/screen_size.dart';
import '../../app/utils/svg_icon.dart';
import '../../features/reader_page/presentation/pages/reader_page.dart';
import '../../features/reader_page/presentation/widgets/font_modal.dart';
import 'animated_widget.dart';
import 'text/title_text.dart';

class ReadWidgets extends StatefulWidget {
  const ReadWidgets({
    super.key,
    required this.child,
    required this.title,
    this.onOption,
  });
  final Widget child;
  final String title;
  final VoidCallback? onOption;

  @override
  State<ReadWidgets> createState() => _ReadWidgetsState();
}

class _ReadWidgetsState extends State<ReadWidgets> {
  final _showOtherWidgets = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: _showOtherWidgets,
          builder: (context, showOtherWidgets, _) {
            return Stack(
              children: [
                GestureDetector(
                    onTap: () =>
                        _showOtherWidgets.value = !_showOtherWidgets.value,
                    child: AnimatedContainer(
                      duration: Durations.medium1,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: showOtherWidgets ? 60 : 0,
                      ),
                      child: widget.child,
                    )),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppAnimatedWidget(
                    opacity: showOtherWidgets ? 1 : 0,
                    child: Container(
                      height: showOtherWidgets ? null : 0,
                      color: const Color.fromARGB(239, 255, 255, 255),
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              onPressed: () => popBack(context),
                              icon: const Icon(Icons.arrow_back)),
                          Expanded(
                            child: TitleText(
                              text: widget.title,
                              fontSize: isTablet ? 25 : 20,
                              maxLine: 1,
                            ),
                          ),
                          Row(
                            children: [
                              TopButtons(
                                  onTap: () {
                                    showGenericModalSheet(
                                        removeDrop: true,
                                        showHanlde: false,
                                        isDismissible: true,
                                        child: const FontModal(),
                                        context: context);
                                  },
                                  icon: const SvgIcon(
                                    icon: AppImages.font,
                                    size: 20,
                                  )),
                              if(widget.onOption != null)...[
                              const Gap(2),
                              TopButtons(
                                onTap:  widget.onOption!,
                                icon: const Icon(
                                  FontAwesomeIcons.ellipsisH,
                                  size: 20,
                                ),
                              ),]
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
