import 'package:equatable/equatable.dart';
import '../../models/book/book_model.dart';

abstract class LatestBookStates extends Equatable {}

final class LatestBookInitialState extends LatestBookStates {
  @override
  List<Object?> get props => [];
}

final class LatestBookProcessingState extends LatestBookStates {
  @override
  List<Object?> get props => [];
}

final class LatestBookLoadedState extends LatestBookStates {
  final List<BookModel> bookList;
  LatestBookLoadedState(this.bookList);

  @override
  List<Object?> get props => [bookList];
}
