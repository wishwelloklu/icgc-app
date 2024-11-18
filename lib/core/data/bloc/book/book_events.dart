import '../../models/book/book_model.dart';

abstract class BookEvents {}

final class LoadBookEvent extends BookEvents {}

final class DeleteBookEvent extends BookEvents {
  final String noteId;
  DeleteBookEvent(this.noteId);
}

final class SaveBookEvent extends BookEvents {
  final BookModel bookModel;
  SaveBookEvent(this.bookModel);
}
