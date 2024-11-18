import 'package:equatable/equatable.dart';
import '../../models/book/book_model.dart';
import '../../../../features/manual/data/models/naming_ceremoney_variable.dart';

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

final class AllNamingLoadedState extends NamingStates {
  final List<NamingCeremoneyVariable> namings;
  AllNamingLoadedState(this.namings);

  @override
  List<Object?> get props => [namings];
}

