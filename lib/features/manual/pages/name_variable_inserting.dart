import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_string.dart';
import '../../../core/data/bloc/naming/naming_bloc.dart';
import '../../../core/data/bloc/naming/naming_events.dart';
import '../../../core/data/bloc/naming/naming_states.dart';
import '../../../core/presentation/buttons/app_primary_button.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../../core/presentation/text_field/input_text_field.dart';

import '../data/models/naming_ceremoney_variable.dart';

class NameVariableInserting extends HookWidget {
  const NameVariableInserting({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper.determineTabletScreenSize(context);
    final isSmallTablet = screenSize == TabletScreenSize.medium;
    final title = ModalRoute.settingsOf(context)?.arguments as String;
    final childNameController = useTextEditingController();
    final fatherNameController = useTextEditingController();
    final motherNameController = useTextEditingController();
    return BlocListener<NamingBloc, NamingStates>(
      listener: (context, state) {
        switch (state) {
          case NamingLoadedState():
            routeAndReplaceNavigator(context, AppRoutes.variableReadPage,
                arguments: NamingCeremoneyVariable(
                    child: childNameController.text,
                    isCompleted: false,
                    father: fatherNameController.text,
                    mother: motherNameController.text));
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(title: TitleText(text: title)),
        body: Align(
          alignment: isSmallTablet ? Alignment.center : Alignment.topCenter,
          child: Column(
            mainAxisAlignment: isSmallTablet
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (isSmallTablet) ...[
                const TitleText(text: 'Fill the form to continue'),
                const Gap(20),
              ],
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallTablet ? 100 : 16, vertical: 16),
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
                  const Gap(10),
                  InputTextField(
                    controller: motherNameController,
                    labelText: "Mother's name",
                    hintText: "Mother's name",
                  ),
                  const Gap(50),
                  PrimaryButton(
                    text: AppString.save,
                    onPressed: () {
                      context.read<NamingBloc>().add(SaveNamingCeremonyEvent(
                            NamingCeremoneyVariable(
                              isCompleted: false,
                              child: childNameController.text,
                              father: fatherNameController.text,
                              mother: motherNameController.text,
                            ),
                            'naming_home',
                          ));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
