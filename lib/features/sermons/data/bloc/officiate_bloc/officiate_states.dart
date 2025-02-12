import 'package:equatable/equatable.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

import '../../models/sample_model.dart';

abstract class OfficiateStates extends Equatable {}

class InitialOfficiateState extends OfficiateStates {
  @override
  List<Object?> get props => [];
}

class OfficiateLoaded extends OfficiateStates {
  final List<SampleModel> samples;
  OfficiateLoaded(this.samples);
  @override
  List<Object?> get props => [samples];
}

class ErrorOfficiateState extends OfficiateStates {
  final String error;
  ErrorOfficiateState(this.error);
  @override
  List<Object?> get props => [error];
}

final class OfficiateProcessingDoneState extends OfficiateStates {
  final String message;
  OfficiateProcessingDoneState(this.message);
  @override
  List<Object?> get props => [message];
}
