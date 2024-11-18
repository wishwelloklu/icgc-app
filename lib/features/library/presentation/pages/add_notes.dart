import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../core/presentation/buttons/app_text_button.dart';
import '../../../../core/presentation/text_field/input_text_field.dart';
import '../../data/bloc/notes/notes_bloc.dart';
import '../../data/bloc/notes/notes_events.dart';
import '../../data/models/notes_item_model.dart';

class AddNotes extends HookWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final titleControler = useTextEditingController();
    final descriptionControler = useTextEditingController();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      children: [
        InputTextField(
          controller: titleControler,
          labelText: AppString.title,
          hintText: "Psalm 23:1-3...",
        ),
        const Gap(20),
        InputTextField(
          controller: descriptionControler,
          labelText: AppString.details,
          hintText: "JamesThe Lord is my shepherd..",
        ),
        const Gap(50),
        AppTextButton(
            text: AppString.save,
            backgroundColor: AppColor.primaryColor,
            color: AppColor.whiteColor,
            onPressed: () {
              context.read<NotesBloc>().add(SaveNotesEvent(NotesItemModel(
                    id: DateTime.now().toIso8601String(),
                    dateTime: DateTime.now(),
                    title: titleControler.text,
                    note: descriptionControler.text,
                  )));
              popBack(context);
            })
      ],
    );
  }
}
