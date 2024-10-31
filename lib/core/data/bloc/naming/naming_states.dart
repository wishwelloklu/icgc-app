import 'package:equatable/equatable.dart';
import 'package:icgc/core/data/models/book/book_model.dart';

abstract class NamingStates extends Equatable {}

final class NamingInitialState extends NamingStates {
  @override
  List<Object?> get props => [];
}

final class NamingProcessingState extends NamingStates {
  @override
  List<Object?> get props => [];
}

final class NamingLoadedState extends NamingStates {
  final BookModel book;
  NamingLoadedState(this.book);
  
  @override
  List<Object?> get props => [book];
}

