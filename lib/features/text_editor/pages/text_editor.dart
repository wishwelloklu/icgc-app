import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/config/navigation_key.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/core/presentation/animated_widget.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_events.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_states.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';
import 'package:icgc/features/sermons/data/models/tag.dart';
import 'package:icgc/features/sermons/widgets/options_modal.dart';
import 'package:quill_html_editor/quill_html_editor.dart';


class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late QuillEditorController controller;
  final _titleController = TextEditingController();
  final _showToolbarValue = ValueNotifier(true);
  SermonModel? _sampleModel;
  final _focusNode = FocusNode();
  final customToolBarList = [
    ToolBarStyle.size,
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
  ];

  @override
  void initState() {
    controller = QuillEditorController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sampleModel =
        ModalRoute.settingsOf(context)?.arguments as SermonModel;
    _sampleModel ??= sampleModel;
    return ValueListenableBuilder(
        valueListenable: _showToolbarValue,
        builder: (context, showToolbar, _) {
          return BlocListener<SermonBloc, SermonStates>(
            listener: (context, state) {
              if (state is SermonProcessingDoneState) {
                popBack(context);
                popBack(appContext ?? context);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AppAnimatedWidget(
                        duration: Durations.medium1,
                        opacity: showToolbar ? 1 : 0,
                        child: SizedBox(
                          height: showToolbar ? null : 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ToolBar(
                                  controller: controller,
                                  toolBarConfig: customToolBarList,
                                  activeIconColor: AppColor.greenColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () => showOptionsModal(),
                                icon: const Icon(FontAwesomeIcons.ellipsisH),
                              )
                            ],
                          ),
                        ),
                      ),
                      CenteredTextField(
                        controller: _titleController,
                        focusNode: _focusNode,
                        onChanged: () => setState(() {}),
                      ),
                      const Divider(),
                      Expanded(
                        child: AnimatedContainer(
                          duration: Durations.medium1,
                          child: GestureDetector(
                            onTap: () => _focusNode.unfocus(),
                            child: QuillHtmlEditor(
                              text: _sampleModel?.sample,
                              backgroundColor: Colors.white,
                              controller: controller,
                              onFocusChanged: (p0) {
                                if (_focusNode.hasFocus) {
                                  _focusNode.unfocus();
                                }
                              },
                              textStyle: const TextStyle(fontSize: 15),
                              hintTextStyle: const TextStyle(fontSize: 15),
                              minHeight: MediaQuery.sizeOf(context).height,
                              loadingBuilder: (context) =>
                                  const Scaffold(body: AppLoadingState()),
                              onEditorCreated: () {
                                _titleController.text = sampleModel.title;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'notag',
                    onPressed: () => _showToolbarValue.value = !showToolbar,
                    tooltip: 'Show tool bar',
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          showToolbar ? Icons.visibility_off : Icons.visibility,
                          color: AppColor.primaryColor,
                        ),
                        const Text('Tools')
                      ],
                    ),
                  ),
                  const Gap(10),
                  FloatingActionButton.extended(
                      onPressed: () async {
                        final htmlText = await controller.getText();
                        final sermon = SermonModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          color: generateColor,
                          title: _titleController.text,
                          sample: htmlText,
                          subTitle: sampleModel.subTitle,
                          tags: _sampleModel?.tags ?? [],
                        );
                        if (context.mounted) {
                          context
                              .read<SermonBloc>()
                              .add(SaveSermonEvent(sermon));
                        }
                      },
                      tooltip: 'Show tool bar',
                      label: const Text('Save')),
                ],
              ),
            ),
          );
        });
  }

  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  void showOptionsModal() {
    showGenericModalSheet(
      isDismissible: true,
      child: OptionsModal(
        onViewTags: () {},
        onAddTag: () async {
          popBack(context);
          final value = await routeNavigator(
            context,
            AppRoutes.newSermon,
          );

          if (value != null) {
            final newValue = value as Tag;
            _sampleModel = _sampleModel?.copyWith(tags: [newValue]);
          }
        },
      ),
      context: context,
    );
  }
}

class CenteredTextField extends StatelessWidget {
  const CenteredTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.focusNode});
  final TextEditingController controller;
  final VoidCallback onChanged;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: (width * .9 + (controller.text.length * 15))
          .clamp(width * .9, width * .9),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLines: null,
        minLines: 1,
        focusNode: focusNode,
        style: AppTextStyle.appTitle(fontWeight: FontWeight.bold, size: 25),
        decoration: InputDecoration(
          hintText: 'Sermon title',
          hintStyle: AppTextStyle.appInputHint(size: 20),
          border: InputBorder.none,
        ),
        onChanged: (value) => onChanged,
      ),
    );
  }
}
