import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_events.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_states.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';
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
  final _focusNode = FocusNode();
  final customToolBarList = [
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
        ModalRoute.settingsOf(context)?.arguments as SampleModel;

    return ValueListenableBuilder(
        valueListenable: _showToolbarValue,
        builder: (context, showToolbar, _) {
          return BlocListener<OfficiateBloc, OfficiateStates>(
            listener: (context, state) {
              if (state is OfficiateProcessingDoneState) {
                popBack(context);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Durations.medium1,
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
                                onPressed: () =>
                                    _showToolbarValue.value = false,
                                icon: const Icon(Icons.keyboard_arrow_up))
                          ],
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
                              text: sampleModel.sample,
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
                      onPressed: () async {
                        final htmlText = await controller.getText();
                        final officiate = SampleModel(
                          title: _titleController.text,
                          sample: htmlText,
                          subTitle: sampleModel.subTitle,
                        );
                        if (context.mounted) {
                          context
                              .read<OfficiateBloc>()
                              .add(SaveOfficateEvent(officiate));
                        }
                      },
                      tooltip: 'Show tool bar',
                      label: const Text('Save')),
                  if (!showToolbar)
                    FloatingActionButton.small(
                      onPressed: () => _showToolbarValue.value = true,
                      tooltip: 'Show tool bar',
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void setHtmlText(String text) async {
    await controller.setText(text);
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
      width: (width * .4 + (controller.text.length * 15))
          .clamp(width * .4, width * .9),
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
