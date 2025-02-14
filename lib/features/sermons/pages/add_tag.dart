import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/date_time.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/buttons/app_primary_button.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/core/presentation/text_field/icon_text_field.dart';
import 'package:icgc/core/presentation/text_field/input_text_field.dart';
import 'package:icgc/features/sermons/data/models/tag.dart';

import '../../../app/routes/route_navigator.dart';

class AddTag extends StatefulWidget {
  const AddTag({super.key});

  @override
  State<AddTag> createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _seletedDate;
  bool _isController = false;
  @override
  Widget build(BuildContext context) {
    final tag = ModalRoute.settingsOf(context)?.arguments as Tag?;
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    if (tag != null && !_isController) {
      _dateController.text = tag.date?.formattedDate ?? '';
      _titleController.text = tag.name ?? '';
      _descriptionController.text = tag.description ?? '';
      _timeController.text = tag.time ?? '';
      _placeController.text = tag.place ?? '';
      _seletedDate = tag.date;
      _timeController.text = tag.time ?? '';
      _isController = true;
    }
    return Scaffold(
        appBar: isPortrait ? AppBar() : null,
        body: isTablet && !isPortrait
            ? Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: MediaQuery.sizeOf(context).width * .5,
                        foregroundDecoration: const BoxDecoration(
                            color: Color.fromARGB(96, 33, 70, 54)),
                        child: Image.asset(
                          AppImages.preach,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: InputWidget(
                            isPortrait: isPortrait,
                            titleController: _titleController,
                            placeController: _placeController,
                            dateController: _dateController,
                            timeController: _timeController,
                            descriptionController: _descriptionController,
                            onContinue: () => _onContinue(),
                            onDate: () async {
                              await _onDate();
                            },
                            onTime: () async {
                              await _onTime();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: IconButton(
                        onPressed: () => popBack(context),
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        )),
                  )
                ],
              )
            : Form(
                key: _formKey,
                child: InputWidget(
                  isPortrait: isPortrait,
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                  placeController: _placeController,
                  dateController: _dateController,
                  timeController: _timeController,
                  onDate: () => _onDate(),
                  onContinue: () => _onContinue(),
                  onTime: () async {
                    await _onTime();
                  },
                ),
              ));
  }

  Future<void> _onDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 5, DateTime.now().month, DateTime.now().day),
    );
    if (date != null) {
      _seletedDate = date;
      _dateController.text = date.formattedDate;
      setState(() {});
    }
  }

  Future<void> _onTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    if (time != null) {
      _timeController.text = time.format(context);
      setState(() {});
    }
  }

  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final tag = Tag(
        place: _placeController.text,
        date: _seletedDate,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        name: _titleController.text,
        time: _timeController.text,
      );

      popBack(context, tag);
    }
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required TextEditingController titleController,
    required TextEditingController placeController,
    required TextEditingController dateController,
    required TextEditingController timeController,
    required TextEditingController descriptionController,
    required this.isPortrait,
    required this.onContinue,
    required this.onTime,
    required this.onDate,
  })  : _titleController = titleController,
        _placeController = placeController,
        _dateController = dateController,
        _timeController = timeController,
        _descriptionController = descriptionController;

  final TextEditingController _titleController;
  final TextEditingController _timeController;
  final TextEditingController _descriptionController;
  final TextEditingController _placeController;
  final TextEditingController _dateController;
  final bool isPortrait;

  final VoidCallback onContinue;
  final VoidCallback onDate;
  final VoidCallback onTime;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: isTablet && isPortrait ? 100 : 16),
      shrinkWrap: !isPortrait ? true : false,
      children: [
        const Gap(20),
        const TitleText(
          text: 'Add Tag',
          fontSize: 25,
        ),
        const Gap(20),
        InputTextField(
          controller: _titleController,
          labelText: AppString.tagName,
          hintText: AppString.tagNameHime,
          isRequired: true,
          isSuggest: true,
        ),
        const Gap(20),
        InputTextField(
          controller: _placeController,
          labelText: AppString.place,
          hintText: AppString.placeHint,
          isRequired: true,
          isSuggest: true,
        ),
        const Gap(20),
        InputTextField(
          controller: _descriptionController,
          labelText: AppString.description,
          hintText: AppString.descriptionHint,
          isSuggest: true,
          multiLine: true,
        ),
        const Gap(20),
        IconTextField(
          controller: _dateController,
          labelText: AppString.date,
          hintText: AppString.dateHint,
          isRequired: true,
          onTap: onDate,
        ),
        const Gap(20),
        IconTextField(
          controller: _timeController,
          labelText: AppString.time,
          hintText: AppString.timeHint,
          isRequired: true,
          onTap: onTime,
        ),
        const Gap(20),
        PrimaryButton(
          text: AppString.continues,
          onPressed: onContinue,
        ),
        const Gap(20),
      ],
    );
  }
}
