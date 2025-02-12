import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/app/cache/cache_keys.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_events.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_states.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';

class OfficiateBloc extends Bloc<OfficiateEvents, OfficiateStates> {
  OfficiateBloc() : super(InitialOfficiateState()) {
    final box = Hive.box<SampleModel>(CacheKeys.officiate);
    on<LoadOficiate>(
      (event, emit) {
         final officiateList = box.values.toList();
        emit(OfficiateLoaded(officiateList));
      },
    );

    on<SaveOfficateEvent>(
      (event, emit) async {
        try {
          await box.add(event.officiate);
          emit(OfficiateProcessingDoneState('Saved'));
        } on Exception catch (e) {
          emit(ErrorOfficiateState('Something went wrong'));
        }
        add(LoadOficiate());
      },
    );
  }
}
