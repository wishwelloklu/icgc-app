import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/prayer/data/bloc/prayer_states.dart';
import 'package:icgc/features/prayer/data/prayer_model.dart';

import 'prayer_events.dart';

class PrayerBloc extends Bloc<PrayerEvents, PrayerStates> {
  PrayerBloc() : super(InitialPrayerState()) {
    on<LoadPrayer>(
      (event, emit) {
        emit(PrayerLoadedState(PrayerModel.mockData));
      },
    );
  }
}
