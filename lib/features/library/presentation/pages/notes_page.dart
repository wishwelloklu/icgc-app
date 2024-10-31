import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/date_time.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/app/utils/scaffold_toast.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_bloc.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_events.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_states.dart';
import 'package:icgc/features/library/presentation/widgets/delete_modal.dart';
import 'package:icgc/features/library/presentation/widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with TickerProviderStateMixin {
  late SlidableController controller;
  @override
  void initState() {
    controller = SlidableController(this);
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
            return Container();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.noteList.length,
            itemBuilder: (context, index) {
              final notes = state.noteList[index];
              return Slidable(
                key: ValueKey(index),
                controller: controller,
                endActionPane: ActionPane(
                  motion: StretchMotion(key: ValueKey(index)),
                  dismissible: DismissiblePane(
                    onDismissed: () async {},
                    closeOnCancel: false,
                    confirmDismiss: () async {
                      final result = await showGenericModalSheet(
                          useMagin: true,
                          child: DeleteModal(
                              onDelete: () async {
                                context
                                    .read<NotesBloc>()
                                    .add(DeleteNotesEvent(notes.id!));
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
                      flex: 2,
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                  ],
                ),
                child: NotesCard(
                  time: notes.dateTime.deliveredTime(),
                  note: notes.note,
                  title: notes.title,
                  color: getRandomDarkerPrimaryColor(),
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
