import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_events.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import 'package:icgc/core/presentation/buttons/app_primary_button.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/core/presentation/text_field/input_text_field.dart';

import '../data/models/naming_ceremoney_variable.dart';

class NameVariableInserting extends HookWidget {
  const NameVariableInserting({super.key});

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.settingsOf(context)?.arguments as String;
    final childNameController = useTextEditingController();
    final fatherNameController = useTextEditingController();
    return BlocListener<NamingBloc, NamingStates>(
      listener: (context, state) {
        switch (state) {
          case NamingLoadedState():
            routeNavigator(context, AppRoutes.variableReadPage,
                arguments: NamingCeremoneyVariable(
                  child: childNameController.text,
                  father: fatherNameController.text,
                ));
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(title: TitleText(text: title)),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            InputTextField(
              controller: childNameController,
              labelText: AppString.childName,
              hintText: AppString.childNameHint,
            ),
            const Gap(10),
            InputTextField(
              controller: fatherNameController,
              labelText: AppString.fatherName,
              hintText: AppString.fatherNameHint,
            ),
            const Gap(50),
            PrimaryButton(
              text: AppString.save,
              onPressed: () {
                context.read<NamingBloc>().add(SaveNamingCeremonyEvent(
                      NamingCeremoneyVariable(
                        child: childNameController.text,
                        father: fatherNameController.text,
                      ),
                      'naming_home',
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
