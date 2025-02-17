import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/others/data/bloc/prayer_states.dart';
import 'package:icgc/features/others/data/model/others_model.dart';

import 'others_events.dart';

class OthersBloc extends Bloc<OthersEvents, OthersStates> {
  OthersBloc() : super(InitialOthersState()) {
    on<LoadOthers>(
      (event, emit) {
        emit(OthersLoadedState(OthersModel.mockData));
      },
    );
  }
}
