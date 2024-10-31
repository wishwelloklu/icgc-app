import 'package:equatable/equatable.dart';
import 'package:icgc/core/data/models/book/book_model.dart';

abstract class BookStates extends Equatable {}

final class BookInitialState extends BookStates {
  @override
  List<Object?> get props => [];
}

final class BookProcessingState extends BookStates {
  @override
  List<Object?> get props => [];
}

final class BookLoadedState extends BookStates {
  final List<BookModel> bookList;
  BookLoadedState(this.bookList);
  
  @override
  List<Object?> get props => [bookList];
}

