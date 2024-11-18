import '../../models/notes_item_model.dart';

abstract class NotesEvents {}

final class LoadNotesEvent extends NotesEvents {}

final class DeleteNotesEvent extends NotesEvents {
  final int index;
  DeleteNotesEvent(this.index);
}

final class SaveNotesEvent extends NotesEvents {
  final NotesItemModel notesItemModel;
  SaveNotesEvent(this.notesItemModel);
}
