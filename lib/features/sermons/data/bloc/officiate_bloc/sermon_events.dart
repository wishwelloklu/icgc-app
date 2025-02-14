import 'package:equatable/equatable.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';

abstract class SermonEvents extends Equatable {}

class LoadSermon extends SermonEvents {
  @override
  List<Object?> get props => [];
}

class SaveSermonEvent extends SermonEvents {
  final SermonModel sermon;
  SaveSermonEvent(this.sermon);
  @override
  List<Object?> get props => [sermon];
}

class UpdateSermon extends SermonEvents {
  final SermonModel sermon;
  UpdateSermon(
    this.sermon,
  );
  @override
  List<Object?> get props => [sermon];
}

class DeleteSermon extends SermonEvents {
  final SermonModel sermon;

  DeleteSermon(this.sermon);
  @override
  List<Object?> get props => [sermon];
}
