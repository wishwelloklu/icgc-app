import 'package:icgc/features/library/data/models/notes_item_model.dart';

abstract class NotesEvents {}

final class LoadNotesEvent extends NotesEvents {}

final class DeleteNotesEvent extends NotesEvents {
  final String noteId;
  DeleteNotesEvent(this.noteId);
}

final class SaveNotesEvent extends NotesEvents {
  final NotesItemModel notesItemModel;
  SaveNotesEvent(this.notesItemModel);
}
