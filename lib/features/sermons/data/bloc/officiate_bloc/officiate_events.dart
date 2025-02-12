import 'package:equatable/equatable.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';

abstract class OfficiateEvents extends Equatable {}

class LoadOficiate extends OfficiateEvents {
  @override
  List<Object?> get props => [];
}

class SaveOfficateEvent extends OfficiateEvents {
  final SampleModel officiate;
  SaveOfficateEvent(this.officiate);
  @override
  List<Object?> get props => [officiate];
}
