import 'package:equatable/equatable.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

import '../../models/sample_model.dart';

abstract class SampleStates extends Equatable {}

class InitialSampleState extends SampleStates {
  @override
  List<Object?> get props => [];
}

class SamplesLoaded extends SampleStates {
  final List<SampleModel> samples;
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
