import 'package:equatable/equatable.dart';
import 'package:icgc/features/others/data/model/others_model.dart';

abstract class OthersStates extends Equatable {}

class InitialOthersState extends OthersStates {
  @override
  List<Object?> get props => [];
}

class OthersLoadedState extends OthersStates {
  final List<OthersModel> others;
  OthersLoadedState(this.others);
  @override
  List<Object?> get props => [others];
}

class OthersErrorState extends OthersStates {
  final String error;
  OthersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

