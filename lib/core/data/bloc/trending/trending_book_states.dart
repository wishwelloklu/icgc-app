import 'package:equatable/equatable.dart';
import '../../models/book/book_model.dart';

abstract class TrendingBookStates extends Equatable {}

final class TrendingBookInitialState extends TrendingBookStates {
  @override
  List<Object?> get props => [];
}

final class TrendingBookProcessingState extends TrendingBookStates {
  @override
  List<Object?> get props => [];
}

final class TrendingBookLoadedState extends TrendingBookStates {
  final List<BookModel> bookList;
  TrendingBookLoadedState(this.bookList);

  @override
  List<Object?> get props => [bookList];
}
