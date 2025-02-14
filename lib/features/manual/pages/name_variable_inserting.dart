import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_images.dart';
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
    final isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
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
                          AppImages.child,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: FieldWidget(
                          isPortrait: isPortrait,
                          childNameController: childNameController,
                          fatherNameController: fatherNameController,
                          motherNameController: motherNameController,
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
            : FieldWidget(
                isPortrait: isPortrait,
                childNameController: childNameController,
                fatherNameController: fatherNameController,
                motherNameController: motherNameController,
              ),
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.isPortrait,
    required this.childNameController,
    required this.fatherNameController,
    required this.motherNameController,
  });

  final bool isPortrait;
  final TextEditingController childNameController;
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      children: [
        TitleText(
          text: 'Fill the form to continue',
          fontSize: !isPortrait ? AppFontSize.headLineMedium : null,
        ),
        const Gap(20),
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
    );
  }
}
