import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/theme/data/bloc/theme_states.dart';
import 'package:icgc/features/theme/data/models/theme_model.dart';

import 'theme_events.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc() : super(InitialThemeState()) {
    on<LoadThemes>(
      (event, emit) {
        emit(ThemeLoadedState(ThemeModel.themesMock));
      },
    );
  }
}
