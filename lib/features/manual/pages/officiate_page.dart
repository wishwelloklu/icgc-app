import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/config/navigation_key.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/features/library/data/models/collections.dart';
import 'package:icgc/features/library/presentation/widgets/delete_modal.dart';
import 'package:icgc/features/library/presentation/widgets/mark_modal.dart';
import 'package:icgc/features/manual/widgets/officiate_modal.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
// import '../../../app/utils/screen_size.dart';
import '../../../core/data/bloc/naming/naming_bloc.dart';
import '../../../core/data/bloc/naming/naming_events.dart';
import '../../../core/data/bloc/naming/naming_states.dart';
import '../data/models/naming_ceremoney_variable.dart';
import '../widgets/officiate_card.dart';

class OfficiatePage extends StatefulWidget {
  const OfficiatePage({super.key});

  @override
  State<OfficiatePage> createState() => _OfficiatePageState();
}

class _OfficiatePageState extends State<OfficiatePage> {
  @override
  void initState() {
    context.read<NamingBloc>().add(LoadAllNamingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  //  var isTablet = ScreenSizeHelper(context).isTablet;
    return BlocBuilder<NamingBloc, NamingStates>(builder: (context, state) {
      if (state is AllNamingLoadedState) {
        final list = state.namings;
        if (list.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppEmptyStateWidget(
                title: AppString.emptyOfficiatePageText,
                text: AppString.emptyOfficiatePageTextSub,
              ),
              const Gap(10),
              AppTextButton(
                  text: AppString.add,
                  backgroundColor: AppColor.primaryColor,
                  color: AppColor.whiteColor,
                  width: MediaQuery.sizeOf(context).width * .4,
                  onPressed: () => showGenericModalSheet(
                        child: OfficiateModal(
                          onTap: (String id) {
                            popBack(context);
                            if (id == '1') {
                              routeNavigator(context, AppRoutes.officiateList,
                                  arguments: OfficiatingType.namingList);
                            }
                          },
                        ),
                        context: context,
                      ))
            ],
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final data = list[index];
            return Slidable(
              key: ValueKey(index),
              // controller: controller,
              endActionPane: ActionPane(
                motion: StretchMotion(key: ValueKey(index)),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    context
                        .read<NamingBloc>()
                        .add(DeleteNamingCeremonyEvent(index));
                  },
                  closeOnCancel: true,
                  confirmDismiss: () async {
                    bool? result = false;
                    result = await showGenericModalSheet<bool>(
                        useMagin: true,
                        child: DeleteModal(
                            onDelete: () {
                              popBack(context, true);
                            },
                            onCancle: () async => popBack(context, false)),
                        context: context);
                    return result == true;
                  },
                ),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    onPressed: (context) {
                      showGenericModalSheet<bool>(
                          useMagin: true,
                          child: MarkModal(
                              isCompleted: data.isCompleted,
                              onMarkDone: () {
                                appContext?.read<NamingBloc>().add(
                                    UpdateNamingCeremonyEvent(
                                        index,
                                        data.copyWith(
                                            isCompleted: !data.isCompleted)));
                                popBack(appContext!);
                              },
                              onCancle: () async =>
                                  popBack(appContext!, false)),
                          context: context);
                    },
                    backgroundColor: data.isCompleted
                        ? AppColor.grey
                        : AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    icon:
                        data.isCompleted ? Icons.cancel_outlined : Icons.check,
                  ),
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    onPressed: (context) {},
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline_rounded,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  context
                      .read<NamingBloc>()
                      .add(LoadNamingEvent('naming_home'));
                  routeNavigator(
                    context,
                    AppRoutes.variableReadPage,
                    arguments: NamingCeremoneyVariable(
                      child: state.namings[index].child,
                      isCompleted: state.namings[index].isCompleted,
                      father: state.namings[index].father,
                      mother: state.namings[index].mother,
                    ),
                  );
                },
                child: OfficiateCard(
                  isCompleted: data.isCompleted,
                  title: 'The naming of ${data.child}',
                  color: generateColor.color,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Gap(5),
          itemCount: list.length,
        );
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
