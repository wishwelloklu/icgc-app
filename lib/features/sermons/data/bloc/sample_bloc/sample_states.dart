import 'package:equatable/equatable.dart';

import '../../models/sermon_model.dart';

abstract class SampleStates extends Equatable {}

class InitialSampleState extends SampleStates {
  @override
  List<Object?> get props => [];
}

class SamplesLoaded extends SampleStates {
  final List<SermonModel> samples;
  SamplesLoaded(this.samples);
  @override
  List<Object?> get props => [samples];
}

class ErrorSampleState extends SampleStates {
  final String error;
  ErrorSampleState(this.error);
  @override
  List<Object?> get props => [error];
}
