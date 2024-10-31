import 'package:icgc/features/manual/data/models/naming_ceremoney_variable.dart';

abstract class NamingEvents {}

final class LoadNamingEvent extends NamingEvents {
  final String path;
  LoadNamingEvent(this.path);
}

final class DeleteBookEvent extends NamingEvents {
  final String noteId;
  DeleteBookEvent(this.noteId);
}

final class SaveNamingCeremonyEvent extends NamingEvents {
  final NamingCeremoneyVariable bookModel;
  final String path;
  SaveNamingCeremonyEvent(this.bookModel, this.path);
}
