import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_events.dart';
import 'package:icgc/features/library/data/bloc/notes/notes_states.dart';

import '../../../../../app/cache/cache_keys.dart';
import '../../models/notes_item_model.dart';

class NotesBloc extends Bloc<NotesEvents, NotesStates> {
  var box = Hive.box<NotesItemModel>(CacheKeys.notesKey);
  NotesBloc() : super(NotesInitialState()) {
    on<LoadNotesEvent>(
      (event, emit) async {
        final noteList = box.values.toList();
        emit(NotesLoadedState(noteList));
      },
    );

    on<SaveNotesEvent>(
      (event, emit) async {
        try {
          emit(NotesProcessingState());
          await box.add(event.notesItemModel);
          emit(NotesProcessingDoneState('Saved'));
        } on Exception catch (e) {
          debugPrint(e.toString());
          emit(NotesProcessingDoneState('Something went wrong'));
        }
        add(LoadNotesEvent());
      },
    );

    on<DeleteNotesEvent>(
      (event, emit) async {
        emit(NotesProcessingState());
        try {
          await box.delete(event.noteId);
          emit(NotesProcessingDoneState('Deleted'));
        } on Exception catch (e) {
          debugPrint(e.toString());
          emit(NotesProcessingDoneState('Something went wrong'));
        }
        add(LoadNotesEvent());
      },
    );
  }
}
