import '../../../../features/manual/data/models/naming_ceremoney_variable.dart';

abstract class NamingEvents {}

final class LoadNamingEvent extends NamingEvents {
  final String path;
  LoadNamingEvent(this.path);
}

final class LoadAllNamingEvent extends NamingEvents {
  LoadAllNamingEvent();
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

final class DeleteNamingCeremonyEvent extends NamingEvents {
  final int index;

  DeleteNamingCeremonyEvent(this.index);
}

final class DeleteAllNamingCeremonyEvent extends NamingEvents {


  DeleteAllNamingCeremonyEvent();
}

final class UpdateNamingCeremonyEvent extends NamingEvents {
  final int index;
  final NamingCeremoneyVariable updatedData;
  UpdateNamingCeremonyEvent(this.index,this.updatedData);
}
