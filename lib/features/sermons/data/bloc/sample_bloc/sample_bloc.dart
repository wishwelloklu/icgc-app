import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_events.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_states.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';

class SampleBloc extends Bloc<SampleEvents, SampleStates> {
  SampleBloc() : super(InitialSampleState()) {
    on<LoadSample>(
      (event, emit) {
        emit(SamplesLoaded(SampleModel.sampleMock));
      },
    );
  }
}
