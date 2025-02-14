import 'package:equatable/equatable.dart';
import 'package:icgc/features/notifications/data/models/notification.dart';

import '../../models/sermon_model.dart';

abstract class SermonStates extends Equatable {}

class InitialSermonState extends SermonStates {
  @override
  List<Object?> get props => [];
}

class SermonLoaded extends SermonStates {
  final List<SermonModel> sermons;
  SermonLoaded(this.sermons);
  @override
  List<Object?> get props => [sermons];
}

class ErrorSermonState extends SermonStates {
  final String error;
  ErrorSermonState(this.error);
  @override
  List<Object?> get props => [error];
}

final class SermonProcessingDoneState extends SermonStates {
  final String message;
  SermonProcessingDoneState(this.message);
  @override
  List<Object?> get props => [message];
}
