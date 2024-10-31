import 'package:equatable/equatable.dart';

import '../../models/notes_item_model.dart';

abstract class NotesStates extends Equatable {}

final class NotesInitialState extends NotesStates {
  NotesInitialState();
  @override
  List<Object?> get props => [];
}

final class NotesProcessingState extends NotesStates {
  final String message;
  NotesProcessingState({this.message = 'Processing'});
  @override
  List<Object?> get props => [message];
}

final class NotesProcessingDoneState extends NotesStates {
  final String message;
  NotesProcessingDoneState(this.message);
  @override
  List<Object?> get props => [message];
}

final class NotesLoadedState extends NotesStates {
  final List<NotesItemModel> noteList;
  NotesLoadedState(this.noteList);
  @override
  List<Object?> get props => [noteList];
}
