import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/features/library/presentation/pages/add_notes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/utils/colors_generator.dart';
import '../../../../app/utils/date_time.dart';
import '../../../../app/utils/generic_modal_sheet.dart';
import '../../../../app/utils/scaffold_toast.dart';
import '../../data/bloc/notes/notes_bloc.dart';
import '../../data/bloc/notes/notes_events.dart';
import '../../data/bloc/notes/notes_states.dart';
import '../widgets/delete_modal.dart';
import '../widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<NotesBloc>().add(LoadNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesStates>(listener: (context, state) {
      switch (state) {
        case NotesProcessingState():
          showToast(state.message);
        case NotesProcessingDoneState():
          showToast(state.message, autoHide: true);
          break;
        default:
      }
    }, builder: (context, state) {
      switch (state) {
        case NotesLoadedState():
          if (state.noteList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppEmptyStateWidget(
                  title: 'No notes',
                  text: 'Add notes to get started',
                  icon: Icon(
                    Icons.note,
                    size: 100,
                    color: AppColor.primaryColor.withOpacity(.8),
                  ),
                ),
                const Gap(10),
                AppTextButton(
                    text: AppString.add,
                    backgroundColor: AppColor.primaryColor,
                    color: AppColor.whiteColor,
                    width: MediaQuery.sizeOf(context).width * .4,
                    onPressed: () => showGenericModalSheet(
                          child: const AddNotes(),
                          context: context,
                        ))
              ],
            );
          }
          final list = state.noteList;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final notes = list[index];
              return Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: StretchMotion(key: ValueKey(index)),
                  dismissible: DismissiblePane(
                    onDismissed: () async {
                      context.read<NotesBloc>().add(DeleteNotesEvent(index));
                    },
                    closeOnCancel: true,
                    confirmDismiss: () async {
                      final result = await showGenericModalSheet<bool>(
                          useMagin: true,
                          child: DeleteModal(
                              onDelete: () async {
                                popBack(context, true);
                              },
                              onCancle: () async => popBack(context, false)),
                          context: context);

                      return result == true;
                    },
                  ),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      borderRadius: BorderRadius.circular(8),
                      padding: EdgeInsets.zero,
                      spacing: 0,
                      onPressed: (context) {
                        context.read<NotesBloc>().add(DeleteNotesEvent(index));
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outline_outlined,
                    ),
                  ],
                ),
                child: NotesCard(
                  time: notes.dateTime.deliveredTime(),
                  note: notes.note,
                  title: notes.title,
                  color: generateColor.color,
                ),
              );
            },
          );
        default:
          return const CircularProgressIndicator.adaptive();
      }
    });
  }
}
