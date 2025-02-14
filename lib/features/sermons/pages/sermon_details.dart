import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:icgc/app/config/navigation_key.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/core/presentation/modals/delete_modal.dart';
import 'package:icgc/core/presentation/read_widgets.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_bloc.dart';
import 'package:icgc/features/sermons/data/models/sermon_detail_model.dart';
import 'package:icgc/features/sermons/data/models/tag.dart';
import 'package:icgc/features/sermons/widgets/options_modal.dart';

import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/screen_size.dart';
import '../data/bloc/officiate_bloc/sermon_events.dart';
import '../widgets/tag_list.dart';

class SermonDetails extends HookWidget {
  const SermonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final width = MediaQuery.sizeOf(context).width;
    final sermonDetail =
        ModalRoute.settingsOf(context)?.arguments as SermonDetailModel;
    final sermon = sermonDetail.sermonModel;
    final showOptions = sermonDetail.showOption;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        width: width * (isPortrait ? .6 : .5),
        child: SafeArea(child: TagList(sermon)),
      ),
      body: ReadWidgets(
        title: sermon.title,
        onOption: showOptions
            ? () {
                showGenericModalSheet(
                  isDismissible: true,
                  child: OptionsModal(
                    onViewTags: () {
                      popBack(context);
                      if (isTablet) {
                        scaffoldKey.currentState?.openEndDrawer();
                      } else {
                        showModalBottomSheet(
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          isScrollControlled: true,
                          showDragHandle: true,
                          useSafeArea: true,
                          builder: (context) {
                            return TagList(sermon);
                          },
                          context: context,
                        );
                      }
                    },
                    onAddTag: () async {
                      // popBack(context);
                      final value = await routeNavigator(
                        context,
                        AppRoutes.newSermon,
                      );

                      if (context.mounted && value != null) {
                        final newValue = value as Tag;
                        final newSermon = sermon;
                        if (sermon.tags != null && sermon.tags!.isNotEmpty) {
                          newSermon.tags!.add(newValue);
                          context
                              .read<SermonBloc>()
                              .add(UpdateSermon(newSermon));
                          popBack(context);
                        } else {
                          final updatedSermon =
                              newSermon.copyWith(tags: [newValue]);
                          context
                              .read<SermonBloc>()
                              .add(UpdateSermon(updatedSermon));
                          popBack(context);
                        }
                      }
                    },
                    onDelete: () => showDialog(
                      context: context,
                      builder: (context) => DeleteModal(
                        onDelete: () {
                          context.read<SermonBloc>().add(DeleteSermon(sermon));
                          popBack(context);
                          popBack(appContext ?? context);
                          popBack(appContext ?? context);
                        },
                        text: AppString.deleteSermon,
                      ),
                    ),
                  ),
                  context: context,
                );
              }
            : null,
        child: BlocBuilder<FontBloc, FontStates>(builder: (context, state) {
          if (state is FontState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: HtmlWidget(
                sermon.sample,
                renderMode: RenderMode.listView,
                textStyle: TextStyle(
                    fontFamily: state.fontName,
                    fontSize: state.fontSize + (isTablet ? 5 : 0),
                    color: Colors.black),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
      floatingActionButton: !sermonDetail.showOption
          ? FloatingActionButton.extended(
              onPressed: () => routeNavigator(context, AppRoutes.textEditor,
                  arguments: sermon),
              label: const Text('Create Sermon'))
          : null,
    );
  }
}
